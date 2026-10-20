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

  // --- Dados do autor ---
  autor: "Gabriel Carvalho Pereira Silva
  Heitor Fernandes Paes Leme Campos",

  // --- Dados da instituição ---
  instituicao: "Universidade Federal do Rio Grande do Norte",
  faculdade: "Departamento de Informática e Matemática Aplicada",
  programa: "PET de Ciência da Computação",

  // --- Local e data ---
  local: "Natal",
  ano: 2026,

  // --- Natureza do trabalho ---
  natureza: "Relatório técnico referente ao ProtoPET, uma iniciativa do PET-CC UFRN(Programa de Educação Tutorial de Ciência da Computação) que visa um aprofundamento técnico dos petianos na área de Sistemas Embarcados.",

  // --- Orientação ---
  orientador: "Prof. Dr. Umberto Souza da Costa",

  // --- Palavras-chave ---
  palavras-chave: ("Sistemas Embarcados", "Instrumentos Musicais", "Baixo-Custo"),
  palavras-chave-en: ("Embedded Systems", "Musical Instruments", "Low-Cost"),
)

#show: normas-abnt.with(
  fonte: "Times New Roman",
)

// Sobrescreve a formatação dos títulos definida em abntyp/src/core/setup.typ:
// seção secundária em negrito e seção terciária em negrito e itálico.
#show heading.where(level: 2): it => {
  v(1.5em)
  text(weight: "bold", size: 12pt)[
    #if it.numbering != none {
      counter(heading).display()
      h(0.5em)
    }
    #upper(it.body)
  ]
  v(1.5em)
}

#show heading.where(level: 3): it => {
  v(1.5em)
  text(weight: "bold", style: "italic", size: 12pt)[
    #if it.numbering != none {
      counter(heading).display()
      h(0.5em)
    }
    #it.body
  ]
  v(1.5em)
}

#set page(margin: (top: 3.5cm, bottom: 3.5cm, left: 3cm, right: 2cm))

#capa()

#resumo[
    O presente trabalho propõe um modelo de desenvolvimento de uma bateria 
    eletrônica de baixo custo baseada no microcontrolador *ESP32* e sensores piezoelétricos, voltada para a 
    prática musical silenciosa. A iniciativa faz parte do ProtoPET, projeto do PET-CC UFRN (Programa de Educação Tutorial do curso de Ciência da Computação) orientado pelo Prof. Dr. Umberto Souza da Costa, focado no aprofundamento técnico em Sistemas Embarcados. O sistema oferece dois modos de 
    funcionamento: o *Modo Jogo*, com uma abordagem gamificada que integra a 
    experiência ao jogo *Clone Hero*, e o *Modo Instrumento*, que é dedicado 
    a proporcionar uma prática musical mais fiel à realidade, onde a 
    intensidade da interação com os instrumentos faz diferença na dinâmica do som. Ambos têm como circuito-base um microcontrolador *ESP32* que 
    utiliza sensores piezoelétricos para detecção das batidas realizadas 
    pelo usuário. O projeto busca demonstrar a viabilidade da construção 
    de instrumentos musicais eletrônicos de baixo custo utilizando tecnologias 
    embarcadas acessíveis. O projeto está disponível 
    #link("https://github.com/PETCC-UFRN/ProtoPET/tree/main/drums")[*neste*] 
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
ambiente. Entretanto, equipamentos comerciais de entrada com estrutura física (rack) e conectividade USB/MIDI apresentam custos que partem de aproximadamente R\$ 1.400,00 no comércio nacional, dificultando sua aquisição por estudantes e músicos iniciantes.

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

= Metodologia

Para nortear o desenvolvimento do protótipo, o levantamento e a especificação de requisitos foi uma etapa fundamental para guiar as tomadas de decisão ao longo do projeto. Na Engenharia de Software, requisitos funcionais descrevem os serviços que o sistema deve fornecer, suas respostas a entradas específicas e os comportamentos esperados em determinadas situações #citar("Sommerville", "2016"). Por sua vez, os requisitos não-funcionais estabelecem restrições e critérios de qualidade que não dizem respeito diretamente às funcionalidades do sistema, como tempo de resposta, uso de memória e segurança, orientando o desenvolvimento e estabelecendo metas a serem alcançadas durante a implementação.

== Requisitos Funcionais

+ *Compatibilidade com MIDI: (RF1)* Visando maximizar a compatibilidade com os _softwares_ de produção musical que são mais tradicionais no mercado, foi imposto que a entrada do sistema deve seguir o padrão. Dessa forma, o funcionamento do projeto não fica restrito ao _software_ que posteriormente será proposto.

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

A captura dos impactos gerados pelas baquetas inicia-se nos _pads_ da bateria, onde cada um é equipado com um sensor piezoelétrico. Esse componente combina latão e Zirconato-Titanato de Chumbo (PZT) para aproveitar o efeito piezoelétrico — fenômeno que converte pressão mecânica em eletricidade em determinados materiais, como cerâmicas piezoelétricas #citar("Lima; Santos; Duarte", "2024"). Dessa forma, o impacto mecânico exercido na superfície do _pad_ é transformado em um pulso elétrico proporcional à força aplicada.

Os impulsos elétricos gerados pelos sensores são encaminhados para um microcontrolador — um computador de pequeno porte integrado em um único circuito, composto por uma Unidade Central de Processamento simples, memória temporária e permanente, além de periféricos de entrada e saída #citar("Wilmshurst", "2007"). No protótipo, utilizou-se a placa *ESP32*, atuando como receptor, normalizador e processador primário dos sinais. O microcontrolador realiza a leitura das entradas analógicas, aplica os filtros necessários para eliminar ruídos e falsas leituras decorrentes da vibração do material, e normaliza os valores para a faixa do padrão MIDI. A aquisição dos sinais ocorre através de um algoritmo de varredura (_scan_) descrito no pseudocódigo abaixo:

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
recebidos. Note que esse intervalo se mantém dentro da latência estipulada, pois 
supondo todos os _pads_ possíveis em uma bateria(até 8) temos que $8 * 12 < 300$.

Entretanto, o sinal apenas é considerado caso esse esteja no intervalo de 
valores teto e piso definidos para aquele _pad_, o valor mínimo é necessário para não 
atrasar o processamento considerando ruídos no cálculo, e o valor máximo é necessário 
para proteger o sistema de possíveis falhas. Dentre todos os valores lidos que estão 
nesse intervalo, apenas o maior é considerado, sendo este a intensidade da batida.

Uma vez lido o valor, agora é necessário normaliza-lo antes de fazer o envio para o 
computador. E para isso o `min` e o `max` se fazem mais importantes ainda, pois 
estes serão os valores considerados para transformar o valor lido em um número de 
0(`min`) a 127(`max`, teto da interface *MIDI*).

Uma vez conhecido o valor, seu respectivo _pad_ associado é identificado. Com essa informação, inicia-se o processo de envio para a outra máquina. Para realizar a transmissão de dados serial a nível de _hardware_, utiliza-se o protocolo UART (_Universal Asynchronous Receiver/Transmitter_), que estabelece a comunicação assíncrona entre o microcontrolador e o computador receptor por meio de uma linha de transmissão (TX) e uma de recepção (RX) configuradas sob o mesmo _baud rate_ (velocidade em bits por segundo). Na prática, essa interface física é viabilizada pela conexão USB da placa.

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
intensidade do impacto. Essa abordagem é adequada ao Clone Hero, uma vez que a
jogabilidade depende da detecção das batidas, independentemente de sua intensidade.
Para implementar essa funcionalidade, o script clone_hero.py utiliza a biblioteca
pyinput para mapear os impactos detectados ao pressionamento de teclas específicas
do teclado, previamente associadas às ações correspondentes no jogo.

Por sua vez, o Modo Instrumento é dedicado a proporcionar uma prática musical mais fiel e expressiva. Para isso, emprega-se o protocolo MIDI (Musical Instrument Digital Interface), padrão amplamente utilizado na indústria musical para estabelecer a comunicação entre instrumentos eletrônicos, controladores e softwares de produção musical. O MIDI transmite dados digitais que descrevem eventos musicais, como notas, altura sonora (pitch) e a velocidade de acionamento (intensidade da batida). A adoção desse padrão maximiza a compatibilidade do hardware desenvolvido com os softwares do mercado.

Essa funcionalidade é implementada pelo script midi.py, que utiliza a biblioteca mido para transmitir os eventos por meio de uma interface MIDI virtual. Dessa forma, o protótipo pode ser integrado a softwares de produção musical, como o Hydrogen, utilizado durante os testes para verificar o recebimento dos eventos e sua associação às respectivas notas e sons de bateria.

= Resultados e Discussão

Para a confecção da estrutura física da bateria, foram utilizados materiais de baixo custo e fácil acesso, tais como recipientes plásticos, papelão, folhas de EVA e tubos PVC. As peças foram divididas em 3 categorias:

+ *Tambores:* Formados por recipientes plásticos com tampa.
+ *Pratos:* Formados apenas por uma tampa de plástico.
+ *Pedal:* Formado com papelão estruturado.

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
#fonte[Elaborado pelos Autores (2026).]

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
#fonte[Elaborado pelos Autores (2026).]

#figure(
image("images/pedal.png", width: 80%),
caption: [Pedal da bateria],
)
#fonte[Elaborado pelos Autores (2026).]

O protótipo final foi composto por 4 Tambores, 3 Pratos e 1 Pedal. Todas as peças foram conectadas a um componente adicional que guardava o microcontrolador ESP32, e por fim, organizadas em formato de bateria utilizando uma estrutura de tubos PVC.

#figure(
image("images/pote_com_ESP32.jpeg", width: 80%),
caption: [Pote com ESP32],
)
#fonte[Elaborado pelos Autores (2026).]

#figure(
image("images/bateria.jpeg", width: 80%),
caption: [Bateria inteira],
)
#fonte[Elaborado pelos Autores (2026).]

Ao término da implementação, o protótipo foi apresentado na Mostra de Profissões da UFRN (2026) no estande do curso de Bacharelado em Ciência da Computação. A bateria impactou diretamente no estande, ajudando a obter cerca de 160 visitantes registrados nos 2 dias de evento.

== Avaliação dos Requisitos

Após a validação prática do protótipo, avaliou-se o cumprimento das especificações previamente levantadas. Do total de 7 requisitos definidos (3 funcionais e 4 não-funcionais), verificou-se que 5 foram atendidos integralmente e 2 foram atendidos parcialmente, conforme detalhado a seguir.

=== Requisitos Funcionais (3 de 3 atendidos integralmente)

\

*Compatibilidade com MIDI (RF1)* — Atendido integralmente: a compatibilidade da biblioteca
mido facilitou a implementação da comunicação MIDI, permitindo
atender ao requisito estabelecido.
\

*Transmissão de som via interface de áudio de escolha (RF2)* — Atendido integralmente: a utilização do Raspbian como
sistema operacional facilitou a integração dos recursos de áudio e
Bluetooth, cujos drivers já estavam disponíveis no ambiente.
\

*Som proporcional à intensidade da detecção (RF3)* — Atendido integralmente: os valores de cada pad são
normalizados individualmente, considerando os limites mínimo e
máximo definidos para cada sensor. Dessa forma, a intensidade do
som reproduzido corresponde à intensidade do impacto detectado.

=== Requisitos Não-Funcionais (2 de 4 atendidos integralmente / 2 atendidos parcialmente)

*Baixo custo (RNF1)* — Atendido parcialmente: o custo total estimado para a
etapa de construção da bateria foi de R#sym.dollar 410,00 distribuído da seguinte
forma:

- *Estrutura de PVC* $approx$ R#sym.dollar 120,00.
- *Componentes eletrônicos* $approx$ R#sym.dollar 50,00.
- *ESP32* $approx$ R#sym.dollar 40,00.
- *Cabos e Conectores TS de 1/4 polegada* $approx$  R#sym.dollar 200,00.

Note que o sistema necessita de um computador auxiliar para executar os softwares testados (Hydrogen e Clone Hero), sendo esse um custo implícito.

Um ponto de melhoria possível para o trabalho seria conseguir substituir o computador por
um celular para fazer o retorno da interação, visto que o grau de acessibilidade do
dispositivo é maior.

Outro ponto de melhoria seria substituir as ligações via TS de 1/4 polegada por opções de menor custo, dado que o gasto neles representou cerca de 48% do gasto total.

*Ocupar pouco espaço físico (RNF2)* — Atendido integralmente: a bateria ocupa uma área aproximada
de 2 m² e apresenta altura de cerca de 1,2 m, atendendo ao objetivo
de limitar o espaço físico necessário para sua utilização.

*Baixa latência (RNF3)* — Atendido integralmente: conforme apresentado na Seção
3.3.2, a latência observada permaneceu abaixo do limite de 300 ms
estabelecido para o projeto.

*Modularidade (RNF4)* — Atendido parcialmente: limitações financeiras dificultaram
a implementação de uma estrutura completamente modular. Além disso,
os custos adicionais associados a essa característica poderiam
comprometê o atendimento ao requisito de baixo custo (RNF1).

Diante dos resultados obtidos, conclui-se que o projeto atingiu 100% dos requisitos funcionais e atendeu plenamente à proposta de viabilizar um sistema embarcado de baixo custo com fins educacionais e de prática musical.

= Considerações Finais

O desenvolvimento do Drummies, no âmbito do ProtoPET, demonstrou a viabilidade de uma
bateria eletrônica de baixo custo baseada em sistemas embarcados. Ao utilizar
microcontroladores e componentes de fácil acesso, o projeto
resultou em um protótipo funcional, capaz de atender à prática musical silenciosa e de
permitir a personalização do uso (onde neste artigo utilizamos 2 modos).

Dessa forma, o Drummies se mostra útil como alternativa acessível para estudantes e
músicos iniciantes que enfrentam restrições orçamentárias, de espaço ou de ruído, além de servir como
base para melhorias futuras, como a redução do custo das conexões, uma estrutura mais
modular e a substituição do computador auxiliar por um dispositivo mais acessível, como
um celular.

Por fim, o projeto contribuiu para a formação dos petianos ao consolidar, na prática,
conceitos de Sistemas Embarcados.
A apresentação na Mostra de Profissões da UFRN (2026) evidenciou ainda seu potencial
como ferramenta de divulgação científica, atraindo e engajando os visitantes de maneira
interativa e aproximando os estudantes do Ensino Médio da Ciência da Computação.

#bibliography(
"referencias.bib",
style: "associacao-brasileira-de-normas-tecnicas",
title: "REFERÊNCIAS",
full: true,
)
