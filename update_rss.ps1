# update_rss.ps1
# Busca feeds RSS de IA, detecta artigos novos e atualiza o banco de dados local.

$DbPath    = "$PSScriptRoot\rss_articles.json"
$JsPath    = "$PSScriptRoot\rss_data.js"
$Today     = (Get-Date).ToString("yyyy-MM-dd")
$utf8NoBom = New-Object System.Text.UTF8Encoding $false

$Feeds = @(
[PSCustomObject]@{ sourceId = 'venturebeat'; aiOnly = $true;  fallback = $null
                       url = 'https://venturebeat.com/category/ai/feed/' },
    [PSCustomObject]@{ sourceId = 'mit';         aiOnly = $false; fallback = $null
                       url = 'https://www.technologyreview.com/feed/' },
    [PSCustomObject]@{ sourceId = 'mckinsey';    aiOnly = $false;
                       url      = 'https://www.mckinsey.com/insights/rss'
                       fallback = 'https://news.google.com/rss/search?q=site:mckinsey.com+%22artificial+intelligence%22&hl=pt-BR&gl=BR&ceid=BR:pt-419' }
)

# ── 1. Carregar histórico ──────────────────────────────────────────────────────
if (Test-Path $DbPath) {
    $dbRaw  = [System.IO.File]::ReadAllText($DbPath, [System.Text.Encoding]::UTF8).TrimStart([char]0xFEFF)
    $dbList = $dbRaw | ConvertFrom-Json
} else {
    $dbList = @()
}
$db = @{}
foreach ($item in $dbList) { $db[$item.url] = $item }

# ── 2. Funções auxiliares ──────────────────────────────────────────────────────
function Get-NodeText($node) {
    if ($null -eq $node) { return '' }
    if ($node -is [System.Xml.XmlElement]) { return $node.InnerText }
    return [string]$node
}

function Test-AiRelevant($title, $summary, $aiOnly) {
    if ($aiOnly) { return $true }
    $text = ("$title $summary").ToLower()
    return $text -match '\bai\b|artificial intelligence|machine learning|llm|generative|agentic|chatgpt|openai|anthropic|gemini'
}

function Invoke-ParseFeed($xmlText, $sourceId, $aiOnly) {
    $xml   = [xml]$xmlText
    $items = $xml.SelectNodes('//item')

    foreach ($item in $items) {
        $title = (Get-NodeText $item.SelectSingleNode('title')).Trim()
        if (-not $title) { continue }

        $url = (Get-NodeText $item.SelectSingleNode('link')).Trim()
        if (-not $url -or -not $url.StartsWith('http')) {
            $url = (Get-NodeText $item.SelectSingleNode('guid')).Trim()
            if (-not $url -or -not $url.StartsWith('http')) { continue }
        }

        $desc    = Get-NodeText $item.SelectSingleNode('description')
        $summary = [System.Text.RegularExpressions.Regex]::Replace($desc, '<[^>]+>', '').Trim()
        if ($summary.Length -gt 400) { $summary = $summary.Substring(0, 397) + '...' }

        $pubStr = (Get-NodeText $item.SelectSingleNode('pubDate')).Trim()
        try {
            $pubDate = [DateTime]::Parse($pubStr, [System.Globalization.CultureInfo]::InvariantCulture).ToString('yyyy-MM-dd')
        } catch { $pubDate = $Today }

        if (-not (Test-AiRelevant $title $summary $aiOnly)) { continue }

        [PSCustomObject]@{ title = $title; url = $url; summary = $summary; sourceId = $sourceId; pubDate = $pubDate }
    }
}

# ── 3. Buscar e processar feeds ────────────────────────────────────────────────
$totalNew = 0
$reqHeaders = @{ 'User-Agent' = 'Mozilla/5.0 (compatible; AIRadar/1.0)' }

foreach ($feed in $Feeds) {
    Write-Host "[$($feed.sourceId)] Buscando $($feed.url) ..." -ForegroundColor Cyan

    $xmlText = $null
    try {
        $resp    = Invoke-WebRequest -Uri $feed.url -Headers $reqHeaders -TimeoutSec 20 -UseBasicParsing
        $xmlText = $resp.Content
        if ($xmlText.Length -lt 200 -or $xmlText -notmatch '<(rss|feed|channel)') { $xmlText = $null }
    } catch {
        Write-Host "  ! Direto falhou: $($_.Exception.Message)" -ForegroundColor Yellow
    }

    if (-not $xmlText -and $feed.fallback) {
        Write-Host "  Tentando fallback Google News..." -ForegroundColor Yellow
        try {
            $resp    = Invoke-WebRequest -Uri $feed.fallback -Headers $reqHeaders -TimeoutSec 20 -UseBasicParsing
            $xmlText = $resp.Content
        } catch {
            Write-Host "  ! Fallback falhou: $($_.Exception.Message)" -ForegroundColor Red
        }
    }

    if (-not $xmlText -or $xmlText.Length -lt 200) {
        Write-Host "  ! Sem dados para [$($feed.sourceId)]" -ForegroundColor Red
        continue
    }

    try {
        $items = @(Invoke-ParseFeed $xmlText $feed.sourceId $feed.aiOnly)
    } catch {
        Write-Host "  ! Erro ao parsear XML: $_" -ForegroundColor Red
        continue
    }

    $feedNew = 0
    foreach ($item in $items) {
        if ($db.ContainsKey($item.url)) { continue }
        $entry = [PSCustomObject]@{
            title      = $item.title
            url        = $item.url
            summary    = $item.summary
            source_id  = $item.sourceId
            first_seen = $Today
            pub_date   = $item.pubDate
        }
        $db[$item.url] = $entry
        $feedNew++
    }

    Write-Host "  + $feedNew novo(s) de $($items.Count) no feed" -ForegroundColor Green
    $totalNew += $feedNew
}

# ── 4. Salvar histórico ────────────────────────────────────────────────────────
$sorted = $db.Values | Sort-Object pub_date -Descending
[System.IO.File]::WriteAllText($DbPath, ($sorted | ConvertTo-Json -Depth 5), $utf8NoBom)

# ── 5. Gerar rss_data.js para o site ──────────────────────────────────────────
$jsonArray = $sorted | Select-Object title, title_pt, url, summary, summary_pt, source_id, first_seen, pub_date | ConvertTo-Json -Compress
[System.IO.File]::WriteAllText($JsPath, "window.RSS_ARTICLES = $jsonArray;", $utf8NoBom)

Write-Host ""
Write-Host "=== RSS: $($sorted.Count) artigos no historico ($totalNew novos) ===" -ForegroundColor Cyan
Write-Host ""
$sorted | Select-Object -First 15 | ForEach-Object {
    $short = if ($_.title.Length -gt 70) { $_.title.Substring(0, 67) + '...' } else { $_.title }
    Write-Host "$($_.pub_date)  |  [$($_.source_id)]  $short"
}
