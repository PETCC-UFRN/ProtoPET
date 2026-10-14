#import "@preview/abntyp:0.1.5": *
#import "@preview/lilaq:0.6.0" as lq
#import "@preview/algorithmic:1.0.7"
#import algorithmic: style-algorithm, algorithm-figure
#show: style-algorithm

#set page(
  header: none,    // Desliga o cabeçalho da ABNT desde a primeira página
  numbering: none, // Desliga a numeração automática padrão
  background: [
    #place(top + center, image("images/layout/cabecalho.png", width: 100%))
    #place(bottom + center, dy: 0.2cm, image("images/layout/rodape.png", width: 100%))
    #place(
      bottom + right, 
      dx: -1.5cm,  
      dy: -0.5cm,  
      image("images/layout/logo.png", width: 6.5cm) // Tamanho corrigido para não sobrepor texto
    )
  ]
)

#show: dados.with(
  // --- Dados básicos do trabalho ---
  titulo: "Drummies: Desenvolvimento de uma bateria eletrônica embarcada de baixo custo",
  // DICA: Se não tiver subtítulo, remova ou comente a linha abaixo

  // --- Dados do autor ---
  autor: "Gabriel Carvalho Pereira Silva
  Heitor Fernandes Paes Leme Campos",

  // --- Dados da instituição ---
  instituicao: "Universidade Federal do Rio Grande do Norte",
  faculdade: "Departamento de Informática e Matemática Aplicada",
  programa: "PET de Ciência da Computação",
  // DICA para graduação:
  //   programa: "Curso de Bacharelado em Matemática",

  // --- Local e data ---
  local: "Natal",
  ano: 2026,

  // --- Natureza do trabalho ---
  // Para DISSERTAÇÃO de mestrado:
  natureza: "Relatório técnico referente ao ProtoPET, uma iniciativa do PET-CC UFRN(Programa de Educação Tutorial de Ciência da Computação) que visa um aprofundamento técnico dos petianos na área de Sistemas Embarcados.",


  // --- Orientação ---
  orientador: "Prof. Dr. Umberto Souza da Costa",
  // DICA: Se tiver coorientador, descomente:
  // coorientador: "Prof. Dr. Nome do Coorientador",

  // --- Palavras-chave ---
  palavras-chave: ("Sistemas Embarcados", "Instrumentos Musicais", "Baixo-Custo"),
  palavras-chave-en: ("Embedded Systems", "Musical Instruments", "Low-Cost"),
)

#show: normas-abnt.with(
  fonte: "Times New Roman",
)

#set page(margin: (top: 3.5cm, bottom: 3.5cm, left: 3cm, right: 2cm))

// ============================================================================
// PARTE 2: CAPA E FOLHA DE ROSTO
// ============================================================================
//
// A capa e a folha de rosto são elementos obrigatórios (NBR 14724:2024).
// Elas contêm informações essenciais sobre o trabalho.

// ----------------------------------------------------------------------------
// CAPA E FOLHA DE ROSTO
// ----------------------------------------------------------------------------
// Todos os dados vêm automaticamente do dados() acima.
// Não é preciso repetir título, autor, instituição, etc.

#capa()
#folha-rosto()
// ============================================================================
// ELEMENTOS TEXTUAIS
// ============================================================================

#resumo[
    O presente trabalho propõe um modelo de desenvolvimento de uma bateria 
    eletrônica de baixo custo baseada em sistemas embarcados, voltada à 
    prática de instrumentos musicais com capacidade de restringir sua 
    propagação sonora ao ambiente externo. O sistema possui dois modos de 
    funcionamento: O *Modo Jogo*, com uma abordagem gamificada que integra a 
    experiência ao jogo *Clone Hero* e o *Modo Instrumento*, que é dedicado
    a proporcionar uma prática musical mais fiel à realidade, onde a 
    intensidade da interação com os instrumento faz diferença na magnitude 
    do som, o. Ambos tem como ciruito base um microcontrolador *ESP32* que 
    utiliza sensores piezoelétricos para detecção das batidas realizadas
    pelo usuário. O projeto busca demonstrar a viabilidade da construção 
    de instrumentos musicais eletrônicos de baixo custo utilizando tecnologias 
    embarcadas acessíveis. O projeto está disponível 
    #link("https://github.com/PETCC-UFRN/ProtoPET/tree/main/drums")[*nesse*] 
    repositório.
]
= Introdução

A prática de instrumentos musicais está intrinsecamente associada à produção sonora, 
que, em determinados contextos, pode representar um fator limitante para a execução 
e o estudo musical. Instrumentos de natureza predominantemente acústica possuem 
propagação sonora inerente à sua construção, dificultando o controle do volume emitido 
durante sua utilização.

Em ambientes compartilhados ou com elevada proximidade entre habitações, como 
apartamentos e condomínios, essa característica pode comprometer a prática 
musical contínua, uma vez que o som produzido pode causar incômodo a terceiros. 
Sendo assim, torna-se relevante o desenvolvimento de alternativas que permitam a 
execução musical com menor impacto acústico ao ambiente externo.

Nesse contexto, as baterias eletrônicas destacam-se como uma solução amplamente 
empregada para esse problema, possibilitando ao usuário praticar o instrumento 
utilizando fones de ouvido e reduzindo significativamente a propagação sonora no 
ambiente. Entretanto, equipamentos comerciais dessa categoria frequentemente 
apresentam custos elevados, dificultando sua aquisição por estudantes e músicos 
iniciantes.

Dessa forma, o presente trabalho propõe o desenvolvimento de um protótipo de bateria 
eletrônica de baixo custo baseado em sistemas embarcados, utilizando sensores 
piezoelétricos, microcontroladores e comunicação digital para captura e processamento 
dos sinais gerados durante a execução do instrumento. A proposta busca aliar a 
aplicação prática dos conhecimentos da área de Sistemas Embarcados à resolução de uma
demanda real, proporcionando uma experiência de aprendizado alinhada às necessidades
de formação na área.

= Objetivos

O Drummies é um dos projetos desenvolvidos no contexto do *ProtoPET*, cujo objetivo
é proporcionar aos estudantes experiências práticas na área de Sistemas Embarcados. 
Em particular, o projeto busca democratizar o acesso à prática musical por meio do
desenvolvimento de uma bateria eletrônica de baixo custo, conciliando a aplicação
dos conhecimentos técnicos adquiridos durante a formação acadêmica com a busca por
soluções acessíveis a demandas reais.

Além de seus objetivos técnicos e educacionais, o projeto apresenta potencial para
contribuir com a divulgação científica junto à comunidade externa à universidade.
Nesse sentido, o Drummies foi idealizado para ser apresentado na *Mostra de Profissões
da UFRN de 2026*, durante o Espaço Temático do curso de Ciência da Computação. O evento
constitui uma oportunidade de aproximação entre a universidade e os estudantes do
Ensino Médio, permitindo apresentar aplicações práticas da Computação, despertar o
interesse pela área e incentivar o ingresso no curso.

Adicionalmente, o projeto possui caráter educacional ao possibilitar a exploração
prática de conceitos relacionados a Sistemas Embarcados, área contemplada na estrutura
curricular do curso. O desenvolvimento e a demonstração do protótipo também permitem
evidenciar a aplicação de conhecimentos de eletrônica, programação e processamento de
sinais na construção de um sistema funcional, contribuindo para a articulação entre
os fundamentos teóricos e sua aplicação prática.

= Fundamentação Teórica

Os conhecimentos mobilizados ao longo do desenvolvimento do projeto podem ser 
organizados, de maneira geral, em duas grandes categorias complementares: Software e 
Hardware.

== Software

Os conhecimentos relacionados a Software abrangem os aspectos lógicos e computacionais
do projeto, incluindo o desenvolvimento de algoritmos, a implementação do código e o
processamento dos dados, ou seja, os elementos responsáveis por definir o comportamento
do sistema, independentemente de sua materialização física.

=== Requisitos

 Requisitos funcionais descrevem os serviços que o sistema deve fornecer, suas respostas
a entradas específicas e os comportamentos esperados em determinadas situações
#citar("Sommerville", "2016"). Já os requisitos não-funcionais estabelecem 
restrições e critérios de qualidade que não dizem respeito diretamente às funcionalidades
do sistema, como tempo de resposta, uso de memória e segurança. Ambos são fundamentais na
Engenharia de Software, pois orientam o desenvolvimento e estabelecem metas a serem alcançadas
durante a implementação do projeto.

=== MIDI

O MIDI (_Musical Instrument Digital Interface_) é um padrão amplamente utilizado na
indústria musical para estabelecer a comunicação entre instrumentos eletrônicos,
controladores e softwares de produção musical. Por meio dele, são transmitidos dados
que descrevem eventos musicais, como notas, altura sonora (pitch), velocidade de 
acionamento e outros mais. Ao longo do projeto, esse recurso foi empregado no *Modo 
Instrumento*, visto que maximiza a compatibilidade do _hardware_ desenvolvido 
com os padrões adotados pelos principais softwares de produção musical.

=== UART

O UART (_Universal Asynchronous Receiver/Transmitter_) se trata de um protocolo usado 
a nível de _hardware_ para a comunicação entre dois atores, um que transmite e outro 
que recebe dados. Não tendo esses estáticos, e podendo alternar seus papéis. Basta que 
haja um linha de transmissão(TX) e uma linha de recebimento(RX), e ambos os dispositivos 
estejam configurados no mesmo _baud rate_(velocidade em bits por segundo).

== Hardware

No que diz respeito à parte física do protótipo, ou seja, o _Hardware_ os conhecimentos 
fundamentais para nortear o projeto foram os seguintes:

== Sensor piezzoelétrico

O efeito piezzoelétrico é uma forma de geração de energia que converte pressão
mecânica em eletricidade, tal fenômeno ocorre em materiais interagindo com
específicos, como cerâmicas piezoelétricas 
#citar("Lima; Santos; Duarte", "2024"). Através dele, o sensor 
piezoelétrico combina latão e Zirconato-Titanato de Chumbo(PZT) para que 
impacto mecânico seja convertido em um pulso elétrico proporcional à força
aplicada. E tal comportamento pode ser aproveitado como entrada da bateria 
a fim de gerar um sinal que posteriormente virará um som de intensidade 
correspondente.

== Microcontrolador

Um Microcontrolador se trata de um computador de pequeno porte contido em 
um único circuito integrado, consistendo em uma Unidade de Processamento 
Central simples, memória temporária e permanente, além de  alguns 
dispositivos periféricos #citar("Wilmshurst", "2007"). Este 
foi utilizado no projeto como receptor, normalizador e processador dos sinais 
recebidos, e posteriormente envia estes para que outra máquina possa interpretá-los.


= Metodologia

Para nortear o desenvolvimento do protótipo, o levantamento de requisitos foi uma
etapa fundamental para guiar as tomadas de decisão ao longo do projeto.

== Requisitos Funcionais

+ *Compatibilidade com MIDI: (RF1)* Visando maximizar a compatibilidade com os _softwares_ de produção musical que são mais tradicionais no mercado, foi imposto que a entrada do sistema deve seguir o padrão . Dessa forma, o funcionamento do projeto não fica restrito ao _software_ que posteriormente será proposto.

+ *Transmissão de som via interface de áudio de escolha: (RF2)* Diferentemente dos instrumentos acústicos, um diferencial dos instrumentos de natureza digital é a possibilidade de propagação do som de maneira mais seletiva. Sendo assim, uma das restrições impostas para o produto final é ser compatível com interfaces capazes de transmitir áudio, tais como P2, P3 e _Bluetooth_.

+ *Som proporcional à intensidade da detecção: (RF3)* O sistema deve relacionar a intensidade do impacto detectado pelos sensores piezoelétricos à intensidade do som reproduzido, garantindo que diferentes intensidades de batida resultem em respostas sonoras correspondentes. Esse requisito é fundamental para proporcionar uma experiência mais próxima à execução de um instrumento acústico, especialmente no Modo Instrumento.

== Requisitos não-funcionais

+ *Baixo custo: (RNF1)* O projeto busca desenvolver uma bateria eletrônica funcional utilizando componentes de baixo custo e fácil aquisição. Essa abordagem visa tornar o instrumento uma alternativa acessível para estudantes, entusiastas e instituições de ensino interessados em explorar conceitos de eletrônica, Sistemas Embarcados e prática musical sem a necessidade de investir em equipamentos comerciais de alto custo.

+ *Ocupar pouco espaço físico (RNF2):* O protótipo deve apresentar dimensões compactas, facilitando sua utilização e seu armazenamento em ambientes com espaço limitado, como apartamentos e residências pequenas. Além disso, a utilização de fones de ouvido permite reduzir a emissão de ruídos para o ambiente externo, favorecendo a prática musical em locais com restrições acústicas.

+ *Baixa latência (RNF3):* O sistema deve minimizar o intervalo entre a detecção de um impacto e a reprodução do som correspondente, preservando a sincronia entre a execução física e a resposta sonora. Para isso, estabelece-se um limite de 300 milissegundos para o processamento do sinal, buscando proporcionar uma experiência de uso satisfatória.

+ *Modularidade: (RNF4)* O protótipo deve apresentar uma estrutura modular, com componentes interconectados por cabos removíveis, de modo a facilitar sua montagem e desmontagem. Essa característica contribui para simplificar o armazenamento, o transporte e a organização do equipamento, complementando o requisito de redução do espaço físico ocupado.


== Especificação

O funcionamento da bateria eletrônica pode ser dividido em três módulos principais: 
aquisição dos sinais, processamento e retorno da interação. A arquitetura proposta busca 
separar essas responsabilidades entre os dispositivos utilizados, reduzindo a 
complexidade de cada componente e tornando o sistema mais modular.

=== Aquisição de sinais

Inicialmente, cada _pad_ da bateria é equipado com um sensor piezoelétrico responsável 
por converter o impacto mecânico em um pulso elétrico cuja amplitude é proporcional à 
intensidade da batida. Esses sinais são encaminhados para um microcontrolador ESP32, 
que realiza a leitura das entradas analógicas, aplica os filtros necessários para 
eliminar ruídos e múltiplas detecções provenientes de uma única vibração, além de 
normalizar os valores para a faixa utilizada pelo padrão MIDI. A aquisição dos sinais 
ocorre através de um algoritmo de scan descrito no pseudocódigo abaixo:

#algorithm-figure(
  "Detecção e Transmissão de Impactos",
  vstroke: .5pt + luma(200),
  {
    import algorithmic: *
  
    
    Procedure(
      "detectarImpactos",
      (),
      {
        Comment[Inicializar comunicação serial e configurar os pads]
        LineBreak

        While(
          "verdadeiro",
          {
            For(
              [$i <- 0$ *to* $n -1$],
              {
                LineComment(
                Assign("valor")[$"lerSensor"("pads"[i])$]
              , "Ler o Sinal do Sensor associado ao pad[i]")
                LineBreak
                If(
                  $"valor" > "pads"[i].min and "intervaloValido"(i)$,
                  {
                    LineComment(
                    Assign("pico")[$"detectarPico"(i)$]
                  , "Identificar o Valor de Pico")
                    LineComment(
                    Assign("intensidade")[$"converterMIDI"("pico")$]
                    , "Registrar Intensidade Convertida")
                    LineComment(Assign("timestamp")[$"tempoAtual"()$], "Registrar Instante Atual")

                    LineComment(
                    Assign(
                      "pacote",
                      $"criarPacote"(i, "intensidade", "timestamp")$,
                    ),
                    "Monta o Pacote")

                    LineComment(
                    Call("transmitir", ("pacote",))
                      , "Transmite evento ao Computador"
                    )

                    
                  },
                )
              },
            )
          },
        )
      },
    )
  },
)
#fonte[Autoria própria (2026).]

Uma alternativa ao _ESP32_ seria usar um Módulo Conversor Analógico-Digital, visto 
que nesse caso pode-se dizer que as funções do _ESP32_ estão sendo sub-utilizadas. 
Mas, conforme definido nos requisitos, o baixo custo geralmente está associado ao uso 
de componentes de fácil acesso. Além disso, a placa por si só tem entradas o suficiente 
para processar os, no máximo, 8 _pads_ possíveis em uma bateria, conforme detalhado abaixo.

#figure(
  image("images/esp32_devkitC_v4_pinlayout.png", width: 100%),
  caption: [_Datasheet_ da Placa de Desenvolvimento ESP32],
)
#fonte[Expressif Systems.]

=== Comunicação

Conforme mostrado anteriormente, o sinal recebido tem uma natureza não linear, e 
isso afeta diretamente a forma na qual o processamento ocorre. A leitura de cada _pad_
ocorre durante um intervalo de 12ms, durante esse tempo a porta lê todos os valores 
recebidos. Note que esse intervalo se mantem dentro da latência estipulada, pois 
supondo todos os _pads_ possíveis em uma bateria(até 8) temos que $8 * 12 < 300$.

Entretanto, o sinal apenas é considerado caso esse esteja no intervalo de 
valores teto e piso definidos para aquele _pad_, o valor mínimo é necessario para não 
atrasar o processamento considerando ruídos no cálculo, e o valor máximo é necessário 
para proteger o sistema de possíveis falhas. Dentre todos os valores lidos que estão 
nesse intervalo, apenas o maior é considerado, sendo este a intensidade da batida.

Uma vez lido o valor, agora é necessário normaliza-lo antes de fazer o envio para o 
computador. E para isso o `min` e o `max` se fazem mais importantes ainda, pois 
estes serão os valores considerados para transformar o valor lido em um número de 
0(`min`) a 127(`max`, teto da interface *MIDI*).

Uma vez conhecido o valor, seu respectivo _pad_ associado é identificado. Com essa informação, o processo de envio para a outra máquina começa. É utilizado o protocolo *UART* para enviar os dados, sendo assim, 
fisicamente se faz necessário que haja um *TX* e um *RX*, presente na entrada USB usada.

A formatação dos dados é feita através de pacotes binários a fim de diminuir o tempo 
de transmissão que formatar em *ASCII*(_American Standard Code for Information Interchange_)
causaria. A especificação era a seguinte:

```cpp
struct __attribute__((packed)) Packet 
{
    uint8_t header;     // Início do pacote
    uint8_t pad;        // Índice do pad
    uint8_t value;      // Valor da batida(entre 0 e 127)
    uint32_t timestamp; // Horário da batida
};
```
=== Retorno da interação

No Modo Jogo, os sinais são interpretados de forma binária, desconsiderando-se a 
intensidade do impacto. Essa abordagem é adequada ao *Clone Hero*, uma vez que a 
jogabilidade depende da detecção das batidas, independentemente de sua intensidade. 
Para implementar essa funcionalidade, o script `clone_hero.py` utiliza a biblioteca 
`pyinput` para mapear os impactos detectados ao pressionamento de teclas específicas 
do teclado, previamente associadas às ações correspondentes no jogo.

Por sua vez, o Modo Instrumento considera a intensidade dos impactos, convertendo-a em
valores de velocidade MIDI. Essa funcionalidade é implementada pelo script `midi.py`, que
utiliza a biblioteca `mido` para transmitir os eventos musicais por meio de uma interface MIDI
virtual. Dessa forma, o protótipo pode ser integrado a softwares de produção musical, como o
*Hydrogen*, utilizado durante os testes para verificar o recebimento dos eventos e sua
associação às respectivas notas MIDI.

= Resultados e Discussão

Para a confecção da estrutura física da bateria, foram utilizados materiais de baixo custo e fácil acesso, tais como recipientes plásticos, papelão, folhas de EVA e tubos PVC. As peças foram divididas em 3 categorias:
- *Tambores:* formados por recipientes plásticos com tampa
- *Pratos:* formados apenas por uma tampa de plástico
- *Pedal:* formado com papelão estruturado
Cada componente continha um sensor piezoelétrico, um conector TS de 1/4 polegadas e tinham sua área de impacto revestida com EVA.

#grid(
  columns: (1fr, 1.8fr),
  gutter: 4pt, 
  align: center + horizon,
  figure(
  image("images/tambor2.jpeg", width: 100%),
  caption: [Tambor da bateria],
),
  figure(
  image("images/tambor2_aberto.jpeg", width: 100%),
  caption: [Tambor por dentro],
),
)
#fonte[Elaborado pelo autor (2026).]

#grid(
  columns: (1fr, 1.8fr),
  gutter: 4pt, 
  align: center + horizon,
  figure(
  image("images/prato.jpeg", width: 100%),
  caption: [Prato da bateria],
),
  figure(
  image("images/prato_ligacao.jpeg", width: 100%),
  caption: [Ligação do Prato],
),
)
#fonte[Elaborado pelo autor (2026).]

#figure(
  image("images/pedal.png", width: 80%),
  caption: [Pedal da bateria],
)
#fonte[Elaborado pelo autor (2026).]

O protótipo final foi composto por 4 Tambores, 3 Pratos e 1 Pedal. Todas as peças foram conectadas a um componente adicional que guardava o microcontrolador _ESP32_, e por fim, organizadas em formato de bateria utilizando uma estrutura de tubos PVC. 

#figure(
  image("images/pote_com_ESP32.jpeg", width: 80%),
  caption: [Pote com _ESP32_],
)
#fonte[Elaborado pelo autor (2026).]

#figure(
  image("images/bateria.jpeg", width: 80%),
  caption: [Bateria inteira],
)
#fonte[Elaborado pelo autor (2026).]

Ao término da implementação, o protótipo foi apresentado na Mostra de Profissões da UFRN (2026) no estande do curso de Bacharelado em Ciência da Computação. A bateria impactou diretamente no estande, ajudando a obter cerca de 160 visitantes registrados nos 2 dias de evento.

Por fim, verificou-se que a maioria dos requisitos estabelecidos foi atendida integralmente ou parcialmente conforme detalhado a seguir.

#heading(numbering: none, level: 23)[Requisitos funcionais:]
\
- *Compatibilidade com MIDI (RF1) — Atendido integralmente:* a compatibilidade da biblioteca
  `mido` facilitou a implementação da comunicação MIDI, permitindo
  atender ao requisito estabelecido.
\
- *Transmissão de som via interface de áudio de escolha (RF2) — Atendido integralmente:* a utilização do Raspbian como
  sistema operacional facilitou a integração dos recursos de áudio e
  Bluetooth, cujos drivers já estavam disponíveis no ambiente.
\
- *Som proporcional à intensidade da detecção (RF3) — Atendido integralmente:* os valores de cada _pad_ são
  normalizados individualmente, considerando os limites mínimo e
  máximo definidos para cada sensor. Dessa forma, a intensidade do
  som reproduzido corresponde à intensidade do impacto detectado.
  
#heading(numbering: none, level: 3)[Requisitos não-funcionais:]

- *Baixo custo (RNF1) — Atendido parcialmente:* o custo total estimado para a
  etapa de construção da bateria foi de R\$ 410,00 distribuído da seguinte
  forma:
  - Estrutura de PVC: R\$ 120,00.
  - Componentes eletrônicos: R\$ 50,00.
  - ESP32: R\$ 40,00.
  - Cabos e Conectores TS de 1/4 polegada:  R\$ 200,00


Note que o sistema necessita de um computador auxiliar para executar os softwares testados (Hydrogen e Clone Hero).  
Um ponto de melhoria possível para o trabalho seria conseguir substituir o computador por 
um celular para fazer o retorno da interação, visto que o grau de acessibilidade do 
dispositivo é maior.

Outro ponto de melhoria seria substituir as ligações via TS de 1/4 polegada por opções de menor custo, dado que o gasto neles representou cerca de 48% do gasto total.

\

- *Ocupar pouco espaço físico (RNF2) — Atendido integralmente:* a bateria ocupa uma área aproximada
  de 2 m² e apresenta altura de cerca de 1,2 m, atendendo ao objetivo
  de limitar o espaço físico necessário para sua utilização.
\
- *Baixa latência (RNF3) — Atendido integralmente:* conforme apresentado na Seção
  4.1.2, a latência observada permaneceu abaixo do limite de 300 ms
  estabelecido para o projeto.
\
- *Modularidade (RNF4) — Atendido parcialmente:* limitações financeiras dificultaram
  a implementação de uma estrutura completamente modular. Além disso,
  os custos adicionais associados a essa característica poderiam
  comprometer o atendimento ao requisito de baixo custo (RNF1).
\

Diante dos resultados obtidos, considera-se que o projeto foi
executado de maneira satisfatória, atendendo à maior parte dos
requisitos estabelecidos e cumprindo seu propósito educacional de
proporcionar experiência prática na área de Sistemas Embarcados.

#bibliography(
  "referencias.bib",
  style: "associacao-brasileira-de-normas-tecnicas",
  title: "REFERÊNCIAS",
  full: true,
)
