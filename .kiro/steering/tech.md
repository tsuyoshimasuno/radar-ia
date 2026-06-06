---
inclusion: always
---

# Stack Técnica e Convenções

## Frontend
- **HTML/CSS/JS puro** — sem frameworks, sem build tools, sem node_modules
- CSS com variáveis custom (`--primary-color`, `--text-primary`, `--bg-card`, etc.) para suporte a tema dark/light
- Font Awesome via CDN para ícones

## Dados (arquivos gerados)
Artigos são carregados via `<script>` que expõem variáveis globais no `window`:

| Arquivo | Variável global | Gerado por |
|---|---|---|
| `rss_data.js` | `window.RSS_ARTICLES` | update_rss.ps1 + translate_articles.ps1 |
| `gartner_data.js` | `window.GARTNER_ARTICLES` | update_gartner.ps1 + translate_articles.ps1 |
| `svpg_data.js` | `window.SVPG_ARTICLES` | manual |

Bancos de dados JSON (fonte da verdade):
- `rss_articles.json` — artigos RSS + TIInside (campo `source_id` distingue a origem)
- `gartner_articles.json` — artigos Gartner

## Schema obrigatório de artigo
```json
{
  "title":      "Título original (EN ou PT-BR)",
  "title_pt":   "Título em português do Brasil",
  "url":        "https://...",
  "summary":    "Trecho curto (~300 chars) mostrado no card do feed",
  "summary_pt": "**Seção**\n- bullet 1\n- bullet 2\n\n**Outra Seção**\n- ...",
  "source_id":  "id_da_fonte",
  "first_seen": "YYYY-MM-DD",
  "pub_date":   "YYYY-MM-DD"
}
```

## Scripts PowerShell de automação
| Script | Responsabilidade |
|---|---|
| `update_rss.ps1` | Busca feeds RSS (MIT, McKinsey, VentureBeat), adiciona artigos sem tradução |
| `update_gartner.ps1` | Scraping Gartner via Firecrawl |
| `update_tiinside.ps1` | Scraping TI Inside via Firecrawl, gera summary_pt em PT-BR |
| `translate_articles.ps1` | Traduz EN→PT-BR via Claude (primário) ou Gemini (fallback) |
| `apply_translations.ps1` | Aplica traduções hardcoded (fallback para artigos sem API) |

## APIs externas
| API | Key | Uso | Observações |
|---|---|---|---|
| Firecrawl | `FIRECRAWL_API_KEY` (hardcoded fallback) | Scraping | Confiável, chave hardcoded como fallback |
| Anthropic Claude | `ANTHROPIC_API_KEY` | Tradução/resumo | Primário, sem limitação de cota diária |
| Google Gemini | `GEMINI_API_KEY` | Tradução/resumo | Fallback, free tier com limite 15 RPM e cota diária |

## CI/CD
- **Plataforma:** GitHub Actions (`windows-latest`)
- **Frequência:** diariamente às 11h UTC (08h BRT)
- **Arquivo:** `.github/workflows/update-articles.yml`
- **Hospedagem:** GitHub Pages (branch `master`)

## Convenções críticas de código
- **Encoding:** sempre usar `utf8NoBom` ao escrever arquivos em PowerShell (`New-Object System.Text.UTF8Encoding $false`)
- **API Keys:** sempre aplicar `.Trim().TrimStart([char]0xFEFF)` para remover BOM
- **Falha graciosa:** scripts de automação nunca devem usar `exit 1` por falta de chave — usar `exit 0` com aviso
- **`continue-on-error: true`** em steps de tradução no workflow para garantir que commits sempre aconteçam
- **Prompts de IA:** usar `@'...'@` (single-quoted) para evitar problemas de encoding com acentos em PS5.1

## Padrão de `summary_pt`
O campo `summary_pt` usa markdown que o `summaryToHtml()` em `script.js` parseia:
- `**Texto**` em linha isolada → `<h4>` (cabeçalho de seção)
- `**texto**` inline → `<strong>` (negrito)
- `- item` → `<li>` com `→` decorativo
- Parágrafos separados por linha em branco

## Como adicionar uma nova fonte
1. Criar `update_NOME.ps1` seguindo o padrão de `update_tiinside.ps1` (fontes PT-BR) ou `update_rss.ps1` (fontes EN)
2. Adicionar entrada em `SOURCES` em `script.js` com `{ id, name, color, tier, rssUrl }`
3. Adicionar step em `.github/workflows/update-articles.yml` com `continue-on-error: true`
4. Se EN: `translate_articles.ps1` traduz automaticamente na mesma execução
5. Se PT-BR: script de coleta já gera `title_pt` e `summary_pt` diretamente
