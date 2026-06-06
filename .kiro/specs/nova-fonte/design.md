# Design — Adicionar Nova Fonte de Artigos

## Decisões de design

### Onde os artigos são armazenados
Artigos de novas fontes vão para `rss_articles.json` (mesmo banco que RSS e TIInside), identificados pelo campo `source_id`. Não é necessário criar um JSON separado por fonte.

### Como a fonte é reconhecida no frontend
A fonte precisa ser declarada em `SOURCES[]` em `script.js`. O `SOURCE_MAP` é gerado automaticamente a partir desse array. O `syncArticles()` já lê todos os artigos de `window.RSS_ARTICLES` e usa `source_id` para associar à fonte correta.

### Estratégia de coleta por tipo de fonte
| Tipo | Estratégia | Script base para copiar |
|---|---|---|
| RSS feed | Parsear XML do feed diretamente | `update_rss.ps1` |
| Site com scraping | Firecrawl para extrair conteúdo | `update_tiinside.ps1` |
| Manual | Adicionar direto ao `apply_translations.ps1` | `apply_translations.ps1` |

---

## Componentes a criar/modificar

### 1. `update_NOME.ps1` (novo arquivo)
Script PowerShell responsável por:
- Aceitar `-CutoffDate` e `-FirecrawlKey` como parâmetros
- Carregar `rss_articles.json` e construir set de URLs existentes (deduplicação)
- Buscar artigos novos da fonte (via RSS ou Firecrawl)
- Para cada artigo novo: extrair `title`, `url`, `summary`, `pub_date`
- Para fontes PT-BR: gerar `title_pt` = `title` e `summary_pt` do corpo do artigo
- Para fontes EN: deixar `title_pt` e `summary_pt` em branco (preenchidos pelo `translate_articles.ps1`)
- Salvar `rss_articles.json` e regenerar `rss_data.js`

**Estrutura de entrada em `rss_articles.json`:**
```json
{
  "title":      "...",
  "title_pt":   "..." ou null,
  "url":        "https://...",
  "summary":    "...",
  "summary_pt": "..." ou null,
  "source_id":  "NOME",
  "first_seen": "YYYY-MM-DD",
  "pub_date":   "YYYY-MM-DD"
}
```

### 2. `script.js` — SOURCES[] (modificação)
Adicionar entrada ao array `SOURCES` no início do arquivo:
```javascript
{ id: 'NOME', name: 'Nome Exibido', color: '#HEXCOR', tier: 'auto', rssUrl: null }
```
- `tier`: `'auto'` (script automático), `'rss'` (feed RSS), `'manual'`
- `color`: escolher cor que não conflite com as existentes

Cores já em uso: `#4a9eff` (McKinsey), `#ff6b6b` (MIT), `#8b5cf6` (Anthropic), `#06b6d4` (DeepMind), `#f59e0b` (VentureBeat), `#ffb800` (Gartner), `#e879f9` (Forrester), `#f97316` (SVPG), `#10b981` (TI Inside)

### 3. `.github/workflows/update-articles.yml` (modificação)
Adicionar step ANTES do step de tradução e DEPOIS de `update_gartner.ps1`:
```yaml
- name: Atualizar artigos NOME
  continue-on-error: true
  shell: pwsh
  env:
    FIRECRAWL_API_KEY: ${{ secrets.FIRECRAWL_API_KEY }}
    ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
    GEMINI_API_KEY: ${{ secrets.GEMINI_API_KEY }}
  run: ./update_NOME.ps1
```

---

## Fluxo de dados completo com a nova fonte

```
update_NOME.ps1 roda
    │
    ├── Fonte EN:
    │     artigo adicionado sem title_pt/summary_pt
    │     └── translate_articles.ps1 preenche title_pt + summary_pt via Claude/Gemini
    │
    └── Fonte PT-BR:
          artigo adicionado COM title_pt = title e summary_pt extraído do corpo
          └── translate_articles.ps1 pula (title_pt já preenchido)
                │
                ▼
    rss_data.js regenerado → GitHub Pages serve o site atualizado
```

---

## Convenções de encoding (crítico)
```powershell
$utf8NoBom = New-Object System.Text.UTF8Encoding $false

# Leitura
$raw = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8).TrimStart([char]0xFEFF)

# Escrita
[System.IO.File]::WriteAllText($path, ($data | ConvertTo-Json -Depth 5), $utf8NoBom)

# API Keys — sempre remover BOM
$key = $key.Trim().TrimStart([char]0xFEFF)
```

## Deduplicação de artigos
```powershell
$existingUrls = @{}
foreach ($a in ($raw | ConvertFrom-Json)) { $existingUrls[$a.url] = $true }

# Antes de adicionar:
if (-not $existingUrls.ContainsKey($url)) { ... adicionar ... }
```

## Remoção de artigos do banco (se necessário remover uma fonte futuramente)
```powershell
$all = [System.Collections.Generic.List[PSCustomObject]]::new()
foreach ($item in ($raw | ConvertFrom-Json)) {
    if ($item.source_id -ne 'NOME') { $all.Add($item) }
}
```
> Nota: usar `List[PSCustomObject]` em vez de `@()` + `Where-Object` — evita bug de PowerShell 5.1 com arrays de 1 elemento.
