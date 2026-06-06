# apply_translations.ps1
# Aplica as traducoes geradas pelos agentes Claude nos arquivos JSON e regenera os JS.

$utf8NoBom = New-Object System.Text.UTF8Encoding $false
$translations = [System.Collections.Generic.List[PSCustomObject]]::new()

# ── Artigo 0 ──────────────────────────────────────────────────────────────────
$t0s = @'
O termo "psicose de IA" ganhou destaque após o fundador da Box, Aaron Levie, publicar nas redes sociais que CEOs do setor de tecnologia são "uniquamente propensos" a esse fenômeno — ou seja, tendem a superestimar os benefícios da inteligência artificial por estarem distantes das operações do dia a dia. O episódio do podcast Equity da TechCrunch reuniu os jornalistas Anthony Ha, Kirsten Korosec e Sean O'Kane para debater a afirmação de Levie e o crescente contramovimento anti-IA que começa a se manifestar entre usuários e formadores de opinião.

O debate revela uma polarização profunda: ao mesmo tempo em que toda empresa parece adotar IA de forma acelerada, há uma parcela significativa de usuários que rejeita ativamente as mudanças impostas pelas big techs. O exemplo mais concreto é o DuckDuckGo, que registrou aumento de 30% nas instalações após o Google anunciar mais IA em sua busca — sinal de que existe um mercado relevante de consumidores insatisfeitos com a direção atual.

O Google é apontado como o caso mais crítico desse dilema: a empresa sente que precisa integrar IA à busca para se manter competitiva, mas está degradando justamente o produto que os usuários mais associam à marca. Korosec resume bem o problema: o Google "corre atrás do que sente que precisa fazer para se manter relevante, mas está comprometendo exatamente a função que as pessoas mais valorizam na marca".

Para líderes de tecnologia, o artigo traz uma mensagem clara: a adoção de IA não pode ser conduzida apenas por slides de eficiência apresentados em reuniões executivas. Levie defende que os CEOs precisam usar as ferramentas na prática para entender o que realmente funciona — e que a distância entre os gestores e o trabalho final é o terreno fértil para a "psicose". O momento atual abre espaço tanto para startups focadas em usuários céticos à IA quanto para aquelas que apostam nos entusiastas.
'@
$translations.Add([PSCustomObject]@{url="https://techcrunch.com/2026/05/31/making-sense-of-the-debate-over-ai-psychosis/";title_pt="Entendendo o debate sobre a 'psicose de IA'";summary_pt=$t0s})

# ── Artigo 1 ──────────────────────────────────────────────────────────────────
$t1s = @'
O Gemini Spark é o novo assistente agêntico do Google, apresentado pelo CEO Sundar Pichai no Google I/O de maio de 2026. Diferente de chatbots convencionais, o Spark roda em máquinas virtuais na nuvem e executa tarefas de forma contínua — sem exigir que o usuário mantenha o computador ligado. Ele se integra ao ecossistema Google (Gmail, Calendar, Docs, Sheets e Slides) e foi projetado para automatizar tarefas repetitivas da vida digital cotidiana.

A repórter testou o Spark em cinco cenários práticos: busca de promoções em farmácias, criação de lista de itens para passeio, pesquisa de atividades de verão para adolescentes, resumo semanal de newsletters e monitoramento de queda de preço de produto. O assistente teve desempenho satisfatório na maioria das tarefas, mas cometeu erros pontuais: um código promocional inválido, a impossibilidade de integração com o Google Keep e uma interpretação incorreta da quantidade de artigos solicitados.

A principal crítica não é sobre as capacidades do Spark em si, mas sobre a decisão do Google de lançá-lo como produto separado com marca própria. Numa era em que proliferam nomes e versões de IA, criar mais uma marca gera confusão desnecessária. A sugestão é que essas funcionalidades fossem incorporadas diretamente ao Gemini.

Para empresas e gestores de tecnologia, o Spark representa um exemplo concreto de IA agêntica para produtividade. Suas limitações atuais — ausência de integrações fora do ecossistema Google e suporte ainda limitado a MCP — são relevantes para decisões de adoção. O produto tem potencial, mas ainda precisa amadurecer.
'@
$translations.Add([PSCustomObject]@{url="https://techcrunch.com/2026/05/30/i-put-googles-24-7-ai-assistant-gemini-spark-to-work-and-its-actually-pretty-useful/";title_pt="Coloquei o assistente de IA 24/7 do Google, o Gemini Spark, para trabalhar — e ele é surpreendentemente útil";summary_pt=$t1s})

# ── Artigo 2 ──────────────────────────────────────────────────────────────────
$t2s = @'
Chrome e Safari dominam o mercado de navegadores, mas 2026 marca uma nova fase na disputa por usuários insatisfeitos com a integração crescente de IA nas ferramentas tradicionais. Três categorias de alternativas emergem com força: navegadores com IA nativa, navegadores focados em privacidade e navegadores de nicho voltados para bem-estar e produtividade.

No campo da IA, os destaques são o Comet (Perplexity), o Dia (The Browser Company), o Neon (Opera) e o Atlas (OpenAI). O Comet funciona como mecanismo de busca baseado em chatbot. O Dia tem consciência contextual de todos os sites visitados. O Neon da Opera consegue pesquisar, comprar e escrever código mesmo offline. O Atlas permite consultar o ChatGPT sobre resultados de busca diretamente no navegador.

Na frente da privacidade, o Brave se destaca com bloqueio de anúncios e rastreadores. O DuckDuckGo, impulsionado pela rejeição à IA forçada do Google, registrou alta de 30% nas instalações. O Ladybird tenta construir um navegador de código aberto do zero, sem usar a base Chromium do Google.

Para líderes de tecnologia, a integração de IA nos navegadores está se tornando um diferencial competitivo central. Empresas que definem políticas de uso de navegadores corporativos devem acompanhar esse cenário, pois as escolhas feitas agora influenciarão quais dados os colaboradores expõem e como a IA será acessada no ambiente de trabalho.
'@
$translations.Add([PSCustomObject]@{url="https://techcrunch.com/2026/05/30/as-the-browser-wars-heat-up-here-are-the-hottest-alternatives-to-chrome-and-safari-in-2026/";title_pt="Com a guerra dos navegadores esquentando, conheça as melhores alternativas ao Chrome e ao Safari em 2026";summary_pt=$t2s})

# ── Artigo 3 ──────────────────────────────────────────────────────────────────
$t3s = @'
Segundo um memorando interno obtido pelo The Information, a Meta está desenvolvendo um pingente com IA que pretende começar a testar no próximo ano. O dispositivo se baseia na tecnologia da Limitless, startup de wearables com IA adquirida pela Meta no final de 2025, que já produzia um pingente capaz de gravar conversas e ser acoplado à roupa ou usado como colar.

O memo também indica que a empresa planeja expandir sua linha de óculos com IA e lançar uma assinatura corporativa chamada Wearables for Work. O objetivo seria reverter os resultados negativos da divisão Reality Labs, que registrou prejuízo de US$ 4 bilhões apenas no primeiro trimestre de 2026.

Wearables com IA anteriores, como o AI Pin da Humane, não conseguiram conquistar o mercado de massa — possivelmente por preocupações com privacidade e marketing inadequado. Mas empresas como OpenAI seguem apostando no segmento, sinalizando que a corrida por hardware de IA vestível continua intensa.
'@
$translations.Add([PSCustomObject]@{url="https://techcrunch.com/2026/05/30/meta-is-reportedly-developing-an-ai-pendant/";title_pt="Meta estaria desenvolvendo um pingente com inteligência artificial";summary_pt=$t3s})

# ── Artigo 4 ──────────────────────────────────────────────────────────────────
$t4s = @'
A partir de 1º de junho de 2026, o GitHub Copilot deixa de cobrar uma assinatura mensal fixa e passa a faturar com base no consumo de tokens, gerando onda de indignação entre desenvolvedores. Relatos em fóruns como Reddit e X mostram casos em que usuários que pagavam cerca de US$ 29 mensais passarão a gastar entre US$ 750 e até US$ 3.000 por mês no novo modelo.

A reação é intensa e dividida. Uma parcela dos usuários denuncia o custo como proibitivo para pequenas empresas e desenvolvedores individuais, argumentando que a Microsoft incentivou o uso irrestrito da ferramenta e agora muda as regras abruptamente. Outros contra-argumentam que os gastos exorbitantes são fruto do "vibe coding" — geração excessiva de código sem critério técnico real.

O debate expõe uma tensão estrutural do mercado de IA: durante o período de crescimento acelerado, as empresas subsidiaram amplamente o uso para ganhar usuários. Agora, com o amadurecimento do mercado, tentam recuperar as margens, mas enfrentam resistência de uma base de usuários que se acostumou com os custos subsidiados.

Para empresas e gestores de TI, o episódio é um alerta sobre os riscos de dependência de ferramentas de IA com precificação variável. Orçamentos de desenvolvimento de software podem se tornar imprevisíveis à medida que o uso de IA escala. A recomendação implícita é implementar governança clara sobre o uso de tokens e treinar equipes para usar ferramentas de IA de forma direcionada, não indiscriminada.
'@
$translations.Add([PSCustomObject]@{url="https://techcrunch.com/2026/05/30/what-a-joke-github-copilots-new-token-based-billing-spurs-consternation-among-devs/";title_pt="'Que piada': o novo modelo de cobrança por tokens do GitHub Copilot revolta desenvolvedores";summary_pt=$t4s})

# ── Artigo 5 ──────────────────────────────────────────────────────────────────
$t5s = @'
O SoftBank Group anunciou planos de investir até 75 bilhões de euros (aproximadamente US$ 87 bilhões) para expandir sua infraestrutura de data centers na França. A primeira fase prevê a construção de instalações em Dunkirk, Bosquel e Bouchain, com capacidade de 3,1 gigawatts entregues à região de Hauts-de-France até 2031. No total, a meta é atingir 5 gigawatts de capacidade adicional.

O anúncio foi recebido com entusiasmo pelo ministro econômico francês Roland Lescure, que o descreveu como prova da ambição do presidente Macron em posicionar a França como destino central na cadeia de valor da IA. O SoftBank, que é ao mesmo tempo investidor e cliente da OpenAI, reforça assim sua aposta estratégica na infraestrutura de computação que sustenta os grandes modelos de linguagem.
'@
$translations.Add([PSCustomObject]@{url="https://techcrunch.com/2026/05/30/softbank-says-it-will-invest-up-to-e75-billion-to-build-french-data-centers/";title_pt="SoftBank anuncia investimento de até 75 bilhões de euros em data centers na França";summary_pt=$t5s})

# ── Artigo 6 ──────────────────────────────────────────────────────────────────
$t6s = @'
Em 2026, a dependência de ferramentas de IA entre desenvolvedores atingiu um ponto sem retorno: o laboratório de pesquisa METR tentou replicar um estudo de produtividade com desenvolvedores de código aberto e descobriu que a maioria se recusou a participar porque não estava disposta a trabalhar sem IA — nem mesmo para um experimento controlado. A pesquisa original de 2025 já havia revelado uma surpresa: embora os devs se sentissem mais produtivos com IA, na prática eram mais lentos, pois o tempo ganho na geração de código era consumido na correção de erros e na supervisão dos modelos.

Os dados de empresas reais corroboram essa preocupação. A Amazon encerrou seu ranking interno de produtividade baseado em tokens após funcionários começarem a gamificar o sistema. A Uber esgotou seu orçamento de IA para 2026 nos primeiros quatro meses sem registrar ganho mensurável. Uma análise da CodeRabbit revelou que código gerado por IA produz 1,7 vez mais problemas do que código humano.

O fenômeno do "tokenmaxxing" — usar o volume de tokens consumidos como proxy de produtividade — é identificado como um dos principais equívocos de 2026. Ele incentiva o uso indiscriminado da IA sem considerar a qualidade do output.

Para líderes de tecnologia, a implicação prática é urgente: estabelecer governança clara sobre como a IA é usada no desenvolvimento de software. Isso inclui sistemas robustos de QA, revisão humana criteriosa de outputs e preservação do papel humano nas decisões de arquitetura. A dependência total da IA sem capacidade de trabalhar de forma independente representa um risco tanto para a qualidade do software quanto para a empregabilidade dos desenvolvedores.
'@
$translations.Add([PSCustomObject]@{url="https://techcrunch.com/2026/05/29/coders-are-refusing-to-work-without-ai-and-that-could-come-back-to-bite-them/";title_pt="Programadores se recusam a trabalhar sem IA — e isso pode sair caro no futuro";summary_pt=$t6s})

# ── Artigo 7 ──────────────────────────────────────────────────────────────────
$t7s = @'
O relatório da McKinsey analisa como o comércio agêntico — mediado por assistentes de IA como Gemini, ChatGPT e Perplexity — está transformando a jornada de compra no setor de luxo. A tese central é que a "porta de entrada" da experiência de luxo está migrando para upstream: antes mesmo de o cliente chegar à boutique ou ao site da marca, sua intenção de compra já está sendo interpretada e moldada por sistemas de IA de terceiros. Segundo a pesquisa, 85% dos consumidores de luxo já usam assistentes de IA multipropósito para decisões de compra.

O desafio estratégico não é tecnológico, mas de autoridade interpretativa: quem define como a marca é percebida quando um agente de IA é o primeiro ponto de contato? Se uma ferramenta genérica for a primeira a interpretar o desejo de um cliente, o risco não é receber uma sugestão errada de produto, mas ter a própria identidade da marca distorcida. A McKinsey estima que agentes de IA poderão mediar entre US$ 3 trilhões e US$ 5 trilhões do comércio global de bens até 2030.

O relatório propõe um modelo conceitual de quatro "salas": o Foyer (descoberta inicial), a Galeria (curadoria de produtos), o Salão (autorização supervisionada com humanos no centro) e o Ateliê (pós-venda e fidelização). Cada sala exige um nível diferente de delegação à IA.

Para líderes do setor, as implicações são concretas: marcas de luxo precisam codificar seus códigos estéticos e de serviço em formatos legíveis por máquina, construir camadas de interpretação de marca próprias e encarar a confiança como ativo de diferenciação. Esperar para agir é, em si, uma escolha estratégica arriscada.
'@
$translations.Add([PSCustomObject]@{url="https://www.mckinsey.com/industries/retail/our-insights/when-ai-meets-desire-innovating-human-centered-luxury-experiences-in-the-agentic-age";title_pt="Quando a IA encontra o desejo: inovando experiências de luxo centradas no ser humano na era agêntica";summary_pt=$t7s})

# ── Artigo 8 ──────────────────────────────────────────────────────────────────
$t8s = @'
O artigo da MIT Technology Review analisa a encíclica papal "Magnifica Humanitas" (Magnífica Humanidade), publicada pelo Papa Leão XIV em maio de 2026, como um chamado ético e político à ação diante do avanço da inteligência artificial. A afirmação central do documento — "a tecnologia nunca é neutra" — é apresentada como ponto de partida para uma reflexão sobre responsabilidade coletiva num momento em que a IA está transformando o mundo com velocidade comparável à Revolução Industrial.

Os autores argumentam que, na ausência de regulação efetiva por parte de governos e organismos internacionais, investidores institucionais têm preenchido esse vácuo. Coalizões como o Interfaith Center on Corporate Responsibility, representando mais de US$ 400 bilhões em ativos, têm apresentado resoluções em assembleias de acionistas de empresas como Alphabet, Amazon, Nvidia, Meta e Microsoft, exigindo transparência e responsabilização no uso da IA.

A encíclica é posicionada não como ruptura, mas como ratificação de uma agenda de governança que já está em movimento. Com OpenAI, Anthropic e xAI se preparando para abrir capital, os mesmos mecanismos de pressão acionária poderão ser aplicados a empresas que hoje são privadas e praticamente imunes a esse tipo de escrutínio.
'@
$translations.Add([PSCustomObject]@{url="https://www.technologyreview.com/2026/05/29/1138107/how-the-popes-magnifica-humanitas-offers-a-template-for-individuals-to-meet-the-ai-moment/";title_pt="Como a 'Magnifica Humanitas' do Papa oferece um modelo para que indivíduos enfrentem o momento da IA";summary_pt=$t8s})

# ── Artigo 9 ──────────────────────────────────────────────────────────────────
$t9s = "Convocação para fundadores, investidores e especialistas se inscreverem para falar no TechCrunch Disrupt 2026, evento agendado para 13 a 15 de outubro no Moscone West, em San Francisco, com mais de 10.000 participantes do ecossistema de startups e venture capital."
$translations.Add([PSCustomObject]@{url="https://techcrunch.com/2026/05/29/today-is-the-last-day-to-apply-to-speak-at-techcrunch-disrupt-2026/";title_pt="Hoje é o último dia para se inscrever como palestrante no TechCrunch Disrupt 2026";summary_pt=$t9s})

# ── Artigo 10 ──────────────────────────────────────────────────────────────────
$t10s = @'
O relatório da McKinsey examina como a inteligência artificial está transformando o mercado de pós-venda e serviços nas indústrias automotiva e industrial — segmentos que historicamente respondem pela maior parte das margens das empresas do setor. Em empresas de elevadores e escadas rolantes, por exemplo, os serviços podem representar até três quartos das margens totais.

O artigo detalha como a IA está remodelando cada etapa do ciclo de vida de serviços: da inovação e desenvolvimento de produtos (com gêmeos digitais que reduzem custos de P&D em até 5%) à geração de demanda (copilots de vendas que dobraram as oportunidades de novos contratos em um OEM industrial), passando pela execução de ordens de serviço (diagnóstico remoto que reduziu horas de trabalho por tarefa em 15%).

Apesar do potencial, a McKinsey alerta que apenas cerca de 5% do EBIT das empresas pode ser atribuído ao uso de IA generativa. Os principais obstáculos são: falta de caminho claro do piloto para a escala, gestão insuficiente de dados, baixa adoção por parte das equipes de campo e dificuldades de integração com sistemas existentes.

Para líderes industriais, o roteiro prático é: identificar os dois ou três momentos da jornada de serviço que mais impactam margem e experiência do cliente, definir quais decisões a IA deve automatizar versus apoiar, e garantir ownership claro para os resultados.
'@
$translations.Add([PSCustomObject]@{url="https://www.mckinsey.com/industries/automotive-and-assembly/our-insights/ai-is-already-rewiring-the-aftermarket-and-services";title_pt="A IA já está reconfigurando o pós-venda e os serviços na indústria automotiva e de manufatura";summary_pt=$t10s})

# ── Artigo 11 ──────────────────────────────────────────────────────────────────
$t11s = @'
A Groq, startup especializada em chips de IA e inferência em nuvem, estaria levantando US$ 650 milhões em uma rodada interna com seus investidores existentes, segundo o Axios. A movimentação ocorre após um acordo atípico fechado em dezembro de 2025 com a Nvidia: pelo valor de aproximadamente US$ 20 bilhões, a Nvidia licenciou a tecnologia de hardware da Groq e absorveu alguns de seus executivos sênior — sem, porém, adquirir a empresa formalmente.

Agora, esses mesmos investidores são chamados a financiar a nova fase da empresa: focar no negócio de nuvem de inferência, que permite a desenvolvedores e empresas hospedar aplicações de IA de alta demanda computacional. A inferência — o processamento que acontece após um prompt de IA — é hoje a maior necessidade do mercado, superando o treinamento de modelos.
'@
$translations.Add([PSCustomObject]@{url="https://techcrunch.com/2026/05/29/after-nvidias-20b-not-acqui-hire-ai-chip-startup-groq-reportedly-raising-650m/";title_pt="Após acordo de US$ 20 bilhões com a Nvidia, a startup de chips de IA Groq teria captando US$ 650 milhões";summary_pt=$t11s})

# ── Artigo 12 ──────────────────────────────────────────────────────────────────
$t12s = @'
Com a explosão da inteligência artificial, surgiu também uma enxurrada de jargões técnicos que muitas vezes deixam profissionais e leigos sem saber exatamente o que significam. Este glossário do TechCrunch foi criado para preencher essa lacuna, explicando de forma clara os termos mais importantes do vocabulário de IA — e é atualizado regularmente à medida que o campo evolui.

O artigo cobre desde conceitos fundamentais como AGI (Inteligência Artificial Geral), LLM (Modelos de Linguagem de Grande Escala), redes neurais e aprendizado profundo, até termos mais específicos como alucinações, inferência, cadeia de pensamento (chain of thought), ajuste fino (fine-tuning), tokens, e o novo fenômeno chamado RAMageddon — a escassez crescente de memória RAM causada pela demanda voraz da indústria de IA.

Para líderes empresariais e equipes de tecnologia, compreender esses conceitos é cada vez mais essencial. Mal-entendidos sobre esses termos podem levar a decisões equivocadas de investimento ou adoção tecnológica. O glossário serve tanto como ponto de entrada para iniciantes quanto como referência rápida para profissionais da área.
'@
$translations.Add([PSCustomObject]@{url="https://techcrunch.com/2026/05/29/artificial-intelligence-definition-glossary-hallucinations-guide-to-common-ai-terms/";title_pt="Você ouviu esses termos de IA e concordou com a cabeça — vamos resolver isso";summary_pt=$t12s})

# ── Artigo 13 ──────────────────────────────────────────────────────────────────
$t13s = @'
A XCENA, startup sul-coreana com escritórios também nos EUA, acaba de fechar uma rodada Série B de US$ 135 milhões a uma avaliação de US$ 570 milhões. A tese da empresa é que a IA moderna enfrenta um gargalo estrutural frequentemente ignorado: a memória, e não o processamento (compute), é o elo mais fraco da cadeia de infraestrutura.

Em cada consulta a um modelo de linguagem como o ChatGPT, os dados percorrem um circuito custoso entre memória, CPU e GPU — repetidamente, para cada palavra gerada. O chip da XCENA, chamado MX1, insere capacidade de processamento diretamente no módulo DRAM via conexão CXL, eliminando grande parte dessas viagens de dados. A empresa afirma que tarefas que antes exigiam 10 servidores poderiam rodar em apenas um.

Os fundadores são ex-executivos de Samsung e SK Hynix, os maiores fabricantes de chips de memória do mundo. O chip MX1 ainda é protótipo, com produção em massa prevista para o final de 2026 e geração de receita a partir de 2027. Para CTOs e líderes de infraestrutura de IA, a XCENA representa uma aposta relevante na próxima fronteira de otimização de custos operacionais em grandes implantações de IA.
'@
$translations.Add([PSCustomObject]@{url="https://techcrunch.com/2026/05/29/xcena-secures-135m-at-570m-valuation-betting-on-memory-as-ais-real-bottleneck/";title_pt="Esta startup de chips captou US$ 135 milhões apostando que o maior gargalo da IA não é o processamento — é a memória";summary_pt=$t13s})

# ── Artigo 14 ──────────────────────────────────────────────────────────────────
$t14s = @'
O Kiwibit Bird Feeder Pro 4K AI Camera é um comedouro inteligente que utiliza inteligência artificial para identificar mais de 10.000 espécies de pássaros em tempo real. Com câmera de 4K, painel solar integrado, Wi-Fi e lente de 130 graus, o dispositivo notifica o usuário no celular toda vez que um novo visitante aparece.

O aplicativo companheiro registra cada visita, identifica as espécies automaticamente com base em algoritmo proprietário, e oferece informações detalhadas sobre cada pássaro. O produto ilustra como a IA embarcada em dispositivos domésticos está se tornando acessível e divertida para o consumidor comum, transformando interações cotidianas com a natureza em experiências gamificadas e conectadas.
'@
$translations.Add([PSCustomObject]@{url="https://techcrunch.com/2026/05/29/kiwibits-ai-powered-bird-feeder-is-my-new-backyard-buddy/";title_pt="O comedouro de pássaros com IA da Kiwibit é meu novo companheiro de quintal";summary_pt=$t14s})

# ── Artigo 15 ──────────────────────────────────────────────────────────────────
$t15s = @'
Neste episódio do podcast Equity do TechCrunch, os apresentadores debatem o conceito de "psicose de IA" cunhado pelo fundador da Box, Aaron Levie. Para Levie, os CEOs que decidem substituir trabalhadores por agentes de IA são frequentemente os menos capacitados para entender o que esses trabalhadores realmente fazem no dia a dia — criando uma perigosa desconexão entre expectativas e realidade.

O episódio contextualiza essa discussão com dados concretos: a ClickUp cortou 22% de sua força de trabalho em nome da IA; os demitidos em tecnologia em 2026 já quase igualam o total de 2025; e as instalações do DuckDuckGo cresceram 30% com usuários que rejeitam a integração forçada de IA na busca do Google.

Para líderes de empresas, a mensagem central é clara: adotar IA sem compreendê-la operacionalmente é uma forma de gestão irresponsável. A onda de cortes motivados por IA pode gerar ganhos de curto prazo e danos de longo prazo — especialmente quando os tomadores de decisão estão desconectados das realidades do trabalho que pretendem automatizar.
'@
$translations.Add([PSCustomObject]@{url="https://techcrunch.com/podcast/does-your-ceo-have-ai-psychosis-aaron-levie-thinks-most-of-them-do/";title_pt="Seu CEO sofre de psicose de IA? Aaron Levie acha que a maioria deles sofre";summary_pt=$t15s})

# ── Artigo 16 ──────────────────────────────────────────────────────────────────
$t16s = @'
Scott Wu, CEO da Cognition e criador do Devin — considerado o primeiro e mais bem-sucedido agente de programação por IA —, levantou US$ 1 bilhão em uma rodada Série D avaliando a empresa em US$ 26 bilhões. Apesar desse marco, Wu é categórico: o objetivo do Devin nunca foi substituir programadores humanos, mas sim ampliar suas capacidades.

Wu vê o Devin como um "parceiro" que liberta os desenvolvedores das tarefas mais mecânicas e repetitivas — como atualizar sistemas legados ou migrar plataformas — para que possam se concentrar na criação e arquitetura de software. Na própria Cognition, 89% do código é commitado pelo Devin ou por agentes do Windsurf.

Wu é honesto sobre as limitações atuais: o Devin opera entre os níveis de um engenheiro júnior e um de nível médio, dependendo da tarefa. Para líderes de tecnologia e RH, o posicionamento de Wu oferece um contrapeso importante no debate sobre IA e emprego: a perspectiva de que a automação inteligente deve aumentar a capacidade humana, não erradicá-la.
'@
$translations.Add([PSCustomObject]@{url="https://techcrunch.com/2026/05/29/cognitions-scott-wu-says-ai-coding-agents-shouldnt-replace-humans/";title_pt="Scott Wu, da Cognition, diz que agentes de IA para programação não deveriam substituir humanos";summary_pt=$t16s})

# ── Artigo 17 ──────────────────────────────────────────────────────────────────
$t17s = "Aviso promocional de encerramento do período Early Bird para o TechCrunch Disrupt 2026, que acontece de 13 a 15 de outubro no Moscone West, em San Francisco."
$translations.Add([PSCustomObject]@{url="https://techcrunch.com/2026/05/29/final-24-hours-to-save-up-to-410-on-your-techcrunch-disrupt-2026-ticket/";title_pt="Últimas 24 horas para economizar até US$ 410 no seu ingresso para o TechCrunch Disrupt 2026";summary_pt=$t17s})

# ── Artigo 18 ──────────────────────────────────────────────────────────────────
$t18s = @'
Este vídeo do TechCrunch debate o que acontece quando organizações abraçam a IA de forma acrítica e excessiva, tomando decisões de demissão e reestruturação antes de compreender as reais capacidades e limitações das ferramentas.

O debate gira em torno de uma tensão paradoxal: ao mesmo tempo em que todos usam IA e a aprovam, uma parcela significativa dos usuários a rejeita. O crescimento de 30% nas instalações do DuckDuckGo — um buscador que rejeita a integração forçada de IA — é citado como evidência concreta desse fenômeno. Para líderes empresariais, a mensagem é que a adoção de IA precisa ser equilibrada com compreensão operacional real.
'@
$translations.Add([PSCustomObject]@{url="https://techcrunch.com/video/what-happens-when-companies-become-too-ai-pilled/";title_pt="O que acontece quando as empresas ficam obcecadas demais com IA?";summary_pt=$t18s})

# ── Artigo 19 ──────────────────────────────────────────────────────────────────
$t19s = @'
Este episódio do podcast McKinsey traz o sócio sênior Ido Segev discutindo como a IA representa uma transformação estrutural — e não apenas incremental — para o setor bancário. A questão central para os bancos não é mais se devem adotar IA, mas com que velocidade e profundidade. O maior risco é a inércia: bancos que se moverem cedo capturarão vantagens de custo e rentabilidade que os atrasados não conseguirão recuperar facilmente.

Os números são expressivos: Segev estima que a adoção plena de IA agêntica pode reduzir os custos bancários em 20 a 25%, o equivalente a US$ 250 a US$ 500 milhões por cada US$ 100 bilhões em ativos. Ao mesmo tempo, a competição deve comprimir os lucros da indústria em 9 a 10% ao longo do tempo.

Segev identifica os principais obstáculos para escalar IA nos bancos: falta de foco nas iniciativas, silos entre áreas de negócio e TI, necessidade de requalificação dos funcionários, e a armadilha de confundir capacidade liberada com valor gerado. Para líderes do setor financeiro, as implicações são claras: os vencedores serão os bancos que adotarem IA de forma precisa — não necessariamente os maiores, mas os mais estratégicos.
'@
$translations.Add([PSCustomObject]@{url="https://www.mckinsey.com/industries/financial-services/our-insights/move-first-or-fall-behind-how-ai-is-rewriting-the-rules-of-banking";title_pt="Mova-se primeiro ou fique para trás: como a IA está reescrevendo as regras do setor bancário";summary_pt=$t19s})

# ── Artigo 20 ──────────────────────────────────────────────────────────────────
$t20s = @'
A Anthropic, criadora do assistente de IA Claude, fechou sua rodada Série H de US$ 65 bilhões a uma avaliação pós-dinheiro de US$ 965 bilhões — tornando-se a empresa privada mais valiosa da história da IA. A rodada foi co-liderada por Altimeter Capital, Dragoneer, Greenoaks, Sequoia Capital e outros grandes nomes institucionais. Entre os participantes estratégicos estão Samsung, SK Hynix e Micron.

A captação representa provavelmente a última rodada privada antes do IPO da empresa. A Anthropic planeja usar os recursos para avançar em pesquisas de segurança e interpretabilidade, expandir capacidade computacional e escalar produtos e parcerias. No mesmo dia do anúncio, a empresa lançou o modelo Claude Opus 4.8.

A receita recorrente anual cruzou os US$ 47 bilhões ainda em maio de 2026, e a empresa espera um crescimento de receita de 130% que a levará ao seu primeiro trimestre operacionalmente lucrativo. Para investidores e líderes corporativos, esses números refletem um reposicionamento profundo do mercado: as grandes apostas em IA já não são especulativas — são consideradas infraestrutura crítica.
'@
$translations.Add([PSCustomObject]@{url="https://techcrunch.com/2026/05/28/anthropic-raises-65-billion-nears-1t-valuation-ahead-of-ipo/";title_pt="Anthropic capta US$ 65 bilhões e se aproxima de avaliação de US$ 1 trilhão antes do IPO";summary_pt=$t20s})

# ── Artigo 21 ──────────────────────────────────────────────────────────────────
$t21s = @'
Por décadas, a infraestrutura da internet foi projetada para humanos: padrões de tráfego previsíveis, sessões longas, interações pontuais. Os agentes de IA quebram esse modelo: eles podem disparar centenas de requisições simultâneas em segundos, consultar múltiplos bancos de dados, chamar APIs em paralelo e desaparecer tão rapidamente quanto chegaram. Essa diferença de comportamento está forçando uma reconstrução profunda da infraestrutura de nuvem.

A AWS lançou a próxima geração do OpenSearch Serverless — um banco de dados vetorial totalmente gerenciado que escala instantaneamente para picos de tráfego de agentes e retorna a zero quando ocioso. Outros provedores seguem o mesmo caminho: Cloudflare, Microsoft Azure, Databricks e Snowflake se reposicionam para atender tráfego de agentes.

Os dados confirmam a tendência: a Cloudflare estima que bots já representam 31% do tráfego HTTP global, e projeta que o tráfego não humano superará o humano ainda no primeiro semestre de 2027. Para arquitetos de sistemas, toda decisão de infraestrutura tomada hoje precisa considerar que os principais "usuários" de amanhã não serão pessoas — serão agentes autônomos.
'@
$translations.Add([PSCustomObject]@{url="https://techcrunch.com/2026/05/28/the-internet-is-being-rebuilt-for-machines/";title_pt="A internet está sendo reconstruída para máquinas";summary_pt=$t21s})

# ── Artigo 22 ──────────────────────────────────────────────────────────────────
$t22s = @'
A coluna "AI Hype Index" da MIT Technology Review registra um momento incomum: em cerimônias de formatura em universidades americanas, discursos de executivos do setor de tecnologia sobre IA foram recebidos com vaias dos formandos. O ex-CEO do Google Eric Schmidt, ao dizer que a missão dos formandos era ajudar a moldar a IA, ouviu um coro de desaprovação — ao que reconheceu que os medos sobre desemprego e um futuro incerto são "racionais".

O episódio captura uma tensão crescente na sociedade: ao mesmo tempo em que a IA continua avançando e atraindo investimentos recordes, a geração que está entrando no mercado de trabalho demonstra ceticismo explícito e até hostilidade em relação à tecnologia. Para líderes empresariais, isso representa um sinal de alerta importante sobre a necessidade de narrativas mais honestas e empáticas ao comunicar estratégias de adoção de IA.
'@
$translations.Add([PSCustomObject]@{url="https://www.technologyreview.com/2026/05/28/1138053/the-ai-hype-index-ai-gets-booed-in-graduation-season/";title_pt="O Índice de Hype da IA: a IA recebe vaias na temporada de formatura";summary_pt=$t22s})

# ── Artigo 23 ──────────────────────────────────────────────────────────────────
$t23s = @'
O relatório da McKinsey examina como a ADEO, grupo francês de varejo de home improvement que controla marcas como Leroy Merlin, está se preparando estrategicamente para a transformação impulsionada pela inteligência artificial no setor varejista. A ADEO apostou em criar uma infraestrutura de dados unificada que conecta suas diversas unidades de negócio ao redor do mundo, permitindo que algoritmos de IA personalizem a experiência de compra, otimizem estoques e melhorem a cadeia de abastecimento.

A empresa investe em capacitação interna para que colaboradores em toda a organização possam usar ferramentas de IA no dia a dia, disseminando a cultura de dados como diferencial competitivo. O caso da ADEO ilustra que a transformação por IA no varejo não é apenas uma questão tecnológica, mas organizacional: exige governança de dados robusta, alinhamento entre áreas de negócio e TI, e liderança disposta a tolerar experimentos e falhas rápidas.

A conclusão do artigo reforça que o varejo do futuro pertence a quem conseguir transformar volume massivo de dados em decisões inteligentes em tempo real. Mesmo grupos tradicionais e multigeográficos podem liderar essa onda se investirem de forma consistente em fundações de dados e em uma cultura organizacional orientada à IA.
'@
$translations.Add([PSCustomObject]@{url="https://www.mckinsey.com/industries/retail/our-insights/building-the-ai-advantage-how-adeo-is-preparing-for-retails-next-wave";title_pt="Construindo a vantagem da IA: como a ADEO se prepara para a próxima onda do varejo";summary_pt=$t23s})

# ── Artigo 24 ──────────────────────────────────────────────────────────────────
$t24s = @'
Este artigo da McKinsey descreve como a IA agêntica está transformando radicalmente os modelos de entrega de software. O ponto de partida é um modelo de trabalho de 24 horas: durante o dia, equipes humanas revisam entregas e refinam guardrails; durante a noite, agentes de IA executam tarefas estruturadas em escala. Empresas pioneiras já relatam ganhos de três a cinco vezes na produtividade, com redução de 60% no tamanho das equipes.

O artigo estrutura a transformação em quatro pilares: o sprint diário de 24 horas; a automação de handoffs entre requisitos, código e testes; a construção de uma infraestrutura de conhecimento em grafos semânticos como memória institucional; e a captura de valor por meio do redimensionamento de equipes.

Para líderes de tecnologia, as implicações são profundas: as funções de engenharia migrarão de produção manual de código para supervisão, revisão arquitetural e modelagem de domínio. As organizações que começarem agora a reconstruir seu modelo operacional em torno da colaboração humano-agente redefinirão como o software cria valor.
'@
$translations.Add([PSCustomObject]@{url="https://www.mckinsey.com/capabilities/mckinsey-technology/our-insights/rewiring-software-delivery-for-the-agentic-era";title_pt="Reconfigurando a entrega de software para a era agêntica";summary_pt=$t24s})

# ── Artigo 25 ──────────────────────────────────────────────────────────────────
$t25s = @'
Esta edição do boletim diário The Download da MIT Technology Review traz dois temas centrais: a onda de IPOs de empresas de tecnologia climática e o retorno do Índice de Hype da IA. No front climático, Solv Energy, X-energy e Fervo Energy abriram capital com valuations bilionários em 2026, impulsionadas pela demanda crescente por energia limpa — em grande parte alimentada pelos data centers da era da IA.

Outros destaques incluem: a ByteDance desenvolvendo CPUs customizadas diante da escassez de chips de IA; quatro gigantes da tecnologia (Amazon, Google, Meta e Microsoft) se unindo a uma iniciativa de energia limpa para data centers; e Jensen Huang, da Nvidia, ingressando no conselho da Universidade Tsinghua em Pequim. A newsletter oferece um panorama rico da interseção entre IA, energia e geopolítica.
'@
$translations.Add([PSCustomObject]@{url="https://www.technologyreview.com/2026/05/28/1138085/the-download-climate-tech-ipos-ai-hype-index/";title_pt="O Download: empresas de tecnologia climática abrem capital e o Índice de Hype da IA retorna";summary_pt=$t25s})

# ── Artigo 26 ──────────────────────────────────────────────────────────────────
$t26s = @'
Baseado na Pesquisa Global B2B Pulse 2026 da McKinsey com quase 4.000 tomadores de decisão em 13 países, este artigo revela uma divisão crescente entre líderes e retardatários no mercado B2B. A conclusão central é que omnichannel e e-commerce, antes diferenciais competitivos, tornaram-se o mínimo necessário para sobreviver. Setenta e um por cento das empresas B2B já oferecem e-commerce, e cerca de um terço das receitas flui por canais digitais.

O estudo identifica três motores que separam os líderes dos demais: hiperpersonalização real (um para um), escalonamento de IA generativa integrada aos fluxos comerciais e governança disciplinada de marketing baseado em contas (ABM). Sessenta por cento dos líderes reportam crescimento de receita de dois dígitos, contra apenas 21% dos retardatários.

As implicações práticas para empresas B2B são significativas: não basta investir em qualquer uma dessas capacidades isoladamente. A vantagem real vem da integração — dados unificados de clientes que alimentam modelos de IA, que por sua vez habilitam personalização em escala, gerida com accountability clara de vendas.
'@
$translations.Add([PSCustomObject]@{url="https://www.mckinsey.com/capabilities/growth-marketing-and-sales/our-insights/the-surprising-economics-of-b2b-growth-the-new-survival-threshold-and-what-it-takes-to-thrive";title_pt="A economia surpreendente do crescimento B2B: o novo limiar de sobrevivência e o que é preciso para prosperar";summary_pt=$t26s})

# ── Artigo 27 ──────────────────────────────────────────────────────────────────
$t27s = @'
A Glean, frequentemente descrita como o "Google para empresas", anunciou ter alcançado US$ 300 milhões em receita recorrente anualizada, representando um crescimento de três vezes em apenas 15 meses. O crescimento é notável porque acontece justamente quando grandes concorrentes como Google, Microsoft, OpenAI e Anthropic entram agressivamente no mercado de busca empresarial com IA.

O diferencial competitivo da Glean está no "context graph" — uma camada de conhecimento construída por meio da conexão com os sistemas internos das empresas (CRM, Slack, e-mail, repositórios de código etc.), que permite que a IA entenda profundamente o contexto do negócio de cada cliente. Esse contexto rico faz com que os modelos de IA precisem consumir muito menos tokens para responder perguntas, traduzindo-se em redução significativa dos custos de IA para os clientes.

Para líderes de tecnologia, o caso da Glean ilustra uma tendência crescente: ferramentas de IA que demonstram ROI claro em redução de custos operacionais têm maior facilidade de venda em um ambiente corporativo cada vez mais criterioso com gastos em IA.
'@
$translations.Add([PSCustomObject]@{url="https://techcrunch.com/2026/05/28/gleans-top-line-crosses-300m-as-ai-budget-cutting-becomes-its-major-selling-point/";title_pt="Receita da Glean ultrapassa US$ 300 milhões com corte de custos de IA como principal argumento de venda";summary_pt=$t27s})

# ── Artigo 28 ──────────────────────────────────────────────────────────────────
$t28s = @'
A Asana anunciou a aquisição da StackAI por US$ 75 milhões, incorporando ao seu portfólio uma plataforma de automação de fluxos de trabalho com IA que permite criar agentes que operam dentro de sistemas empresariais existentes como Salesforce, Slack e Google Workspace, sem necessidade de programação.

A Asana enquadra a aquisição como parte de sua transformação estratégica rumo a ser uma plataforma nativa de IA, posicionando-se como o "sistema operacional para equipes humano-agente". O contexto financeiro da Asana é desafiador — a empresa perdeu mais da metade de seu valor de mercado desde o lançamento do ChatGPT —, mas a nova liderança aposta nos produtos de trabalho humano-agente para uma recuperação.

Para executivos e líderes de tecnologia, esta aquisição sinaliza uma consolidação acelerada no mercado de ferramentas de automação e IA empresarial. O movimento reflete a corrida das plataformas de gestão de trabalho para incorporar capacidades agênticas antes que grandes provedores de nuvem ocupem esse espaço.
'@
$translations.Add([PSCustomObject]@{url="https://techcrunch.com/2026/05/28/asana-acquires-no-code-agent-builder-stack-ai/";title_pt="Asana adquire a StackAI, plataforma de criação de agentes sem código";summary_pt=$t28s})

# ── Artigo 29 ──────────────────────────────────────────────────────────────────
$t29s = @'
Este artigo da McKinsey explora como as lideranças corporativas devem repensar a governança diante da transformação acelerada pela IA. Executivos de segurança e membros de conselhos de administração identificam quatro prioridades centrais: fortalecer a governança e a accountability, equilibrar inovação com gestão de riscos, construir capacidades de gestão de risco em tempo real e melhorar a fluência em IA nos conselhos.

O debate destaca que a IA representa a maior transformação da geração atual: diferente de software convencional, ela é embedded em todos os sistemas e modifica o paradigma de segurança para uma superfície de ataque multidirecional. Organizações líderes em engenharia estão avançando rapidamente porque integram segurança ao design dos sistemas desde o início.

Para conselhos e líderes de tecnologia, as implicações práticas incluem: criar comitês de tecnologia dedicados com fluência em IA, estabelecer frameworks de IA responsável com revisão contínua, e aprender com os erros de outros sem esperar errar internamente. A IA está cruzando o limiar de tópico de inovação para risco corporativo central, exigindo novos modelos de reporte e accountability explícita.
'@
$translations.Add([PSCustomObject]@{url="https://www.mckinsey.com/capabilities/mckinsey-technology/overview/cybersecurity/the-boards-role-in-managing-emerging-ai-risks";title_pt="O papel do conselho na gestão dos riscos emergentes de IA";summary_pt=$t29s})

# ── Artigo 30 ──────────────────────────────────────────────────────────────────
$t30s = @'
Esta edição do The Download da MIT Technology Review aborda como acompanhar o ritmo acelerado das novidades em IA e uma reportagem aprofundada sobre como novas tecnologias estão transformando o processo de fertilização in vitro (FIV). Pesquisadores estão usando IA para identificar espermatozoides e embriões com maior potencial, desenvolvendo sistemas robóticos para automatizar partes do processo e explorando técnicas de edição genética para prevenir doenças hereditárias.

Os destaques adicionais incluem: a NASA revelando planos para três missões não tripuladas à Lua em 2026; a Huawei anunciando um avanço no design de chips que a posicionaria como líder em cinco anos; e o crescimento acelerado da demanda por especialistas em cibersegurança impulsionado pelo boom da IA. Para executivos de tecnologia e líderes da área de saúde, esta edição sinaliza a convergência acelerada entre IA e biomedicina.
'@
$translations.Add([PSCustomObject]@{url="https://www.technologyreview.com/2026/05/27/1138048/the-download-ai-future-ivf-technology/";title_pt="O Download: acompanhando a IA e o futuro da fertilização in vitro";summary_pt=$t30s})

# ── Artigo 31 ──────────────────────────────────────────────────────────────────
$t31s = @'
Esta edição do The Download da MIT Technology Review confronta a narrativa dominante sobre o impacto da IA no mercado de trabalho com o que os dados realmente mostram. A análise dos dados trabalhistas dos EUA revela que o desemprego nas ocupações mais expostas à IA está, na verdade, mais baixo do que em empregos menos expostos. Também não há sinais de migrações em massa de trabalhadores de profissões ameaçadas para empregos manuais.

Em paralelo, um artigo de opinião alerta para um problema mais silencioso: a IA pode estar enfraquecendo o primeiro degrau da escada de carreira. Um estudo de Stanford encontrou queda acentuada no emprego de trabalhadores jovens em ocupações expostas à IA após a disseminação da IA generativa, sugerindo que a tecnologia está substituindo as tarefas juniores que antes davam aos jovens sua primeira experiência profissional.

Para líderes empresariais, a mensagem prática é clara: ao invés de reagir a manchetes alarmistas, é necessário adotar uma análise granular de como a IA está afetando diferentes segmentos da força de trabalho.
'@
$translations.Add([PSCustomObject]@{url="https://www.technologyreview.com/2026/05/26/1138028/the-download-ai-jobs-data/";title_pt="O Download: desmistificando o pânico sobre IA e empregos";summary_pt=$t31s})

# ── Artigo 32 ──────────────────────────────────────────────────────────────────
$t32s = @'
Este artigo da McKinsey examina como o Japão, historicamente líder em robótica industrial, corre o risco de perder protagonismo na próxima onda da robótica: máquinas de uso geral alimentadas por IA avançada. O mercado global de robótica de uso geral deve crescer de menos de US$ 1 bilhão em 2025 para US$ 370 bilhões em 2040. O Japão almeja capturar 30% desse mercado, mas enfrenta déficits sérios: perde para China e EUA em patentes de humanoides, em ecossistemas de startups e em velocidade de comercialização.

O artigo detalha duas abordagens competitivas emergentes: a chinesa (hardware-first, foco em implantação massiva para coleta de dados) e a americana (AI-centric, prioridade em autonomia e software). Para os fabricantes japoneses, os autores recomendam aproveitar a tradição de coordenação precisa de componentes para criar plataformas de software unificadas e desenvolver modelos de negócio de Robotics as a Service (RaaS).

A conclusão é inequívoca: a próxima fase da competição em robótica não será vencida apenas por hardware — dependerá de como as empresas combinam engenharia de precisão com IA, dados e implantação em larga escala.
'@
$translations.Add([PSCustomObject]@{url="https://www.mckinsey.com/industries/industrials/our-insights/japans-100-billion-opportunity-in-general-purpose-robotics";title_pt="A oportunidade de US$ 100 bilhões do Japão em robótica de uso geral";summary_pt=$t32s})

# ── Artigo 33 ──────────────────────────────────────────────────────────────────
$t33s = @'
Este artigo aborda a crescente lacuna entre ambição e execução na adoção corporativa de IA agêntica. Embora 85% das organizações declarem querer ser "agênticas" nos próximos três anos, 76% afirmam que sua infraestrutura e operações atuais não suportam essa mudança. O problema central é que as empresas estão adicionando agentes de IA como "fita adesiva" sobre modelos operacionais projetados para humanos, em vez de redesenhar a organização.

O artigo apresenta o conceito de Agentic Business Transformation (ABT), estruturado em três pilares: a stack tecnológica (que deve ser reconfigurada para que agentes atuem como tecido conectivo); a força de trabalho (onde gestores precisarão gerenciar equipes híbridas humano-agente); e as métricas de sucesso (que devem migrar de outputs para outcomes).

Para líderes empresariais, a conclusão prática é que implantar IA agêntica sem redesenhar o modelo operacional, a força de trabalho e as métricas de sucesso é uma receita para frustração e desaceleração do ROI. A transformação agêntica é uma mudança de sistema, não uma iniciativa pontual de tecnologia.
'@
$translations.Add([PSCustomObject]@{url="https://www.technologyreview.com/2026/05/26/1137584/rethinking-organizational-design-in-the-age-of-agentic-ai/";title_pt="Repensando o design organizacional na era da IA agêntica";summary_pt=$t33s})

# ── Artigo 34 ──────────────────────────────────────────────────────────────────
$t34s = @'
O relatório anual da McKinsey sobre o setor bancário global registra outro ano de resultados recordes: lucro líquido global de US$ 1,3 trilhão em 2025, alta de 7% sobre 2024. Ao mesmo tempo, o relatório lança um alerta: os múltiplos de valuation dos bancos continuam sendo os mais baixos de qualquer setor, sugerindo que investidores não acreditam que o desempenho atual seja sustentável.

O relatório identifica quatro ameaças convergentes: fintechs maduras que já respondem por 17% das receitas combinadas com bancos tradicionais; neobancos como Revolut (69 milhões de clientes, ROE de 35%) e Nubank (131 milhões de clientes, ROE de 30%); IA agêntica e stablecoins que permitem que clientes otimizem depósitos e crédito sem os bancos tradicionais; e mudança no comportamento dos consumidores jovens, cuja confiança em fintechs já supera a dos bancos tradicionais.

A resposta estratégica preconizada é "precisão com velocidade": os bancos que adotarem IA de forma estratégica — não necessariamente os maiores, mas os mais ágeis — capturarão participação de mercado dos retardatários em ritmo acelerado e sem precedentes históricos.
'@
$translations.Add([PSCustomObject]@{url="https://www.mckinsey.com/industries/financial-services/our-insights/global-banking-annual-review";title_pt="Revisão Anual Global de Bancos 2026: Precisão com velocidade";summary_pt=$t34s})

# ── Artigo 35 ──────────────────────────────────────────────────────────────────
$t35s = @'
Neste podcast da McKinsey, Stéphane Bancel, CEO da Moderna, explica como a tecnologia mRNA e a IA estão inaugurando uma nova era de medicina personalizada que rompe com o modelo de "tamanho único para todos". A ideia central é que a biologia é fundamentalmente uma ciência baseada em informação: o mRNA é uma molécula de informação que instrui as células a produzirem respostas imunológicas específicas, permitindo que medicamentos sejam projetados como software.

O exemplo mais concreto é o tratamento individualizado para câncer de pele: se dois pacientes forem diagnosticados com melanoma no mesmo dia, a Moderna produzirá um medicamento quimicamente diferente para cada um, baseado na instabilidade específica do DNA de cada pessoa. Dados de cinco anos de sobrevivência mostram 50% de melhoria em relação ao tratamento padrão.

A IA está acelerando dois fronts: na descoberta de medicamentos, robôs realizam experimentos e dados retroalimentam sistemas de IA em ciclos contínuos; na operação corporativa, a empresa integra IA em RH, vendas, manufatura robótica e gestão de qualidade. Para líderes de saúde e tecnologia, a medicina personalizada em escala industrial não é ficção científica, mas uma realidade comercial a dois anos de distância.
'@
$translations.Add([PSCustomObject]@{url="https://www.mckinsey.com/industries/life-sciences/our-insights/the-next-era-of-healthcare-is-personal";title_pt="A próxima era da saúde é pessoal";summary_pt=$t35s})

# ── Artigo 36 ──────────────────────────────────────────────────────────────────
$t36s = @'
Este conteúdo no formato "Author Talks" da McKinsey apresenta uma conversa com um autor que realizou um experimento prático de um ano para explorar e testar os limites reais da inteligência artificial em contextos profissionais e criativos. O formato da McKinsey costuma combinar entrevistas com insights práticos aplicáveis a líderes empresariais sobre como usar IA de forma inteligente e responsável, evitando tanto o ceticismo excessivo quanto o entusiasmo acrítico.
'@
$translations.Add([PSCustomObject]@{url="https://www.mckinsey.com/featured-insights/mckinsey-on-books/author-talks-testing-ais-limits-in-a-one-year-experiment";title_pt="Conversas com Autores: Testando os limites da IA em um experimento de um ano";summary_pt=$t36s})

# ── Artigo 37 ──────────────────────────────────────────────────────────────────
$t37s = @'
O artigo da McKinsey argumenta que, no setor industrial, a próxima década será definida por empresas e líderes que adotam uma postura proativa de construção — seja de novos negócios, capacidades digitais ou modelos operacionais — em vez de apenas otimizar o que já existe. O foco em "builders" sugere que a vantagem competitiva no setor industrial virá da capacidade de criar ativamente novas fontes de valor, aproveitando tendências como IA, automação e transição energética.

A mensagem central é que empresas industriais tradicionais que ficarem presas em ciclos de otimização incremental perderão para novos entrantes mais ágeis que constroem ao redor das tecnologias emergentes. Para líderes do setor, o momento de agir é agora — a janela para construir vantagens duradouras está se fechando.
'@
$translations.Add([PSCustomObject]@{url="https://www.mckinsey.com/capabilities/business-building/our-insights/for-industrials-the-next-decade-belongs-to-builders";title_pt="Para empresas industriais, a próxima década pertence aos construtores";summary_pt=$t37s})

# ── Artigo 38 ──────────────────────────────────────────────────────────────────
$t38s = @'
O setor de energia renovável, especialmente eólica onshore e solar fotovoltaica, cresce rapidamente — mas juros altos, inflação e queda nos preços de energia estão comprimindo margens. A análise da McKinsey revela uma lacuna de desempenho de 12 a 15% entre portfólios medianos e os de melhor desempenho, com valor potencial não capturado de até 9,1 milhões de euros por GW ao ano em eólica onshore.

O artigo defende que a operação e manutenção (O&M) representa uma oportunidade significativa e frequentemente negligenciada. Ferramentas de manutenção preditiva baseadas em dados, agendamento otimizado por IA generativa, pacotes de trabalho digitais para técnicos em campo e gestão autônoma de inventário podem transformar operações fragmentadas em sistemas integrados e prescritivos.

Para líderes do setor, rever a estratégia de O&M não é apenas uma oportunidade — é um imperativo competitivo. Em um ambiente onde as margens estão sob pressão, operadores que combinam técnicas convencionais sólidas com soluções habilitadas por IA estarão melhor posicionados para sustentar a rentabilidade de seus portfólios crescentes.
'@
$translations.Add([PSCustomObject]@{url="https://www.mckinsey.com/industries/electric-power-and-natural-gas/our-insights/renewables-o-and-m-reimagined-boosting-performance-with-ai-and-conventional-levers";title_pt="Operação e manutenção de renováveis reimaginadas: melhorando o desempenho com IA e alavancas convencionais";summary_pt=$t38s})

# ── Artigo 39 ──────────────────────────────────────────────────────────────────
$t39s = @'
O artigo parte de uma constatação central: com quase 90% das organizações usando IA em pelo menos uma função de negócios, o acesso aos mesmos grandes modelos de linguagem está se tornando onipresente — e, portanto, não constitui diferencial. Assim como apps e sites não geraram vantagem sustentável por si sós, a adoção genérica de IA tampouco garante retornos superiores. A verdadeira competição agora se dá na capacidade de transformar modelos comuns em fossos competitivos difíceis de replicar.

Os autores identificam seis fossos estratégicos: economias de escala, dados privilegiados, embeddedness (soluções indispensáveis ao integrar fluxos de trabalho centrais), efeitos de rede, disrupção de modelo de negócio, e ativos físicos escassos. O artigo traz exemplos quantificados: a DBS Bank reduziu o tempo de desenvolvimento de soluções de IA de 12-18 meses para 2-3 meses; o JPMorgan Chase reporta retornos de IA próximos a US$ 2 bilhões anuais.

Para CEOs e conselhos, a prescrição é objetiva: identificar um a três fossos onde se tem vantagem estrutural e construir os sistemas habilitadores que os reforcem ao longo do tempo. Em um ambiente onde os modelos se tornam commodities, vencer significa ser a organização que mais rapidamente converte modelos comuns em fossos incomuns.
'@
$translations.Add([PSCustomObject]@{url="https://www.mckinsey.com/capabilities/quantumblack/our-insights/from-ai-table-stakes-to-ai-advantage-building-competitive-moats";title_pt="De requisito básico de IA a vantagem competitiva: construindo fossos defensáveis";summary_pt=$t39s})

# ── Artigo 40 ──────────────────────────────────────────────────────────────────
$t40s = @'
O artigo argumenta que a adoção de IA no setor imobiliário está acelerando, mas a maioria das iniciativas ainda se concentra em automação de tarefas isoladas, sem transformar fluxos de trabalho de ponta a ponta. O Instituto Global McKinsey estima que a IA pode desbloquear entre US$ 430 bilhões e US$ 550 bilhões em valor ao longo da cadeia imobiliária.

O diferencial entre experimentação e transformação real reside em três práticas: vincular investimentos em IA a impacto mensurável no P&L, ter patrocínio sênior tratando a IA como iniciativa estratégica central, e adotar uma abordagem por domínios — redesenhando fluxos de trabalho completos como locação, operações prediais e gestão de ativos, em vez de automatizar passos individuais. Essa abordagem permite ganhos de 10% a 30% em indicadores como receita operacional líquida.

Os domínios com maior criação de valor incluem instalações e manutenção (triagem de chamados, resolução mais rápida), locação (modelo de atendimento 24/7 que captura mais leads) e operações de back-office onde a IA pode cortar 60% a 80% do tempo necessário.
'@
$translations.Add([PSCustomObject]@{url="https://www.mckinsey.com/featured-insights/mckinsey-explainers/where-ai-is-creating-real-value-in-real-estate";title_pt="Onde a IA está criando valor real no mercado imobiliário";summary_pt=$t40s})

# ── Artigo 41 ──────────────────────────────────────────────────────────────────
$t41s = @'
Em entrevista ao sênior partner da McKinsey, a CEO da HackerOne Kara Sprague descreve um cenário de transformação estrutural na cibersegurança: a superfície de ataque está crescendo (mais modelos de IA e código gerado por IA sendo implantados), essa superfície é mais vulnerável (segurança para implantações de IA ainda é nascente), e os atacantes estão se tornando mais capazes ao adotar modelos de fronteira. O tempo entre descoberta e exploração de vulnerabilidades caiu de mais de dois anos em 2018 para menos de um dia hoje.

Os dados da HackerOne revelam um aumento de 76% nos relatórios de vulnerabilidades ano a ano. A raiz do problema está nos pontos de handoff do fluxo de trabalho tradicional — encontrar, registrar, triar, priorizar e corrigir — que criam acúmulos que não suportam volume crescente.

A resposta exige repensar o modelo operacional de segurança com IA no centro: testes agênticos que replicam o que adversários fariam, validação agêntica para absorver a explosão de volume, e suporte a remediação para acelerar o caminho de achado a correção verificada. Para líderes de tecnologia, a vantagem não irá para a organização que encontrar mais vulnerabilidades, mas para aquela que reduzir sua exposição ao risco mais rapidamente.
'@
$translations.Add([PSCustomObject]@{url="https://www.mckinsey.com/capabilities/mckinsey-technology/our-insights/hackerone-ceo-kara-sprague-on-how-ai-is-reshaping-cybersecurity";title_pt="CEO da HackerOne, Kara Sprague, sobre como a IA está remodelando a cibersegurança";summary_pt=$t41s})

# ── Artigo 42 ──────────────────────────────────────────────────────────────────
$t42s = @'
O artigo utiliza a metáfora da linha de montagem de Ford para argumentar que a IA agêntica representa para o trabalho cognitivo o mesmo que a linha de montagem representou para o trabalho físico: uma reorganização fundamental que não é apenas tecnológica, mas cultural e organizacional. Assim como Ford reduziu o tempo de montagem de um Model T de 12 horas para 90 minutos, a IA agêntica pode comprimir ciclos de decisão de semanas para minutos.

O problema central identificado é que a maioria das empresas trata a IA como projeto de tecnologia aplicado a domínios funcionais isolados — e colhe apenas retornos incrementais. Para escalar valor, CEOs devem agir como arquitetos-chefes da transformação: quebrar silos entre times de tecnologia e negócio, padronizar dados e ferramentas, e redefinir metas de talentos.

A infraestrutura tecnológica central é a camada de orquestração agêntica — uma plataforma que gerencia o fluxo de tarefas entre agentes funcionais e agentes empresariais. Casos concretos: a Toshiba Tec expandiu a cobertura de personalização de catálogos de 8% para quase 100%; uma montadora reduziu custos de capital de giro em 20% e gerou US$ 200 milhões de lucro adicional no primeiro ano.
'@
$translations.Add([PSCustomObject]@{url="https://www.mckinsey.com/industries/industrials/our-insights/the-ai-assembly-line-strategic-imperatives-for-ceos";title_pt="A linha de montagem de IA: imperativos estratégicos para CEOs";summary_pt=$t42s})

# ── Artigo 43 ──────────────────────────────────────────────────────────────────
$t43s = @'
O artigo contextualiza uma virada estrutural nos mercados agrícolas: em 2025, o pool de lucros do trading de commodities agrícolas caiu 15% em relação ao ano anterior, pressionado por volatilidade climática crescente, políticas comerciais imprevisíveis, novas regulações de biocombustíveis e gargalos logísticos. O ambiente de 2026 é ainda mais complexo, com o fechamento do Estreito de Ormuz impactando fluxos globais de fertilizantes.

Três tendências estão redefinindo o setor: maior variabilidade de oferta (eventos climáticos extremos, disrupções geopolíticas); entrada de novos participantes sofisticados (hedge funds com estratégias quantamentais, majors de petróleo expandindo para biocombustíveis); e descoberta de preços mais rápida via algoritmos, que estão comprimindo o tempo disponível para os traders agirem sobre sinais fundamentais.

Para traders e processadores, o artigo propõe quatro alavancas de transformação: otimização global da cadeia de valor, modelo operacional ágil com ciclos de planejamento mais curtos, melhoria de qualidade e transparência de dados, e portfólios de analytics ágeis. A IA agêntica em operações pós-negociação deve melhorar a produtividade em 30% a 60% nos próximos dois a quatro anos.
'@
$translations.Add([PSCustomObject]@{url="https://www.mckinsey.com/industries/agriculture/our-insights/how-agility-and-ai-could-rewire-agriculture-trading";title_pt="Como agilidade e IA podem reconectar o trading agrícola";summary_pt=$t43s})

# ── Artigo 44 ──────────────────────────────────────────────────────────────────
$t44s = @'
Este relatório do McKinsey Global Institute analisa dez economias europeias representando mais de três quartos da força de trabalho e do PIB da região. A conclusão central é que 58% das horas de trabalho atuais na Europa poderiam teoricamente ser automatizadas com tecnologias existentes — 44% por agentes de IA para tarefas cognitivas e 14% por robôs para trabalho físico.

O valor econômico potencial é estimado entre US$ 1,1 trilhão (cenário gradual) e US$ 1,9 trilhão (cenário de adoção mais rápida) até 2030, com agentes de IA respondendo por 82% desse valor. A Alemanha lidera com US$ 486 bilhões de potencial, seguida pelo Reino Unido (US$ 375 bilhões) e França (US$ 238 bilhões).

Um achado central e contra-intuitivo é que 75% das competências demandadas por empregadores europeus são usadas tanto em atividades automatizáveis quanto não automatizáveis — o que significa que a maioria das habilidades será aplicada em colaboração com IA, não simplesmente substituída. Para empresas e formuladores de políticas, redesenhar fluxos de trabalho (não apenas automatizar tarefas isoladas) é o que converte potencial técnico em valor econômico real.
'@
$translations.Add([PSCustomObject]@{url="https://www.mckinsey.com/mgi/our-research/agents-robots-and-us-how-ai-reshapes-work-and-skills-in-europe";title_pt="Agentes, robôs e nós: como a IA remodela o trabalho e as competências na Europa";summary_pt=$t44s})

# ── Artigo 45 ──────────────────────────────────────────────────────────────────
$t45s = "Edição de maio de 2026 das palavras cruzadas interativas da McKinsey Quarterly, criada com auxílio de IA e voltada ao público de negócios."
$translations.Add([PSCustomObject]@{url="https://www.mckinsey.com/featured-insights/the-mckinsey-crossword/may-2026";title_pt="Palavras Cruzadas da McKinsey: Feito com IA | N.o 266";summary_pt=$t45s})

# ── Artigo 46 (Gartner) ───────────────────────────────────────────────────────
$t46s = @'
O artigo do Gartner parte de uma tensão fundamental: as ambições de IA nas cúpulas corporativas estão se acelerando — 88% dos CEOs estão aumentando investimentos em IA e 79% antecipam transformação significativa do setor nos próximos três anos —, mas a agilidade da força de trabalho está ficando para trás. A parcela do trabalho de TI gerenciada por agentes de IA deve quase triplicar, de 3% para 8%, em apenas três anos.

O Gartner propõe reorientar o debate: em vez de perguntar o que a IA vai eliminar, CIOs devem liderar a exploração do que ela desbloqueia para a força de trabalho humana. Isso implica três ações essenciais: realocar a capacidade liberada pela IA para atividades de alto valor; promover adaptação emocional com comunicação transparente e programas de requalificação; e redesenhar o trabalho em si — reimaginar papéis, estruturas de equipes e fluxos de trabalho humano-IA.

A mensagem central para CIOs é que a transição para uma força de trabalho integrada humano-IA não é um projeto de TI — é uma transformação do modelo operacional que exige alinhamento entre tecnologia, talento e estratégia empresarial.
'@
$translations.Add([PSCustomObject]@{url="https://www.gartner.com/en/articles/human-ai-workforce";title_pt="Como os CIOs podem construir a força de trabalho humano-IA";summary_pt=$t46s})

# ── Artigo 47 (Gartner) ───────────────────────────────────────────────────────
$t47s = @'
O Gartner analisa a transformação rápida do mercado de agentes de codificação com IA para empresas, que evoluiu de simples ferramentas de autocompletar código para sistemas agênticos que orquestram tarefas complexas ao longo de todo o ciclo de vida de desenvolvimento de software. O mercado é estimado entre US$ 9,8 bilhões e US$ 11,0 bilhões anualizados em abril de 2026. Pesquisas Gartner mostram que 90% dos líderes de engenharia reportam ganhos de produtividade, com ganho médio líquido de 19,3%.

Uma mudança estrutural de 2026 é a entrada de provedores de modelos de fronteira na camada de aplicação, competindo diretamente com fornecedores de ferramentas para desenvolvedores. Dois modelos emergem: ofertas verticalmente integradas e plataformas agnósticas de modelo. Os fluxos de trabalho agênticos estão redefinindo como o desenvolvimento é gerenciado: de assistência single-thread para orquestração multiagente com execução paralela.

Para líderes de tecnologia e engenharia, a implicação central é que a liderança neste mercado exige mais do que ter o produto com mais momentum: requer modelos operacionais claros para governar agentes em produção e estratégias para controlar custos de TCO em workflows agênticos.
'@
$translations.Add([PSCustomObject]@{url="https://www.gartner.com/en/articles/enterprise-ai-coding-agent-market";title_pt="Liderar no mercado de agentes de codificação com IA para empresas exige mais do que momentum de produto";summary_pt=$t47s})

# ── Artigo 48 (Gartner) ───────────────────────────────────────────────────────
$t48s = @'
O Gartner identifica uma crise de valor emergente na IA corporativa: apesar de investimentos recordes, poucas organizações conseguiram provar o valor da IA em escala. Líderes no Fórum Econômico Mundial expressaram preocupações com ROI, volatilidade de preços e comoditização. Pilotos de IA frequentemente ficam estagnados antes de gerar receita significativa, e a instabilidade de fornecedores agrava o problema.

O artigo propõe quatro respostas prioritárias: construir programas de letramento em IA orientados a resultados e diferenciados por função (81% dos CIOs citam lacunas de habilidades como impedimento crítico); diferenciar ofertas de IA para combater a comoditização; estabelecer "tempo para confiança" como métrica central de desempenho de produto; e priorizar P&D em IA agêntica e capacidades especializadas que vão além da automação básica.

A mensagem central para CEOs de tecnologia é urgente: demonstrar retornos lucrativos e restaurar confiança, ou arriscar perder financiamento e credibilidade. A crise de valor da IA não é inevitável — é resultado de estratégias de escala insuficientes, programas de letramento inadequados e falha em diferenciar além de capacidades genéricas.
'@
$translations.Add([PSCustomObject]@{url="https://www.gartner.com/en/articles/ai-value-crisis";title_pt="A IA está enfrentando uma crise de valor — e o que fazer a respeito";summary_pt=$t48s})

# ── Artigo 49 ──────────────────────────────────────────────────────────────────
$t49s = @'
A ativista ambiental Erin Brockovich — conhecida pela batalha histórica contra a Pacific Gas & Electric nos anos 1990, eternizada no filme homônimo — está direcionando sua atenção para um novo alvo: a falta de transparência que envolve a operação dos data centers da era da inteligência artificial.

Com a explosão da demanda por computação de IA, data centers estão sendo construídos em ritmo acelerado em todo o mundo. Porém, poucas informações chegam ao público sobre o impacto ambiental dessas instalações — consumo intenso de água para resfriamento, demanda crescente por energia elétrica e potenciais riscos às comunidades do entorno.

A atuação de Brockovich sinaliza uma tendência importante: a pressão social e regulatória sobre o impacto ambiental da IA tende a crescer. Para líderes de tecnologia e gestores de infraestrutura, transparência proativa e compromissos mensuráveis de sustentabilidade deixam de ser opcionais e passam a ser um requisito para operar com legitimidade pública.
'@
$translations.Add([PSCustomObject]@{url="https://techcrunch.com/2026/05/31/erin-brockovich-takes-aim-at-data-center-secrecy/";title_pt="Erin Brockovich mira o sigilo dos data centers";summary_pt=$t49s})

# ── Artigo 50 ──────────────────────────────────────────────────────────────────
$t50s = @'
Por um quarto de século, a caixa de busca do Google foi uma das interfaces mais reconhecíveis da computação: um retângulo branco, um cursor piscante, algumas palavras digitadas e uma lista de links azuis. No Google I/O de 2026, a empresa anunciou a reformulação mais profunda desse paradigma desde o lançamento do buscador — a primeira mudança real na interface de busca em 25 anos.

A nova interface reflete o reposicionamento estratégico do Google diante da IA generativa: em vez de retornar listas de links, a busca passa a interpretar intenções e fornecer respostas geradas por modelos de linguagem. A mudança vai além da estética — representa uma transformação no modelo de negócio publicitário que sustentou a empresa por décadas.

Para líderes de marketing digital e estratégia de conteúdo, as implicações são diretas: as estratégias de SEO baseadas em posicionamento de links perdem relevância, e a presença nos resultados de IA passa a ser o novo campo de batalha pela atenção dos usuários. Quem não adaptar suas estratégias de conteúdo para ser citado por modelos de IA poderá perder visibilidade significativa nos próximos anos.
'@
$translations.Add([PSCustomObject]@{url="https://venturebeat.com/technology/google-just-redesigned-the-search-box-for-the-first-time-in-25-years-heres-why-it-matters-more-than-you-think";title_pt="Google redesenha a caixa de busca pela primeira vez em 25 anos — e por que isso importa mais do que parece";summary_pt=$t50s})

# ── Artigo 51 ──────────────────────────────────────────────────────────────────
$t51s = @'
A Railway, plataforma de nuvem baseada em San Francisco que acumulou dois milhões de desenvolvedores sem gastar um centavo em marketing, anunciou uma rodada Série B de US$ 100 milhões liderada pela TQ Ventures, com participação de FPV Ventures, Redpoint e outros. A captação ocorre em um momento em que a demanda explosiva por aplicações de inteligência artificial expõe as limitações da infraestrutura de nuvem tradicional.

Ao contrário das grandes provedoras de nuvem, a Railway se posiciona como uma plataforma de deploy simplificada e nativamente adaptada para cargas de trabalho de IA — reduzindo a complexidade operacional que costuma acompanhar implantações em AWS, GCP ou Azure. O modelo de crescimento orgânico, baseado em boca a boca entre desenvolvedores, é um diferencial relevante em um mercado dominado por grandes gastos em marketing.

Para líderes de engenharia e CTOs, a Railway representa uma aposta interessante na simplificação do stack de infraestrutura para IA — especialmente para equipes que buscam velocidade de deploy sem o overhead operacional das nuvens tradicionais. O crescimento da base de usuários sem investimento em marketing sugere forte product-market fit e relevância real no ecossistema de desenvolvimento.
'@
$translations.Add([PSCustomObject]@{url="https://venturebeat.com/infrastructure/railway-secures-usd100-million-to-challenge-aws-with-ai-native-cloud";title_pt="Railway capta US$ 100 milhões para desafiar a AWS com infraestrutura de nuvem nativa para IA";summary_pt=$t51s})

# ── Artigo 52 ──────────────────────────────────────────────────────────────────
$t52s = @'
A revolução da IA no desenvolvimento de software tem um preço elevado. O Claude Code, agente de terminal da Anthropic capaz de escrever, depurar e implantar código de forma autônoma, conquistou a imaginação de desenvolvedores em todo o mundo — mas sua precificação, que varia de US$ 20 a US$ 200 mensais dependendo do uso, gerou crescente resistência entre os próprios programadores que deveria beneficiar.

Surgindo como alternativa de código aberto, o Goose — desenvolvido pela Block — oferece capacidades similares de agente de codificação sem custo de assinatura. A comparação expõe uma tensão estrutural no mercado de ferramentas de IA para desenvolvedores: a adoção acelerada criou dependência de ferramentas pagas, enquanto o ecossistema open source responde com alternativas cada vez mais competitivas.

Para equipes de engenharia e líderes de TI, a escolha entre ferramentas pagas com suporte robusto e alternativas gratuitas com maior risco operacional tornou-se uma decisão estratégica relevante. O custo total de propriedade das ferramentas de IA para desenvolvimento precisa ser avaliado com rigor — custos variáveis baseados em tokens podem tornar orçamentos de engenharia imprevisíveis à medida que o uso escala.
'@
$translations.Add([PSCustomObject]@{url="https://venturebeat.com/infrastructure/claude-code-costs-up-to-usd200-a-month-goose-does-the-same-thing-for-free";title_pt="Claude Code custa até US$ 200 por mês. O Goose faz o mesmo de graça.";summary_pt=$t52s})

# ── Artigo 53 ──────────────────────────────────────────────────────────────────
$t53s = @'
Alfred Wahlforss, fundador da Listen Labs, estava sem opções: sua startup precisava contratar mais de 100 engenheiros, mas competir com os pacotes de US$ 100 milhões oferecidos por Mark Zuckerberg parecia impossível. A solução foi gastar US$ 5.000 — um quinto do orçamento de marketing — em um outdoor em San Francisco exibindo o que parecia ser nonsense: cinco sequências de números aleatórios. Na verdade, eram tokens de IA que, decodificados, revelavam uma mensagem de recrutamento. A campanha viralizou e trouxe a visibilidade necessária para uma rodada de US$ 69 milhões.

A Listen Labs desenvolve uma plataforma de entrevistas com clientes alimentada por IA, permitindo que empresas conduzam pesquisas qualitativas em escala sem a necessidade de moderadores humanos. Os agentes de IA conduzem entrevistas aprofundadas, fazem perguntas de acompanhamento e sintetizam insights — comprimindo semanas de pesquisa qualitativa em horas.

Para líderes de pesquisa de mercado, produto e experiência do cliente, a Listen Labs representa uma mudança significativa na forma como insights podem ser coletados. A democratização de entrevistas qualitativas aprofundadas — antes restrita por custo e tempo — abre caminho para ciclos de feedback muito mais frequentes e granulares com usuários reais.
'@
$translations.Add([PSCustomObject]@{url="https://venturebeat.com/technology/listen-labs-raises-usd69m-after-viral-billboard-hiring-stunt-to-scale-ai";title_pt="Listen Labs capta US$ 69 milhões após viral de outdoor com tokens de IA para escalar entrevistas com clientes";summary_pt=$t53s})

# ── Artigo 54 ──────────────────────────────────────────────────────────────────
$t54s = @'
A Salesforce anunciou uma reformulação completa do Slackbot, o assistente integrado ao Slack, transformando-o de uma simples ferramenta de notificações em um agente de IA totalmente funcional. O novo Slackbot é capaz de buscar dados empresariais, redigir documentos e executar ações em nome dos colaboradores — disputando diretamente o espaço ocupado pelo Microsoft Copilot e pelo Google Workspace AI.

Disponível para clientes Business+ e Enterprise+, o novo Slackbot acessa informações de sistemas integrados como Salesforce CRM, ferramentas de RH e outras aplicações corporativas. A Salesforce posiciona o produto como o "agente nativo" para times que já vivem dentro do Slack, eliminando a necessidade de alternar entre ferramentas para completar tarefas.

Para líderes de tecnologia e operações, a guerra pela IA corporativa no ambiente de trabalho se intensifica: quem definir o assistente padrão nos fluxos de trabalho diários ganhará influência significativa sobre produtividade, dados e adoção de novos produtos. A decisão de qual plataforma de IA adotar para o dia a dia das equipes tem implicações estratégicas de longo prazo para o ecossistema de ferramentas corporativas.
'@
$translations.Add([PSCustomObject]@{url="https://venturebeat.com/technology/salesforce-rolls-out-new-slackbot-ai-agent-as-it-battles-microsoft-and";title_pt="Salesforce lança novo agente de IA no Slackbot em batalha contra Microsoft e Google pela IA corporativa";summary_pt=$t54s})

# ── Artigo 55 ──────────────────────────────────────────────────────────────────
$t55s = @'
A Anthropic lançou o Cowork, uma nova capacidade agêntica que estende o poder do Claude Code — seu produto de maior sucesso — para usuários não técnicos. De acordo com fontes internas, a equipe construiu o recurso inteiro em aproximadamente uma semana e meia, utilizando o próprio Claude Code para isso. O lançamento representa um ponto de inflexão importante na corrida para levar agentes de IA práticos ao público geral.

Ao contrário do Claude Code, que opera via terminal e exige familiaridade técnica, o Cowork atua diretamente sobre arquivos no desktop — analisando documentos, organizando informações, gerando conteúdo e executando tarefas de forma autônoma em interfaces familiares ao usuário comum. Não é necessário escrever código, configurar ambientes ou entender de APIs.

Para líderes de produto e empresas que buscam democratizar o uso de IA internamente, o Cowork sinaliza que a fronteira da automação agêntica avança rapidamente em direção a usuários sem perfil técnico. Ferramentas que antes exigiam engenheiros para serem operadas passam a ser acessíveis a qualquer colaborador, acelerando a adoção corporativa de IA além dos times técnicos.
'@
$translations.Add([PSCustomObject]@{url="https://venturebeat.com/technology/anthropic-launches-cowork-a-claude-desktop-agent-that-works-in-your-files-no";title_pt="Anthropic lança Cowork, agente do Claude Desktop que trabalha nos seus arquivos — sem precisar programar";summary_pt=$t55s})

# ── Artigo 56 ──────────────────────────────────────────────────────────────────
$t56s = @'
A Nous Research, startup de IA de código aberto financiada pela Paradigm — firma de venture capital focada em cripto —, lançou o NousCoder-14B, um novo modelo de programação competitivo. Com apenas 14 bilhões de parâmetros, o modelo afirma igualar ou superar sistemas proprietários muito maiores, e foi treinado em apenas quatro dias usando 48 GPUs Nvidia B200.

O lançamento chega num momento em que ferramentas como o Claude Code dominam a atenção do mercado de desenvolvimento com IA, mas com preços que geram resistência crescente. O NousCoder-14B posiciona-se como uma alternativa open source de alto desempenho para agentes de codificação — potencialmente rodando localmente sem custos de inferência por token.

Para CTOs, líderes de engenharia e times de plataforma, a chegada de modelos open source competitivos em programação tem implicações práticas relevantes: é possível construir agentes de código internos com controle total sobre dados e propriedade intelectual, sem dependência de APIs externas e sem os custos variáveis que têm gerado atrito no mercado de ferramentas de IA para desenvolvimento.
'@
$translations.Add([PSCustomObject]@{url="https://venturebeat.com/technology/nous-researchs-nouscoder-14b-is-an-open-source-coding-model-landing-right-in";title_pt="NousCoder-14B da Nous Research é modelo open source de codificação que chega no momento do Claude Code";summary_pt=$t56s})

# ── Cria lookup por URL ───────────────────────────────────────────────────────
$lookup = @{}
foreach ($t in $translations) { $lookup[$t.url] = $t }

Write-Host "Traducoes carregadas: $($translations.Count)" -ForegroundColor Cyan

# ── Aplica ao RSS ─────────────────────────────────────────────────────────────
$rssPath = "$PSScriptRoot\rss_articles.json"
$rssRaw  = [System.IO.File]::ReadAllText($rssPath, [System.Text.Encoding]::UTF8).TrimStart([char]0xFEFF)
$rssArr  = $rssRaw | ConvertFrom-Json

$updRss = 0
foreach ($art in $rssArr) {
    if ($lookup.ContainsKey($art.url)) {
        $t = $lookup[$art.url]
        $art | Add-Member -NotePropertyName title_pt   -NotePropertyValue $t.title_pt   -Force
        $art | Add-Member -NotePropertyName summary_pt -NotePropertyValue $t.summary_pt -Force
        $updRss++
    }
}

$rssSorted = $rssArr | Sort-Object pub_date -Descending
[System.IO.File]::WriteAllText($rssPath, ($rssSorted | ConvertTo-Json -Depth 5), $utf8NoBom)
$rssJs = $rssSorted | Select-Object title, title_pt, url, summary, summary_pt, source_id, first_seen, pub_date | ConvertTo-Json -Compress
[System.IO.File]::WriteAllText("$PSScriptRoot\rss_data.js", "window.RSS_ARTICLES = $rssJs;", $utf8NoBom)
Write-Host "RSS: $updRss artigos traduzidos e salvos." -ForegroundColor Green

# ── Aplica ao Gartner ─────────────────────────────────────────────────────────
$gartnerPath = "$PSScriptRoot\gartner_articles.json"
$gartnerRaw  = [System.IO.File]::ReadAllText($gartnerPath, [System.Text.Encoding]::UTF8).TrimStart([char]0xFEFF)
$gartnerArr  = $gartnerRaw | ConvertFrom-Json

$updGartner = 0
foreach ($art in $gartnerArr) {
    if ($lookup.ContainsKey($art.url)) {
        $t = $lookup[$art.url]
        $art | Add-Member -NotePropertyName title_pt   -NotePropertyValue $t.title_pt   -Force
        $art | Add-Member -NotePropertyName summary_pt -NotePropertyValue $t.summary_pt -Force
        $updGartner++
    }
}

$gartnerSorted = $gartnerArr | Sort-Object first_seen -Descending
[System.IO.File]::WriteAllText($gartnerPath, ($gartnerSorted | ConvertTo-Json -Depth 5), $utf8NoBom)
$gartnerJs = $gartnerSorted | Select-Object title, title_pt, url, summary_pt, first_seen | ConvertTo-Json -Compress
[System.IO.File]::WriteAllText("$PSScriptRoot\gartner_data.js", "window.GARTNER_ARTICLES = $gartnerJs;", $utf8NoBom)
Write-Host "Gartner: $updGartner artigos traduzidos e salvos." -ForegroundColor Green

Write-Host ""
Write-Host "=== Concluido! $($updRss + $updGartner) artigos com titulo e resumo em portugues ===" -ForegroundColor Cyan
