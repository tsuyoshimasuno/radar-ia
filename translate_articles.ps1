# translate_articles.ps1
# Traduz títulos e gera resumos em português para artigos ainda não traduzidos.
# Requer: $env:GEMINI_API_KEY definida (Google AI Studio - gratuito).

param(
    [string]$GeminiKey    = $env:GEMINI_API_KEY,
    [string]$FirecrawlKey = $env:FIRECRAWL_API_KEY,
    [int]$MaxArticles = 999
)

if (-not $FirecrawlKey) { $FirecrawlKey = "fc-32d2207f249a4b808c42f6eba17900bb" }

if (-not $GeminiKey) {
    Write-Host "ERRO: defina a variavel GEMINI_API_KEY ou passe -GeminiKey 'AIza...'" -ForegroundColor Red
    exit 1
}

$RssDbPath     = "$PSScriptRoot\rss_articles.json"
$GartnerDbPath = "$PSScriptRoot\gartner_articles.json"
$RssJsPath     = "$PSScriptRoot\rss_data.js"
$GartnerJsPath = "$PSScriptRoot\gartner_data.js"
$utf8NoBom     = New-Object System.Text.UTF8Encoding $false

# ── Busca conteúdo do artigo via Firecrawl ────────────────────────────────────
function Get-ArticleMarkdown($url) {
    $headers = @{ "Authorization" = "Bearer $FirecrawlKey"; "Content-Type" = "application/json" }
    $body    = @{ url = $url; formats = @("markdown"); onlyMainContent = $true } | ConvertTo-Json
    try {
        $resp = Invoke-RestMethod -Uri "https://api.firecrawl.dev/v1/scrape" `
            -Method POST -Headers $headers -Body $body -TimeoutSec 45
        return $resp.data.markdown
    } catch {
        Write-Host "  [!] Firecrawl falhou: $($_.Exception.Message)" -ForegroundColor Red
        return $null
    }
}

# ── Traduz e resume via Gemini API (Google AI Studio - gratuito) ──────────────
function Get-Translation($title, $markdown) {
    $url     = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$GeminiKey"
    $headers = @{ "Content-Type" = "application/json" }

    $excerpt = if ($markdown.Length -gt 8000) { $markdown.Substring(0, 8000) } else { $markdown }

    $prompt = @"
Você é um analista especializado em tecnologia e inteligência artificial.

Título original do artigo: "$title"

Conteúdo do artigo:
$excerpt

Tarefas:
1. Traduza o título para português do Brasil de forma natural e precisa.
2. Escreva um resumo detalhado em português do Brasil com 3 a 5 parágrafos cobrindo:
   - Contexto e relevância do tema
   - Principais argumentos, dados ou descobertas apresentados
   - Implicações práticas para empresas e líderes de tecnologia
   - Conclusão ou posicionamento do autor

Responda APENAS com JSON válido neste formato (sem markdown, sem explicações):
{"title_pt":"...","summary_pt":"..."}
"@

    $body = @{
        contents        = @(@{ parts = @(@{ text = $prompt }) })
        generationConfig = @{ temperature = 0.3; maxOutputTokens = 1500 }
    } | ConvertTo-Json -Depth 10

    try {
        $resp   = Invoke-RestMethod -Uri $url -Method POST -Headers $headers -Body $body -TimeoutSec 60
        $raw    = $resp.candidates[0].content.parts[0].text.Trim()
        $raw    = $raw -replace '^```json\s*', '' -replace '\s*```$', ''
        $parsed = $raw | ConvertFrom-Json
        if ($parsed.title_pt -and $parsed.summary_pt) { return $parsed }
    } catch {
        Write-Host "  [!] Gemini API falhou: $($_.Exception.Message)" -ForegroundColor Red
    }
    return $null
}

# ── Processa uma lista de artigos ─────────────────────────────────────────────
function Invoke-TranslateArticles($articles, $label) {
    $count = 0
    foreach ($art in $articles) {
        if ($art.title_pt) { continue }
        if ($count -ge $MaxArticles) { break }

        Write-Host "[$label] $($art.title.Substring(0, [Math]::Min(65,$art.title.Length)))..." -ForegroundColor Cyan

        $md = Get-ArticleMarkdown $art.url
        if (-not $md) { Start-Sleep -Seconds 2; continue }

        $result = Get-Translation $art.title $md
        if ($result) {
            $art | Add-Member -NotePropertyName title_pt   -NotePropertyValue $result.title_pt   -Force
            $art | Add-Member -NotePropertyName summary_pt -NotePropertyValue $result.summary_pt -Force
            Write-Host "  [OK] $($result.title_pt.Substring(0,[Math]::Min(65,$result.title_pt.Length)))" -ForegroundColor Green
            $count++
        }
        Start-Sleep -Milliseconds 600
    }
    return $count
}

# ── RSS ───────────────────────────────────────────────────────────────────────
Write-Host "=== Traduzindo artigos RSS ===" -ForegroundColor Magenta
$rssRaw  = [System.IO.File]::ReadAllText($RssDbPath, [System.Text.Encoding]::UTF8).TrimStart([char]0xFEFF)
$rssArr  = @($rssRaw | ConvertFrom-Json)
$rssNew  = Invoke-TranslateArticles $rssArr "RSS"

$rssSorted = $rssArr | Sort-Object pub_date -Descending
[System.IO.File]::WriteAllText($RssDbPath, ($rssSorted | ConvertTo-Json -Depth 5), $utf8NoBom)
$rssJs = $rssSorted | Select-Object title, title_pt, url, summary, summary_pt, source_id, first_seen, pub_date | ConvertTo-Json -Compress
[System.IO.File]::WriteAllText($RssJsPath, "window.RSS_ARTICLES = $rssJs;", $utf8NoBom)

# ── Gartner ───────────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "=== Traduzindo artigos Gartner ===" -ForegroundColor Magenta
$gartnerRaw = [System.IO.File]::ReadAllText($GartnerDbPath, [System.Text.Encoding]::UTF8).TrimStart([char]0xFEFF)
$gartnerArr = @($gartnerRaw | ConvertFrom-Json)
$gartnerNew = Invoke-TranslateArticles $gartnerArr "Gartner"

$gartnerSorted = $gartnerArr | Sort-Object first_seen -Descending
[System.IO.File]::WriteAllText($GartnerDbPath, ($gartnerSorted | ConvertTo-Json -Depth 5), $utf8NoBom)
$gartnerJs = $gartnerSorted | Select-Object title, title_pt, url, summary_pt, first_seen | ConvertTo-Json -Compress
[System.IO.File]::WriteAllText($GartnerJsPath, "window.GARTNER_ARTICLES = $gartnerJs;", $utf8NoBom)

Write-Host ""
Write-Host "=== Concluido: $($rssNew + $gartnerNew) artigos traduzidos ===" -ForegroundColor Cyan
