# Requirements — Adicionar Nova Fonte de Artigos

## Contexto
O Radar de IA monitora fontes de notícias de inteligência artificial e exibe os artigos traduzidos para PT-BR. Este spec define os requisitos para integrar uma nova fonte ao pipeline existente.

> **Como usar este spec:**
> Copie esta pasta para `.kiro/specs/NOME-DA-FONTE/`, substitua os placeholders e use o KIRO para implementar seguindo o SDD workflow.

---

## User Stories

### US-1 — Coleta automática diária
**Como** usuário do Radar de IA,
**Quero** que artigos da nova fonte apareçam no feed automaticamente todo dia,
**Para que** eu não precise adicionar artigos manualmente.

**Critérios de aceitação:**
- [ ] Script de coleta roda no workflow do GitHub Actions sem intervenção manual
- [ ] Apenas artigos publicados após a data de corte são coletados (sem reprocessar histórico)
- [ ] Artigos já existentes no banco não são duplicados (deduplicação por URL)
- [ ] O script falha graciosamente (`exit 0`) se a fonte estiver inacessível

### US-2 — Artigos com tradução/resumo completo
**Como** usuário do Radar de IA,
**Quero** que todos os artigos da nova fonte tenham título e resumo em PT-BR,
**Para que** eu consiga ler e entender o conteúdo sem barreiras de idioma.

**Critérios de aceitação:**
- [ ] Campo `title_pt` preenchido em PT-BR para todos os artigos
- [ ] Campo `summary_pt` preenchido com resumo estruturado (seções + bullets + negritos)
- [ ] Se fonte EN: tradução via `translate_articles.ps1` (Claude/Gemini)
- [ ] Se fonte PT-BR: resumo gerado diretamente do conteúdo original sem tradução
- [ ] `summary` (feed card) tem no máximo 400 caracteres

### US-3 — Fonte visível e filtrável na sidebar
**Como** usuário do Radar de IA,
**Quero** ver a nova fonte na lista de fontes da sidebar e poder filtrar por ela,
**Para que** eu consiga acompanhar especificamente o conteúdo dessa fonte.

**Critérios de aceitação:**
- [ ] Fonte aparece na sidebar com nome, cor identificadora e contagem de artigos
- [ ] Clicar na fonte filtra o feed mostrando apenas seus artigos
- [ ] Badge da fonte aparece no card do artigo no feed com a cor correta

### US-4 — Backfill de histórico
**Como** usuário do Radar de IA,
**Quero** poder importar artigos históricos da nova fonte de um período específico,
**Para que** o feed não comece vazio na primeira execução.

**Critérios de aceitação:**
- [ ] Script aceita parâmetro `-CutoffDate "YYYY-MM-DD"` para backfill
- [ ] Sem esse parâmetro, coleta apenas artigos de hoje em diante (modo padrão)
- [ ] Backfill pode ser executado localmente sem GitHub Actions

### US-5 — Resiliência no pipeline
**Como** mantenedor do Radar de IA,
**Quero** que uma falha na coleta da nova fonte não quebre o pipeline inteiro,
**Para que** as outras fontes continuem sendo atualizadas normalmente.

**Critérios de aceitação:**
- [ ] Step no GitHub Actions tem `continue-on-error: true`
- [ ] Falhas de API (timeout, 429, 500) são logadas mas não propagadas
- [ ] O commit diário ocorre mesmo que a coleta da fonte falhe
