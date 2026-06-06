---
inclusion: always
---

# Estrutura do Projeto

```
meu-primeiro-site/
│
├── index.html                   # Único arquivo HTML — toda a UI está aqui
├── script.js                    # Toda a lógica do frontend:
│                                #   SOURCES[], TAG_DESCRIPTIONS, state,
│                                #   syncArticles(), renderTimeline(),
│                                #   summaryToHtml(), openReadingPanel(),
│                                #   openLinkedInModal(), buildLinkedInPost()
├── style.css                    # Todos os estilos (tema dark/light via data-theme)
│
├── rss_articles.json            # FONTE DA VERDADE: todos os artigos RSS + TIInside
├── rss_data.js                  # GERADO: window.RSS_ARTICLES = [...] (carregado pelo HTML)
│
├── gartner_articles.json        # Banco de artigos Gartner
├── gartner_data.js              # GERADO: window.GARTNER_ARTICLES = [...]
│
├── svpg_data.js                 # Artigos SVPG (manual, sem JSON separado)
│
├── update_rss.ps1               # Coleta RSS diária (MIT, McKinsey, VentureBeat)
├── update_gartner.ps1           # Coleta Gartner via Firecrawl
├── update_tiinside.ps1          # Coleta TI Inside via Firecrawl com summary PT-BR
├── translate_articles.ps1       # Tradução EN→PT-BR (Claude primário, Gemini fallback)
├── apply_translations.ps1       # Traduções hardcoded (fallback sem API)
│
├── .kiro/
│   ├── steering/
│   │   ├── product.md           # Contexto do produto (sempre incluído pelo KIRO)
│   │   ├── tech.md              # Stack e convenções (sempre incluído)
│   │   └── structure.md        # Este arquivo (sempre incluído)
│   └── specs/
│       └── nova-fonte/          # Exemplo de spec SDD para nova fonte
│           ├── requirements.md
│           ├── design.md
│           └── tasks.md
│
└── .github/
    └── workflows/
        └── update-articles.yml  # Pipeline diário GitHub Actions
```

## Fluxo de dados (como artigos chegam ao site)

```
Fontes externas
    │
    ├── RSS feeds → update_rss.ps1 → rss_articles.json (sem tradução)
    │
    ├── Gartner (scraping) → update_gartner.ps1 → gartner_articles.json (sem tradução)
    │
    └── TI Inside (scraping) → update_tiinside.ps1 → rss_articles.json (com summary_pt PT-BR)
            │
            ▼
    apply_translations.ps1 (aplica hardcoded para artigos conhecidos)
            │
            ▼
    translate_articles.ps1 (Claude/Gemini para artigos EN sem title_pt)
            │
            ▼
    rss_data.js + gartner_data.js (gerados)
            │
            ▼
    GitHub Pages → index.html carrega os .js e renderiza
```

## Arquivos que o KIRO nunca deve modificar automaticamente
- `rss_articles.json` e `gartner_articles.json` — gerados pelos scripts, não editar à mão
- `rss_data.js`, `gartner_data.js` — sempre gerados, nunca editar diretamente
- `apply_translations.ps1` — contém traduções validadas manualmente

## Localização de funcionalidades em script.js
| Funcionalidade | Onde está |
|---|---|
| Lista de fontes | `const SOURCES = [...]` (início do arquivo) |
| Descrições de tags | `const TAG_DESCRIPTIONS = {...}` |
| Carregamento de artigos | `syncArticles()` |
| Renderização do feed | `renderTimeline()` + `buildArticleRow()` |
| Painel de leitura | `openReadingPanel()` |
| Renderização do summary_pt | `summaryToHtml()` + `renderInline()` |
| Geração de post LinkedIn | `buildLinkedInPost()` + `getImplications()` |
| Auto-tags | `autoTags()` |
