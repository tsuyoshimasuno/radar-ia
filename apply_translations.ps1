# apply_translations.ps1
# Aplica as traducoes geradas pelos agentes Claude nos arquivos JSON e regenera os JS.

$utf8NoBom = New-Object System.Text.UTF8Encoding $false
$translations = [System.Collections.Generic.List[PSCustomObject]]::new()

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

# ── Artigo 10 ──────────────────────────────────────────────────────────────────
$t10s = @'
O relatório da McKinsey examina como a inteligência artificial está transformando o mercado de pós-venda e serviços nas indústrias automotiva e industrial — segmentos que historicamente respondem pela maior parte das margens das empresas do setor. Em empresas de elevadores e escadas rolantes, por exemplo, os serviços podem representar até três quartos das margens totais.

O artigo detalha como a IA está remodelando cada etapa do ciclo de vida de serviços: da inovação e desenvolvimento de produtos (com gêmeos digitais que reduzem custos de P&D em até 5%) à geração de demanda (copilots de vendas que dobraram as oportunidades de novos contratos em um OEM industrial), passando pela execução de ordens de serviço (diagnóstico remoto que reduziu horas de trabalho por tarefa em 15%).

Apesar do potencial, a McKinsey alerta que apenas cerca de 5% do EBIT das empresas pode ser atribuído ao uso de IA generativa. Os principais obstáculos são: falta de caminho claro do piloto para a escala, gestão insuficiente de dados, baixa adoção por parte das equipes de campo e dificuldades de integração com sistemas existentes.

Para líderes industriais, o roteiro prático é: identificar os dois ou três momentos da jornada de serviço que mais impactam margem e experiência do cliente, definir quais decisões a IA deve automatizar versus apoiar, e garantir ownership claro para os resultados.
'@
$translations.Add([PSCustomObject]@{url="https://www.mckinsey.com/industries/automotive-and-assembly/our-insights/ai-is-already-rewiring-the-aftermarket-and-services";title_pt="A IA já está reconfigurando o pós-venda e os serviços na indústria automotiva e de manufatura";summary_pt=$t10s})

# ── Artigo 19 ──────────────────────────────────────────────────────────────────
$t19s = @'
Este episódio do podcast McKinsey traz o sócio sênior Ido Segev discutindo como a IA representa uma transformação estrutural — e não apenas incremental — para o setor bancário. A questão central para os bancos não é mais se devem adotar IA, mas com que velocidade e profundidade. O maior risco é a inércia: bancos que se moverem cedo capturarão vantagens de custo e rentabilidade que os atrasados não conseguirão recuperar facilmente.

Os números são expressivos: Segev estima que a adoção plena de IA agêntica pode reduzir os custos bancários em 20 a 25%, o equivalente a US$ 250 a US$ 500 milhões por cada US$ 100 bilhões em ativos. Ao mesmo tempo, a competição deve comprimir os lucros da indústria em 9 a 10% ao longo do tempo.

Segev identifica os principais obstáculos para escalar IA nos bancos: falta de foco nas iniciativas, silos entre áreas de negócio e TI, necessidade de requalificação dos funcionários, e a armadilha de confundir capacidade liberada com valor gerado. Para líderes do setor financeiro, as implicações são claras: os vencedores serão os bancos que adotarem IA de forma precisa — não necessariamente os maiores, mas os mais estratégicos.
'@
$translations.Add([PSCustomObject]@{url="https://www.mckinsey.com/industries/financial-services/our-insights/move-first-or-fall-behind-how-ai-is-rewriting-the-rules-of-banking";title_pt="Mova-se primeiro ou fique para trás: como a IA está reescrevendo as regras do setor bancário";summary_pt=$t19s})

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
