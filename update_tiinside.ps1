# update_tiinside.ps1
# Busca artigos de IA do TIInside usando Firecrawl.
#
# Modo normal (execucao diaria): busca artigos publicados a partir de hoje.
# Modo backfill: busca artigos a partir de uma data inicial.
#
# Uso:
#   .\update_tiinside.ps1                          # artigos de hoje em diante
#   .\update_tiinside.ps1 -CutoffDate "2026-06-01" # backfill desde 01/06

param(
    [string]$FirecrawlKey = $env:FIRECRAWL_API_KEY,
    [string]$CutoffDate   = (Get-Date).ToString("yyyy-MM-dd")
)

if (-not $FirecrawlKey) { $FirecrawlKey = "fc-32d2207f249a4b808c42f6eba17900bb" }
$FirecrawlKey = $FirecrawlKey.Trim().TrimStart([char]0xFEFF)

$ListingUrl = "https://tiinside.com.br/top-news/inteligencia-artificial/"
$RssDbPath  = "$PSScriptRoot\rss_articles.json"
$RssJsPath  = "$PSScriptRoot\rss_data.js"
$Today      = (Get-Date).ToString("yyyy-MM-dd")
$utf8NoBom  = New-Object System.Text.UTF8Encoding $false
$Headers    = @{ "Authorization" = "Bearer $FirecrawlKey"; "Content-Type" = "application/json" }

Write-Host "=== TIInside: buscando artigos (data >= $CutoffDate) ===" -ForegroundColor Magenta

# ── 1. Carregar banco existente ────────────────────────────────────────────────
if (Test-Path $RssDbPath) {
    $dbRaw  = [System.IO.File]::ReadAllText($RssDbPath, [System.Text.Encoding]::UTF8).TrimStart([char]0xFEFF)
    $dbList = [System.Collections.Generic.List[PSCustomObject]]::new()
    foreach ($item in ($dbRaw | ConvertFrom-Json)) { $dbList.Add($item) }
} else {
    $dbList = [System.Collections.Generic.List[PSCustomObject]]::new()
}
$existingUrls = @{}
foreach ($a in $dbList) { $existingUrls[$a.url] = $true }

# ── 2. Buscar lista de artigos do TIInside ─────────────────────────────────────
$listBody = @{ url = $ListingUrl; formats = @("links"); onlyMainContent = $false } | ConvertTo-Json
try {
    $listResp = Invoke-RestMethod -Uri "https://api.firecrawl.dev/v1/scrape" `
        -Method POST -Headers $Headers -Body $listBody -TimeoutSec 45
} catch {
    Write-Host "  [!] Erro ao buscar listing do TIInside: $($_.Exception.Message)" -ForegroundColor Red
    exit 0
}

# ── 3. Filtrar URLs de artigos por data ─────────────────────────────────────────
# Pattern de URL: https://tiinside.com.br/DD/MM/YYYY/slug/
$candidatos = @()
foreach ($url in $listResp.data.links) {
    if ($url -match 'tiinside\.com\.br/(\d{2})/(\d{2})/(\d{4})/[^/]+/$') {
        $pubDate = "$($Matches[3])-$($Matches[2])-$($Matches[1])"
        if ($pubDate -ge $CutoffDate -and -not $existingUrls.ContainsKey($url)) {
            $candidatos += [PSCustomObject]@{ url = $url; pub_date = $pubDate }
        }
    }
}

# Deduplicar por URL
$candidatos = $candidatos | Sort-Object url -Unique

Write-Host "  $($candidatos.Count) artigo(s) novo(s) encontrado(s) para processar" -ForegroundColor Cyan

# ── 4. Scraping individual de cada artigo ──────────────────────────────────────
$added = 0
foreach ($item in ($candidatos | Sort-Object pub_date)) {
    $url     = $item.url
    $pubDate = $item.pub_date

    # Slug para exibicao no log
    $slug = ($url -split '/')[-2]
    Write-Host "  [$pubDate] $($slug.Substring(0, [Math]::Min(65, $slug.Length)))..." -ForegroundColor Cyan

    $artBody = @{
        url             = $url
        formats         = @("markdown", "summary")
        onlyMainContent = $true
    } | ConvertTo-Json

    try {
        $artResp = Invoke-RestMethod -Uri "https://api.firecrawl.dev/v1/scrape" `
            -Method POST -Headers $Headers -Body $artBody -TimeoutSec 45
    } catch {
        Write-Host "    [!] Firecrawl falhou: $($_.Exception.Message)" -ForegroundColor Red
        Start-Sleep -Seconds 2
        continue
    }

    $md    = $artResp.data.markdown
    $title = ($artResp.data.metadata.title -replace '\s*\|.*$', '').Trim()

    if (-not $title -or $title.Length -lt 5) {
        Write-Host "    [!] Sem titulo valido, pulando." -ForegroundColor Yellow
        continue
    }

    # Extrair corpo do artigo do markdown (ja esta em PT-BR, sem traducao necessaria)
    # O marcador "[More]" separa os botoes de share do inicio do artigo
    $bodyMd = $md

    # Limite final: antes de "ARTIGOS RELACIONADOS"
    $endIdx = $bodyMd.IndexOf('ARTIGOS RELACIONADOS')
    if ($endIdx -gt 0) { $bodyMd = $bodyMd.Substring(0, $endIdx) }

    # Limite inicial: apos a linha com "[More]" (botao de compartilhar = fim do cabecalho)
    $moreIdx = $bodyMd.IndexOf('[More](')
    if ($moreIdx -gt 0) {
        $lineEnd = $bodyMd.IndexOf("`n", $moreIdx)
        if ($lineEnd -gt 0) { $bodyMd = $bodyMd.Substring($lineEnd + 1) }
    }

    # Filtrar linhas: manter apenas paragrafo real, remover imagens/links/nav
    $bodyLines = @()
    foreach ($line in ($bodyMd -split "`n")) {
        $t = $line.Trim()
        if ($t.Length -lt 25)              { continue }  # muito curta
        if ($t -match '!\[')               { continue }  # imagem markdown
        if ($t -match 'data:image')        { continue }  # data URI
        if ($t -match 'tiinside\.com\.br') { continue }  # links internos de nav
        # Linhas que sao apenas um link ou item de lista com link externo
        if ($t -match '^\s*[\-\*]\s*\[' -and $t -match '\]\(https?://')  { continue }
        if ($t -match '^\[' -and $t -match '\]\(https?://')              { continue }
        $bodyLines += $t
    }

    $articleBody = ($bodyLines -join "`n").Trim()

    # summary: primeira linha do corpo (para card do feed, max 400 chars)
    $shortSummary = if ($bodyLines.Count -gt 0) { $bodyLines[0] } else { "" }
    if ($shortSummary.Length -gt 400) { $shortSummary = $shortSummary.Substring(0, 397) + "..." }

    # summary_pt: corpo completo em PT-BR (para painel de leitura, max 3000 chars)
    $summaryPt = $articleBody
    if ($summaryPt.Length -gt 3000) { $summaryPt = $summaryPt.Substring(0, 2997) + "..." }

    $entry = [PSCustomObject]@{
        title      = $title
        title_pt   = $title
        url        = $url
        summary    = $shortSummary
        summary_pt = $summaryPt
        source_id  = "tiinside"
        first_seen = $Today
        pub_date   = $pubDate
    }

    $dbList.Add($entry)
    $existingUrls[$url] = $true
    $added++
    Write-Host "    [OK] $title" -ForegroundColor Green

    Start-Sleep -Milliseconds 1200
}

# ── 5. Salvar banco e regenerar JS ────────────────────────────────────────────
if ($added -gt 0) {
    $sorted = $dbList | Sort-Object pub_date -Descending
    [System.IO.File]::WriteAllText($RssDbPath, ($sorted | ConvertTo-Json -Depth 5), $utf8NoBom)
    $rssJs = $sorted | Select-Object title, title_pt, url, summary, summary_pt, source_id, first_seen, pub_date | ConvertTo-Json -Compress
    [System.IO.File]::WriteAllText($RssJsPath, "window.RSS_ARTICLES = $rssJs;", $utf8NoBom)
    Write-Host ""
    Write-Host "=== TIInside: $added artigo(s) adicionado(s) ===" -ForegroundColor Green
} else {
    Write-Host "  Nenhum artigo novo do TIInside." -ForegroundColor Yellow
}
