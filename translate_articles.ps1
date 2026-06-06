# translate_articles.ps1
# Traduz títulos e gera resumos em português para artigos ainda não traduzidos.
# Tenta Claude API (ANTHROPIC_API_KEY) primeiro, depois Gemini (GEMINI_API_KEY) como fallback.
# Requer Firecrawl para extrair o conteúdo completo dos artigos.

param(
    [string]$ClaudeKey    = $env:ANTHROPIC_API_KEY,
    [string]$GeminiKey    = $env:GEMINI_API_KEY,
    [string]$FirecrawlKey = $env:FIRECRAWL_API_KEY,
    [int]$MaxArticles = 999
)

if (-not $FirecrawlKey) { $FirecrawlKey = "fc-32d2207f249a4b808c42f6eba17900bb" }
$FirecrawlKey = $FirecrawlKey.Trim().TrimStart([char]0xFEFF)
if ($GeminiKey)  { $GeminiKey  = $GeminiKey.Trim().TrimStart([char]0xFEFF) }
if ($ClaudeKey)  { $ClaudeKey  = $ClaudeKey.Trim().TrimStart([char]0xFEFF) }

if (-not $ClaudeKey -and -not $GeminiKey) {
    Write-Host "AVISO: Nenhuma API key de traducao configurada (ANTHROPIC_API_KEY ou GEMINI_API_KEY)." -ForegroundColor Yellow
    Write-Host "       Configure ao menos uma nas secrets do GitHub Actions para habilitar traducao automatica." -ForegroundColor Yellow
    exit 0
}

$RssDbPath     = "$PSScriptRoot\rss_articles.json"
$GartnerDbPath = "$PSScriptRoot\gartner_articles.json"
$RssJsPath     = "$PSScriptRoot\rss_data.js"
$GartnerJsPath = "$PSScriptRoot\gartner_data.js"
$utf8NoBom     = New-Object System.Text.UTF8Encoding $false

$TranslationPrompt = @'
Voce e um analista especializado em tecnologia e inteligencia artificial.

Titulo original do artigo: "{TITLE}"

Conteudo do artigo:
{CONTENT}

Tarefas:
1. Traduza o titulo para portugues do Brasil de forma natural e precisa.
2. Escreva um resumo estruturado em portugues do Brasil usando o formato abaixo:

FORMATO DO RESUMO (use exatamente esta estrutura de markdown):
- Use **Titulo da Secao** em uma linha separada para cada bloco tematico (2 a 4 secoes)
- Abaixo de cada titulo, use bullets "- " para os pontos principais (2 a 4 bullets por secao)
- Use **negrito** inline para destacar numeros, nomes de empresas, conceitos-chave e dados relevantes
- Cubra: contexto e relevancia, principais dados/descobertas, implicacoes praticas para lideres

Responda APENAS com JSON valido neste formato (sem markdown externo, sem explicacoes):
{"title_pt":"...","summary_pt":"..."}
'@

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

# ── Traduz via Claude API (Anthropic) ─────────────────────────────────────────
function Get-TranslationClaude($title, $markdown) {
    $url     = "https://api.anthropic.com/v1/messages"
    $headers = @{
        "x-api-key"         = $ClaudeKey
        "anthropic-version" = "2023-06-01"
        "content-type"      = "application/json"
    }

    $excerpt = if ($markdown.Length -gt 8000) { $markdown.Substring(0, 8000) } else { $markdown }
    $prompt  = $TranslationPrompt -replace '\{TITLE\}', $title -replace '\{CONTENT\}', $excerpt

    $body = @{
        model      = "claude-haiku-4-5-20251001"
        max_tokens = 1500
        messages   = @(@{ role = "user"; content = $prompt })
    } | ConvertTo-Json -Depth 10

    try {
        $resp   = Invoke-RestMethod -Uri $url -Method POST -Headers $headers -Body $body -TimeoutSec 60
        $raw    = $resp.content[0].text.Trim()
        $raw    = $raw -replace '^```json\s*', '' -replace '\s*```$', ''
        $parsed = $raw | ConvertFrom-Json
        if ($parsed.title_pt -and $parsed.summary_pt) { return $parsed }
    } catch {
        Write-Host "  [!] Claude API falhou: $($_.Exception.Message)" -ForegroundColor Red
    }
    return $null
}

# Flag de cota esgotada — compartilhada entre chamadas
$script:GeminiQuotaExhausted = $false

# ── Traduz via Gemini API (Google AI Studio) ──────────────────────────────────
# Gemini free tier: 15 RPM e cota diária limitada.
# Estratégia: 1 retry de 65s (suficiente para reset de rate limit por minuto).
# Se ainda 429 após retry, a cota DIÁRIA está esgotada → para tudo imediatamente.
function Get-TranslationGemini($title, $markdown) {
    if ($script:GeminiQuotaExhausted) { return $null }

    $url     = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$GeminiKey"
    $headers = @{ "Content-Type" = "application/json" }

    $excerpt = if ($markdown.Length -gt 8000) { $markdown.Substring(0, 8000) } else { $markdown }
    $prompt  = $TranslationPrompt -replace '\{TITLE\}', $title -replace '\{CONTENT\}', $excerpt

    $body = @{
        contents         = @(@{ parts = @(@{ text = $prompt }) })
        generationConfig = @{ temperature = 0.3; maxOutputTokens = 1500 }
    } | ConvertTo-Json -Depth 10

    for ($attempt = 1; $attempt -le 2; $attempt++) {
        try {
            $resp   = Invoke-RestMethod -Uri $url -Method POST -Headers $headers -Body $body -TimeoutSec 60
            $raw    = $resp.candidates[0].content.parts[0].text.Trim()
            $raw    = $raw -replace '^```json\s*', '' -replace '\s*```$', ''
            $parsed = $raw | ConvertFrom-Json
            if ($parsed.title_pt -and $parsed.summary_pt) { return $parsed }
        } catch {
            $msg = $_.Exception.Message
            if ($msg -match '429') {
                if ($attempt -eq 1) {
                    Write-Host "  [429] Rate limit Gemini. Aguardando 65s..." -ForegroundColor Yellow
                    Start-Sleep -Seconds 65
                } else {
                    Write-Host "  [!] Cota diaria do Gemini esgotada. Artigos restantes serao traduzidos amanha." -ForegroundColor Red
                    $script:GeminiQuotaExhausted = $true
                    return $null
                }
            } else {
                Write-Host "  [!] Gemini API falhou: $msg" -ForegroundColor Red
                return $null
            }
        }
    }
    return $null
}

# ── Tenta Claude primeiro, depois Gemini como fallback ────────────────────────
function Get-Translation($title, $markdown) {
    if ($ClaudeKey) {
        Write-Host "    Traduzindo via Claude..." -ForegroundColor DarkGray
        $result = Get-TranslationClaude $title $markdown
        if ($result) { return $result }
        Write-Host "    Tentando Gemini como fallback..." -ForegroundColor DarkGray
    }
    if ($GeminiKey) {
        $result = Get-TranslationGemini $title $markdown
        if ($result) { return $result }
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

        # Para imediatamente se a cota diária do Gemini foi esgotada e não há Claude
        if ($script:GeminiQuotaExhausted -and -not $ClaudeKey) {
            Write-Host "  Cota Gemini esgotada. Interrompendo — restantes traduzidos no proximo run." -ForegroundColor Yellow
            break
        }

        $md = Get-ArticleMarkdown $art.url
        if (-not $md) { Start-Sleep -Seconds 2; continue }

        $result = Get-Translation $art.title $md
        if ($result) {
            $art | Add-Member -NotePropertyName title_pt   -NotePropertyValue $result.title_pt   -Force
            $art | Add-Member -NotePropertyName summary_pt -NotePropertyValue $result.summary_pt -Force
            Write-Host "  [OK] $($result.title_pt.Substring(0,[Math]::Min(65,$result.title_pt.Length)))" -ForegroundColor Green
            $count++
        }
        # Gemini free tier: 15 RPM → 4s mínimo; Claude suporta cadência maior
        $sleepMs = if ($ClaudeKey) { 1000 } else { 5000 }
        Start-Sleep -Milliseconds $sleepMs
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
