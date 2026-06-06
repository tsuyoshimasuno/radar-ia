---
inclusion: always
---

# Radar de IA — Contexto do Produto

## O que é
Agregador de notícias de inteligência artificial curado para líderes de tecnologia brasileiros. Monitora fontes internacionais e nacionais relevantes, traduz automaticamente artigos do inglês para português do Brasil e os apresenta em um feed cronológico com resumos detalhados e estruturados.

## Usuário
Tsuyoshi Masuno — líder de tecnologia que acompanha tendências de IA para uso profissional e tomada de decisão estratégica.

## Proposta de valor principal
- Consolida múltiplas fontes de IA em um único feed cronológico
- Traduz artigos EN→PT-BR com resumos estruturados (seções + bullets + negritos)
- Atualiza automaticamente todo dia às 08h BRT via GitHub Actions
- Leitura rápida via cards no feed, leitura aprofundada via painel lateral

## Fontes ativas
| ID | Nome | Idioma | Método |
|---|---|---|---|
| mit | MIT Technology Review | EN | RSS |
| mckinsey | McKinsey | EN | RSS |
| venturebeat | VentureBeat | EN | RSS |
| gartner | Gartner | EN | Firecrawl scraping |
| tiinside | TI Inside | PT-BR | Firecrawl scraping |
| svpg | SVPG | EN | Manual |

## Funcionalidades principais
- Feed com filtro por fonte, busca textual e ordenação
- Painel de leitura com resumo estruturado em markdown
- Geração de post para LinkedIn a partir do artigo
- Bookmarks persistidos em localStorage
- Tema claro/escuro

## O que este produto NÃO é
- Não é um produto SaaS — é um site estático pessoal hospedado no GitHub Pages
- Não tem backend, servidor, banco de dados ou autenticação
- Dados são arquivos `.js` e `.json` gerados por scripts PowerShell

## Critérios de qualidade para novos artigos
- `title_pt` e `summary_pt` sempre em português do Brasil
- `summary_pt` formatado com `**Seção**` e `- bullets` para facilitar leitura
- `pub_date` reflete a data real de publicação (não de coleta)
- Artigos de fontes PT-BR: sem tradução, apenas resumo estruturado extraído do conteúdo
