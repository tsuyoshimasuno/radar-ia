# Workflow SDD com KIRO — Radar de IA

## 1. Instalação do KIRO

1. Acesse **kiro.dev** e baixe o instalador para Windows
2. Na primeira abertura, crie um **AWS Builder ID** (gratuito — não exige cartão de crédito)
   - Acesse: https://signin.aws.amazon.com/signup?request_type=register
   - Use seu e-mail para criar a conta Builder ID
3. Abra o KIRO e faça login com o Builder ID
4. Abra a pasta do projeto: **File → Open Folder** → selecione `meu-primeiro-site/`

> O KIRO detecta automaticamente a pasta `.kiro/` e carrega os steering files. Você verá o contexto do produto, stack e estrutura sendo usados pelo agente nas conversas.

---

## 2. O que é SDD (Spec-Driven Development)

SDD é o fluxo nativo do KIRO: **especificar antes de codificar**.

```
Ideia → Requirements → Design → Tasks → Implementação
```

Cada fase é um documento revisado e aprovado **por você** antes de avançar. O KIRO não escreve código até você aprovar o plano completo.

**Por que isso importa para este projeto:**
- Evita que o agente modifique scripts de coleta de forma que quebre o encoding
- Garante que novas fontes seguem as convenções (schema de artigo, utf8NoBom, etc.)
- Cria documentação viva que explica decisões de design

---

## 3. Como iniciar um novo desenvolvimento com SDD

### Passo 1 — Abra o Chat do KIRO e descreva o que quer

No painel de chat do KIRO, escreva sua intenção em linguagem natural. Exemplos:

```
Quero adicionar o site InfoMoney como nova fonte de notícias sobre IA.
O site é em português, tem uma seção dedicada a IA em:
https://www.infomoney.com.br/tecnologia/inteligencia-artificial/
```

```
Quero criar uma funcionalidade de exportar os artigos salvos como PDF.
```

```
Quero adicionar um filtro por período de datas no feed.
```

### Passo 2 — KIRO gera os Requirements

O KIRO vai criar (ou propor) um arquivo em `.kiro/specs/NOME/requirements.md` com:
- User stories no formato "Como X, quero Y, para Z"
- Critérios de aceitação para cada story

**Sua ação:** revise, ajuste e aprove. Se algo estiver errado, corrija no arquivo antes de avançar.

### Passo 3 — KIRO gera o Design

Com os requirements aprovados, o KIRO cria `.kiro/specs/NOME/design.md` com:
- Quais arquivos criar ou modificar
- Estrutura de dados e APIs envolvidas
- Convenções a seguir

**Sua ação:** revise o design. Verifique especialmente:
- O schema de artigo está correto?
- O encoding está sendo respeitado?
- O step no workflow tem `continue-on-error: true`?

### Passo 4 — KIRO gera as Tasks

Com o design aprovado, o KIRO cria `.kiro/specs/NOME/tasks.md` com:
- Lista de tarefas sequenciais e verificáveis
- Cada task é pequena e testável individualmente

**Sua ação:** revise a ordem das tasks. Certifique-se que testes locais aparecem antes do commit.

### Passo 5 — Implementação task a task

Diga ao KIRO: **"implemente a task 1.1"**. Ele faz apenas aquela task, você valida, e avança.

```
Implemente a task 2.3 do spec nova-fonte
```

Nunca deixe o KIRO implementar múltiplas fases de uma vez — perde rastreabilidade.

---

## 4. Regras do workflow para este projeto

| Regra | Motivo |
|---|---|
| Sempre aprovar requirements antes do design | Evita implementar a coisa errada |
| Sempre aprovar design antes das tasks | Garante que convenções (encoding, schema) estão no plano |
| Testar localmente antes de commitar | Erros de encoding ou duplicação são difíceis de desfazer |
| Commitar specs junto com o código | Os arquivos `.kiro/specs/` são parte do histórico do projeto |
| Nunca usar `exit 1` em scripts de automação | Quebra o pipeline inteiro |
| Sempre usar `utf8NoBom` ao escrever arquivos | Evita BOM que corrompe chaves de API e JSON |

---

## 5. Specs existentes como referência

| Spec | O que documenta |
|---|---|
| `.kiro/specs/nova-fonte/` | Como adicionar qualquer nova fonte ao radar |

Para iniciar um novo spec, copie a pasta `nova-fonte/` como template:
```
Copie .kiro/specs/nova-fonte/ para .kiro/specs/NOME-DA-FEATURE/
e adapte os três arquivos.
```

---

## 6. Perguntas para fazer ao KIRO no dia a dia

```
# Contexto e entendimento
"O que o script update_tiinside.ps1 faz exatamente?"
"Como o summary_pt é renderizado no painel de leitura?"

# Novos desenvolvimentos (SDD)
"Quero adicionar [FEATURE]. Gere os requirements seguindo o padrão do spec nova-fonte."

# Debug
"O artigo do TIInside está aparecendo sem summary_pt. O que pode estar errado?"

# Revisão
"Revise o design.md que acabei de aprovar e verifique se segue todas as convenções do tech.md"
```
