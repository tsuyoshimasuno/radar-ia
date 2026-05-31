# update_gartner.ps1
# Raspa a página Gartner AI, detecta artigos novos e atualiza o banco de dados local.

$ApiKey  = if ($env:FIRECRAWL_API_KEY) { $env:FIRECRAWL_API_KEY } else { "fc-32d2207f249a4b808c42f6eba17900bb" }
$DbPath  = "$PSScriptRoot\gartner_articles.json"
$Today   = (Get-Date).ToString("yyyy-MM-dd")
$GartnerUrl = "https://www.gartner.com/en/ai?_gl=1*1n0kt1g*_ga*MTE2MTQ2MjI3Ni4xNzgwMTcyNDY2*_ga_R1W5CE5FEV*czE3ODAyNDY2MDckbzIkZzAkdDE3ODAyNDY2MDckajYwJGwwJGgw"

# ── 1. Carregar banco de dados existente ─────────────────────────────────────
if (Test-Path $DbPath) {
    $dbRaw  = [System.IO.File]::ReadAllText($DbPath, [System.Text.Encoding]::UTF8).TrimStart([char]0xFEFF)
    $dbList = $dbRaw | ConvertFrom-Json
} else {
    $dbList = @()
}

$db = @{}
foreach ($item in $dbList) {
    $db[$item.url] = $item
}

# ── 2. Raspar página com Firecrawl ───────────────────────────────────────────
Write-Host "Raspando $GartnerUrl ..." -ForegroundColor Cyan

$headers = @{
    "Authorization" = "Bearer $ApiKey"
    "Content-Type"  = "application/json"
}
$body = @{
    url            = $GartnerUrl
    formats        = @("markdown")
    onlyMainContent = $true
} | ConvertTo-Json

try {
    $response = Invoke-RestMethod -Uri "https://api.firecrawl.dev/v1/scrape" `
                    -Method POST -Headers $headers -Body $body -TimeoutSec 60
} catch {
    Write-Host "Erro ao chamar Firecrawl: $_" -ForegroundColor Red
    exit 1
}

# Corrige double-encoding UTF-8 (PS5.1 decodifica UTF-8 como Windows-1252 em alguns casos)
$markdown = $response.data.markdown
$markdown = $markdown -replace ([char]0x00E2 + [char]0x20AC + [char]0x201D), [char]0x2014  # EM DASH
$markdown = $markdown -replace ([char]0x00E2 + [char]0x20AC + [char]0x201C), [char]0x2013  # EN DASH

# ── 3. Extrair artigos (tipo "Article" + URL /en/articles/) ──────────────────
# Padrão: bloco que começa com "Article" (label), tem título em **...** e URL /en/articles/
$pattern = '(?s)Article[^[]*?\*\*(.+?)\*\*.*?Read Now\]\((https://www\.gartner\.com/en/articles/[^)]+)\)'
$found   = [regex]::Matches($markdown, $pattern)

$newArticles = @()

foreach ($match in $found) {
    $title = $match.Groups[1].Value.Trim()
    $url   = $match.Groups[2].Value.Trim()

    if (-not $db.ContainsKey($url)) {
        $entry = [PSCustomObject]@{
            title      = $title
            url        = $url
            first_seen = $Today
        }
        $db[$url]    = $entry
        $newArticles += $entry
        Write-Host "  + NOVO: $title" -ForegroundColor Green
    }
}

if ($newArticles.Count -eq 0) {
    Write-Host "Nenhum artigo novo encontrado." -ForegroundColor Yellow
}

# ── 4. Salvar banco de dados atualizado ──────────────────────────────────────
$utf8NoBom = New-Object System.Text.UTF8Encoding $false
$sorted    = $db.Values | Sort-Object first_seen -Descending
$dbJson    = $sorted | ConvertTo-Json -Depth 5
[System.IO.File]::WriteAllText($DbPath, $dbJson, $utf8NoBom)

# ── 5. Gerar gartner_data.js para o site ─────────────────────────────────────
$JsPath    = "$PSScriptRoot\gartner_data.js"
$jsonArray = $sorted | Select-Object title, title_pt, url, summary_pt, first_seen | ConvertTo-Json -Compress
[System.IO.File]::WriteAllText($JsPath, "window.GARTNER_ARTICLES = $jsonArray;", $utf8NoBom)
Write-Host "gartner_data.js atualizado ($($sorted.Count) artigos)." -ForegroundColor Cyan

Write-Host ""
Write-Host "=== Base de artigos Gartner AI ($($sorted.Count) artigos) ===" -ForegroundColor Cyan
Write-Host ""

$sorted | ForEach-Object {
    Write-Host "$($_.first_seen)  |  $($_.title)  |  $($_.url)"
}
