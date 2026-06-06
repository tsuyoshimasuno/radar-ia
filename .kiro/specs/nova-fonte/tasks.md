# Tasks — Adicionar Nova Fonte de Artigos

> Marque cada task com `[x]` conforme for concluindo. O KIRO executa uma task por vez — não pule para a próxima antes de validar a atual.

---

## Fase 1 — Configuração da fonte no frontend

- [ ] **1.1** Definir `source_id`, nome exibido e cor hex para a nova fonte
- [ ] **1.2** Adicionar entrada em `SOURCES[]` em `script.js` com `{ id, name, color, tier, rssUrl }`
- [ ] **1.3** Abrir `index.html` no browser e verificar que a fonte aparece na sidebar
- [ ] **1.4** Confirmar que a cor não conflita visualmente com as fontes existentes

---

## Fase 2 — Script de coleta (`update_NOME.ps1`)

- [ ] **2.1** Criar `update_NOME.ps1` com parâmetros: `$FirecrawlKey`, `$CutoffDate` (default: hoje)
- [ ] **2.2** Implementar carregamento do `rss_articles.json` e construção do set de URLs existentes
- [ ] **2.3** Implementar busca de artigos da fonte:
  - Se RSS: parsear XML do feed via `Invoke-WebRequest` + `[xml]`
  - Se scraping: listar URLs da página de listagem via Firecrawl + filtrar por data na URL
- [ ] **2.4** Para cada artigo novo, extrair: `title`, `url`, `summary`, `pub_date`
- [ ] **2.5** Implementar extração de `summary_pt` (fonte PT-BR) ou deixar null (fonte EN)
- [ ] **2.6** Salvar `rss_articles.json` e regenerar `rss_data.js` com `utf8NoBom`
- [ ] **2.7** Testar localmente: `.\update_NOME.ps1 -CutoffDate "YYYY-MM-DD"` e verificar saída
- [ ] **2.8** Confirmar que rodar o script duas vezes não duplica artigos

---

## Fase 3 — Backfill histórico

- [ ] **3.1** Executar `.\update_NOME.ps1 -CutoffDate "DATA-INICIO"` para importar histórico
- [ ] **3.2** Verificar no browser que os artigos aparecem no feed com data e fonte corretas
- [ ] **3.3** Se fonte EN: confirmar que artigos sem `title_pt` aparecem em inglês (esperado — serão traduzidos pelo workflow)
- [ ] **3.4** Se fonte PT-BR: confirmar que `summary_pt` está em português e estruturado com `**seções**` e `- bullets`

---

## Fase 4 — Integração ao workflow do GitHub Actions

- [ ] **4.1** Adicionar step `Atualizar artigos NOME` em `.github/workflows/update-articles.yml` com `continue-on-error: true`
- [ ] **4.2** Posicionar o step ANTES do step de tradução (`translate_articles.ps1`)
- [ ] **4.3** Passar `FIRECRAWL_API_KEY`, `ANTHROPIC_API_KEY`, `GEMINI_API_KEY` como env vars quando necessário
- [ ] **4.4** Commitar e fazer push de todos os arquivos modificados

---

## Fase 5 — Validação final

- [ ] **5.1** Rodar o workflow manualmente no GitHub Actions (Actions → Run workflow)
- [ ] **5.2** Verificar nos logs que o step da nova fonte completa sem erro crítico
- [ ] **5.3** Aguardar o deploy do GitHub Pages e verificar no site publicado
- [ ] **5.4** Abrir um artigo da nova fonte e verificar:
  - [ ] Card do feed: título em PT-BR, badge com cor correta, excerpt curto
  - [ ] Painel de leitura: `summary_pt` com seções formatadas, negritos e bullets
  - [ ] Link "Ler artigo completo" abre a URL original corretamente
- [ ] **5.5** Confirmar que filtrar pela nova fonte na sidebar funciona
