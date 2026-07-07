#import "@preview/abntyp:0.1.2": *
#import "@preview/lilaq:0.6.0" as lq

// Configuração do documento usando o template article
#show: artigo.with(
  titulo: "Drummies: Desenvolvimento de uma bateria eletrônica embarcada de baixo custo",
  autores: (
    (
      name: "Gabriel Carvalho Pereira Silva",
      affiliation: "Bacharelando em Tecnologia da Informação, 20230035087",
    ),
  ),
  resumo: [
    O presente trabalho propõe um modelo de desenvolvimento de uma bateria 
    eletrônica de baixo custo baseada em sistemas embarcados, voltada à 
    prática musical com capacidade de reduzir da propagação sonora ao ambiente 
    externo. O sistema utiliza sensores piezoelétricos para detecção das batidas 
    realizadas pelo usuário, um microcontrolador *ESP32* responsável pela aquisição 
    e processamento dos sinais analógicos, e um *RaspberryPi* para recepção dos 
    dados via comunicação serial *UART* e conversão para eventos *MIDI*. Os sinais 
    gerados são utilizados para controle de instrumentos virtuais no software 
    Hydrogen, permitindo a reprodução sonora em tempo real por meio de fones de 
    ouvido ou sistemas de áudio externos. O projeto busca demonstrar a viabilidade 
    da construção de instrumentos musicais eletrônicos de baixo custo utilizando 
    tecnologias embarcadas acessíveis, além de explorar conceitos relacionados 
    à aquisição de sinais, comunicação serial e integração *MIDI*. 
    #link("https://github.com/PETCC-UFRN/ProtoPET/tree/main/drums")[Repositório do Projeto].
  ],
)

// ============================================================================
// ELEMENTOS TEXTUAIS
// ============================================================================

= Introdução

A prática de instrumentos musicais está intrinsecamente associada à produção sonora, 
a qual, em determinados contextos, pode representar um fator limitante para a execução 
e o estudo musical. Instrumentos de natureza predominantemente acústica possuem 
propagação sonora inerente à sua construção, dificultando o controle do volume emitido 
durante sua utilização.

Em ambientes compartilhados ou com elevada proximidade entre habitações, como 
apartamentos e condomínios, essa característica pode comprometer a prática 
musical contínua, uma vez que o som produzido pode causar incômodo a terceiros. 
Nesse contexto, torna-se relevante o desenvolvimento de alternativas que permitam a 
execução musical com menor impacto acústico ao ambiente externo.

As baterias eletrônicas destacam-se como uma solução amplamente empregada para esse 
problema, possibilitando ao usuário praticar o instrumento utilizando fones de ouvido e 
reduzindo significativamente a propagação sonora no ambiente. Entretanto, equipamentos 
comerciais dessa categoria frequentemente apresentam custos elevados, dificultando sua 
aquisição por estudantes e músicos iniciantes.

Dessa forma, o presente trabalho propõe o desenvolvimento de um protótipo de bateria 
eletrônica de baixo custo baseado em sistemas embarcados, utilizando sensores 
piezoelétricos, microcontroladores e comunicação digital para captura e processamento 
dos sinais gerados durante a execução do instrumento.

= Objetivos

Conforme já citado, o projeto em questão se trata do desenvolvimento de um protótipo 
funcional de uma bateria eletrônica. Entretanto, o caminho até o objetivo final é traçado 
por outras metas que balizam o processo de desenvolvimento, sendo estas os requisitos. 
Os requisitos funcionais dizem respeito a condições impostas na implementação do projeto 
afetam diretamente a forma em que o sistema funcionará, já os não-funcionais são relativos 
a como certas partes operam ou são implementadas.

== Requisitos funcionais

Dentre as principais imposições para que o protótipo produzido esteja de acordo com a 
proposta, foram selecionadas como principais as presentes abaixo.

=== Compatibilidade com MIDI - RF1
MIDI(_Musical Instrument Digital Interface_) se trata de uma interface amplamente 
utilizada no contexto musical, esta busca padronizar a forma com que dados gerados 
pelos instrumentos se traduzem em diferentes manifestações sonoras. Através dela 
é possível contemplar uma enormidade de instrumentos, pois esta carrega informações 
de notação, _pitch_, velocidade, vibrato, _panning_ e diversas outras referentes ao 
som.

Sendo assim, isando maximizar a compatibilidade com os _softwares_ de produção 
musical que são mais tradicionais no mercado, foi imposto que a entrada do sistema 
deve seguir o padrão . Dessa forma, o funcionamento do projeto não fica restrito ao 
_software_ que posteriormente será proposto.

=== Transmissão de som via interface de áudio de escolha - RF2

Diferentemente dos instrumentos acústicos, um diferencial dos instrumentos de natureza 
digital é a possibilidade de propagação do som de maneira mais seletiva. Sendo assim, 
uma das restrições impostas para o produto final é ser compatível com interfaces 
capazes de transmitir áudio, tais como P2, P3 e _Bluetooth_.

=== Produzir som proporcional à intensidade da detecção - RF3

Este se trata do requisito de maior importância para a coerência do projeto com sua 
proposta. Caso fossem usados sensores de saída digital a relação de impacto e som seria 
de binária, de forma que a intensidade da batida no _pad_ da bateria não afeta a magnitude 
do som na saída, entretanto, a proposta do uso de sensores Piezoelétricos é justamente o 
contrário.

A fim de implementar um protótipo digital de um instrumento acústico, desconsiderar a 
intensidade da interação afeteria diretamente a experiência do usuário. Dessa forma, 
é considerada vital para o projeto a relação de intensidade entre a interação do 
usuário e o som reproduzido correspondente.

== Requisitos não-funcionais

Abaixo seguem as particularidades do projeto que foram consideradas no âmbito da 
implementação, mas que afetam de maneira tangente os requisitos anteriormente citados.

=== Baixo custo - RNF1

Visto que se trata da reimplementação de projetos já existentes no mercado, se faz 
interessante que haja algum diferencial. E sabendo que, dadas as limitações financeiras, 
a implementação, em termos de complexidade e funcionalidades, torna-se pouco competitiva 
em relação às soluções já consolidadas, é possível abraçar essa limitação e transformá-la 
em um requisito.

Sendo assim, o baixo custo passa a ser um dos principais objetivos da solução, buscando 
desenvolver uma bateria eletrônica funcional utilizando componentes de fácil aquisição 
e baixo valor comercial. Dessa forma, o projeto torna-se uma alternativa acessível para 
estudantes, entusiastas e instituições de ensino que desejam explorar conceitos de 
eletrônica, sistemas embarcados e instrumentos musicais sem a necessidade de investir em 
equipamentos comerciais de alto custo.

=== Ocupar pouco espaço físico - RNF2

Além do baixo custo, outro requisito importante do projeto é a redução do espaço 
físico ocupado pelo instrumento. Baterias acústicas e até mesmo algumas baterias 
eletrônicas comerciais demandam uma área considerável para instalação e armazenamento, 
o que pode inviabilizar seu uso em ambientes menores.

Nesse contexto, a proposta prioriza um formato compacto, permitindo que o equipamento 
seja facilmente armazenado e utilizado sem a necessidade de um ambiente dedicado. para 
ele. Essa característica é especialmente relevante para moradores de apartamentos 
e residências com espaço limitado, onde frequentemente não há um cômodo disponível para 
acomodar uma bateria convencional de forma permanente.

Ao ocupar pouco espaço, o instrumento pode se fazer presente sem afetar significativamente 
o uso daquele espaço, reduzindo o impacto na organização do ambiente. Além disso, por se 
tratar de uma bateria eletrônica, a possibilidade de utilização com fones de ouvido 
diminui significativamente a emissão de ruídos para o ambiente externo, tornando a prática 
musical mais compatível com locais sujeitos a restrições de espaço e convivência com vizinhos.

=== Baixa latência - RNF3

Para que a experiência seja equiparável ao uso de uma bateria acústica, faz- se essencial 
uma experiência sonora semelhante. E sabendo que no contexto acústico a propagação de ondas 
sonoras dependem quase que exclusivamente do meio em que estas acontecem, o _delay_ se 
faz crítico para que o uso do produto seja agradável.

Sendo assim, infelizmente no contexto digital não é possível superar o acústico visto que 
o processamento do sinal gerado consome tempo, e só após esse processo é possível emitir o 
som. Portanto, se faz essencial minimizar ao máximo o tempo de processamento que ocorre 
desde a entrada do sinal até a saída deste.

Tendo isso em mente, foram estipulados 300 milissegundos como teto para o tempo de 
processamento do sinal. E a escolha desse valor foi embasada no processo fisiológico 
auditivo humano, uma vez que esse se trata do maior intervalo no qual o cérebro pode 
associar uma interação física a um retorno sonoro sem causar estranheza pela falta de 
sincronização.

=== Modularidade - RNF4

Um requisito que inconscientemente foi considerado ao longo do projeto, mas que não 
estava previsto no levantamento inicial, é a modularidade do produto. De forma 
complementar ao *RNF2*, a organização do ambiente também é beneficiada caso o produto 
seja desmontável. 

Sabendo disso, o produto final também se propõe a ser modularizado, tendo cabos 
conectados de maneira não definitiva aos componentes, proporcionado um processo 
de desmontagem mais conveniente.

= Fundamentação Teórica

Para o desenvolvimento do protótipo foram usados três componentes principais: 
Sensores Piezoelétricos, uma placa de desenvolvimento _ESP32_ e um _RaspberryPI_.

== Sensor piezzoelétrico

O efeito Piezoelétrico é um fenômeno de polarização presente em alguns cristais 
e certas cerâmicas(GUO; HAN; ZHOU, 2020). Através dele, o sensor piezoelétrico 
combina latão e Zirconato-Titanato de Chumbo(PZT) para que impacto mecânico seja 
convertido em um pulso elétrico proporcional à força aplicada. E tal comportamento 
pode ser aproveitado como entrada da bateria a fim de gerar um sinal que 
posteriormente virará um som de intensidade correspondente.

== Placa de desenvolvimento ESP32

A placa faz parte de uma família de dispositivos que usam o microcontrolador 
_ESP32_ projetado pela _Espressif Systems_. Dentre os motivos que fazem com que ela 
seja atrativa para o público pode-se citar: Seu baixo consumo de potência, sua 
gama de funções disponíveis em uma única porta, além ter suporte a _Bluetooth_ e 
_Wifi_.

#figure(
  image("images/esp32_devkitC_v4_pinlayout.png", width: 100%),
  caption: [_Datasheet_ da Placa de Desenvolvimento ESP32],
)
#fonte[Expressif Systems.]


== Raspberry Pi

Este faz parte da categoria dos _Single Board Computers_(SBC), dispositivos, 
geralmente, portáteis que tem se popularizado na última década por conta de 
sua conveniência para determinadas tarefas do dia-a-dia. Já no contexto dos 
Sistemas Embarcados, sua popularidade advêm de seu poder computacional atrelado 
ao seu baixo consumo energético, muito por consequência do seu processador de 
arquitetura RISC(_Reduced Instruction Set Computer_) que segue, mais especificamente, 
o modelo ARM(_Advanced RISC Machine_).

#figure(
  image("images/rpi.jpg", width: 100%),
  caption: [Especificação do Raspberry PI 4],
)
#fonte[Hackatronic]

= Metodologia

A seguir contemplamos uma descrição detalhada da forma na qual os componentes 
anteriormente citados foram usados no projeto.

== Especificação

O funcionamento da bateria eletrônica pode ser dividido em três módulos principais: 
aquisição dos sinais, processamento e geração do som. A arquitetura proposta busca 
separar essas responsabilidades entre os dispositivos utilizados, reduzindo a 
complexidade de cada componente e tornando o sistema mais modular.

Inicialmente, cada _pad_ da bateria é equipado com um sensor piezoelétrico responsável 
por converter o impacto mecânico em um pulso elétrico cuja amplitude é proporcional à 
intensidade da batida. Esses sinais são encaminhados para um microcontrolador ESP32, 
que realiza a leitura das entradas analógicas, aplica os filtros necessários para 
eliminar ruídos e múltiplas detecções provenientes de uma única vibração, além de 
normalizar os valores para a faixa utilizada pelo padrão MIDI.

Após o processamento, os dados são enviados por comunicação serial para um _RaspberryPi_, 
responsável por interpretar as informações recebidas e convertê-las em mensagens _MIDI_. 
Essas mensagens são encaminhadas ao software Hydrogen, onde cada pad é associado a um 
instrumento virtual correspondente. Por fim, o áudio gerado pode ser reproduzido através 
da interface de saída disponível no sistema operacional, como fones de ouvido, caixas 
de som ou dispositivos Bluetooth. Tal processo pode ser resumido conforme o diagrama abaixo:

#figure(
  image("images/diagrama.png", width: 80%),
  caption: [Diagrama de componentes],
)
#fonte[Gerada por IA (2026).]


=== Piezzo-ESP32

Essa parte do circuito atua recebendo entrada e tratando os dados que posteriormente 
serão enviados para o _RaspberryPI_. A entrada consiste nos sinais captados pelo Piezzo, 
sendo estes provenientes da vibração dos impactos recebidos pelo sensor. E visto que 
estes se tratam de sinais analógicos, valores entre 0V e 5V, em que o valor gerado 
é proporcional à intensidade da batida, eles só fazem sentido caso esses dados sejam 
passados para o _ESP32_ de maneira numérica. Sendo assim, o terminal positivo do sensor 
fica conectado com uma porta *ADC*(Analogic-Digital Converter) e o negativo ao *GND*. 
Ademais, juntamente ao Piezzo há um circuito de proteção simples, composto por um 
resistor de 100k\u{03A9} e um Diodo Zener 5V1, que se faz necessário visto que as 
tensões geradas podem chegar a 39V(Rohini et al., 2024).

Uma vez recebendo os sinais, o _ESP32_ também é responsável pelo processo de filtro e 
normalização do sinal. A filtragem se faz necessária uma vez que a vibração criada por 
uma batida no _pad_ gera um sinal semelhante ao seguinte:

#let t = lq.linspace(0, 12)

// Sinal original
#let vibration(x) = {
  let xs = x * 100 / 12

  if xs < 5 {
    0
  } else {
    5 * calc.exp(-(xs - 5) / 20) * calc.sin(1.1 * (xs - 5))
  }
}

// Mesmo sinal, mas com pico de 12 V
#let vibration12(x) = {
  vibration(x) * (12 / 5)
}

// Retificação de meia onda (remove valores negativos)
#let vibration_positive(x) = {
  let y = vibration(x)
  if y < 0 { 0 } else { y }
}

#lq.diagram(
  width: 12cm,
  height: 7cm,

  xlim: (0, 12),
  ylim: (-7, 14),

  xlabel: [Tempo (ms)],
  ylabel: [Tensão (V)],

  lq.plot(
    t,
    vibration12,
    smooth: true,
    mark: none,
    label: [Sem o circuito de proteção]
  ),

  lq.plot(
    t,
    vibration,
    smooth: true,
    mark: none,
    label: [Com o resistor]
  ),

  lq.plot(
    t,
    vibration_positive,
    smooth: true,
    mark: none,
    label: [Com o resistor e diodo]
  ),
)

Uma alternativa ao _ESP32_ seria usar um Módulo Conversor Analógico-Digital, visto 
que nesse caso pode-se dizer que as funções do _ESP32_ estão sendo sub-utilizadas. 
Mas, conforme definido no *RNF1* o baixo custo geralmente está associado ao uso 
de componentes de fácil acesso. E uma vez o sinal lido, tem inicio o processamento 
do sinal, descrito na sessão posterior.

=== ESP32-RasberryPi

Conforme mostrado anteriormente, o sinal recebido tem uma natureza não linear, e 
isso afeta diretamente a forma na qual o processamento ocorre. A leitura de cada _pad_
ocorre durante um intervalo de 12ms, durante esse tempo a porta lê todos os valores 
recebidos. Note que esse intervalo se mantem dentro do *RNF3*, pois supondo todos 
os _pads_ possíveis em uma bateria(até 8) temos que $8 * 12 < 300$.

Entretanto, o sinal apenas é considerado caso esse esteja no intervalo de 
valores teto e piso definidos para aquele _pad_, o valor mínimo é necessario para não 
atrasar o processamento considerando ruídos no cálculo, e o valor máximo é necessário 
para proteger o sistema de possíveis falhas. Dentre todos os valores lidos que estão 
nesse intervalo, apenas o maior é considerado, sendo este a intensidade da batida.

Os processos anteriores se traduzem em código da seguinte forma:

```cpp
const int scanTime = 8;    // Intervalo de leitura em ms

struct DrumPad {
    int pin;               // Pino ADC do ESP32
    int min;               // Valor piso do pad
    int max;               // Valor teto do pad
    unsigned long lastHit; // O instante da batida salva
};
```

Uma vez lido o valor, agora é necessário normaliza-lo antes de fazer o envio para o 
_RaspberryPI_. E para isso o `min` e o `max` se fazem mais importantes ainda, pois 
estes serão os valores considerados para transformar o valor lido em um número de 
0(`min`) a 127(`max`, teto da interface *MIDI*).

Uma vez conhecido o valor, sabe-se que este está associado ao _pad n_, pois a 
bateria consiste em uma lista de _pads_, e começa o processo de envio para o 
_RaspberryPI_. É utilizado o protocolo *UART*(_Universal Asynchronous Receiver/Transmitter_) 
para enviar os dados, sendo assim, fisicamente se faz necessário que a porta *TX* do _ESP32_ 
esteja conecta conectada à *RX* do _RaspberryPI_, além de partilharem o mesmo terra.

A formatação dos dados é feita através de pacotes binários a fim de diminuir o tempo 
de transmissão que formatar em *ASCII*(_American Standard Code for Information Interchange_)
causaria. A especificação era a seguinte:

```cpp
struct __attribute__((packed)) Packet {
    uint8_t header;     // Início do pacote
    uint8_t pad;        // Índice do pad
    uint8_t value;      // Valor da batida(entre 0 e 127)
    uint32_t timestamp; // Horário da batida
};
```

Tais implementações foram feitas usado o *PlatformIO* como ferramenta de _build_
do projeto estão disponíveis no repositório disponibilizado.

=== RaspberryPI - Hydrogen

Foi instalado o *Raspbian* com interface gráfica como sistema operacionado do 
dispositivo se faz necessário para o uso do _software_ de áudio. Além disso, as 
informações eviadas pelo _ESP32_ eram recebidas através de um script _Python_ que 
utilizava a biblioteca _mido_ para associar o valor recebido a uma nota musical. 
E uma vez esse script rodando com o _Hydrogen_ aberto, os sons eram reproduzidos 
conforme intensidade e nota mapeada.

= Resultados e Discussão

Ao fim da implementação o produto obtido não foi obtido de maneira plena visto que 
faltaram certas partes serem replicadas, mas a prova de conceito de todos os pads foi 
feita. E isso resultou em uma bateria com 2 tambores, 1 prato e 1 pedal, conforme 
mostrado abaixo.

#figure(
  image("images/tambor1.jpeg", width: 80%),
  caption: [Tom da bateria],
)
#fonte[Elaborado pelo autor (2026).]

#figure(
  image("images/prato.jpeg", width: 80%),
  caption: [Prato da bateria],
)
#fonte[Elaborado pelo autor (2026).]

#figure(
  image("images/tambor2.jpeg", width: 80%),
  caption: [Caixa da bateria],
)
#fonte[Elaborado pelo autor (2026).]

#figure(
  image("images/pedal.png", width: 80%),
  caption: [Pedal da bateria],
)
#fonte[Elaborado pelo autor (2026).]

#figure(
  image("images/bateria.jpeg", width: 80%),
  caption: [Bateria inteira],
)
#fonte[Elaborado pelo autor (2026).]

Ao fim da implementação foi possível ver que a maioria dos requisitos foram atendidos 
de forma plena e alguns foram atendidos de forma parcial, detalhando:

- RF1
  - Foi atendido de maneira plena, visto que a compatibilidade da biblioteca 
  _mido_ facilitou o processo.
- RF2
  - Foi atendido de maneira plena, visto que o uso do _Raspbian_ como sistema 
  operacional já fez com que drivers de áudio e _Bluetooth_ fossem automaticamente 
  incluídos no projeto, bem como seu uso.
- RF3
  - Foi atendido de maneira plena, visto que cada _pad_ individual tem seus valores 
  normalizados conforme o piso e teto definido, o que gera batidas proporcionais à
  intensidade.
- RNF1
  - Foi atendido de maneira parcial, pois o custo total estimado para a produção 
  da bateria foi:
    - R\$ 120,00 estrutura de PVC
    - R\$ 50,00 componentes eletrônicos
    - R\$ 40,00 _ESP32_
    - R\$ 1.100,00 _RaspberryPI_
  - É possível perceber a discrepência de valor do último item, sendo esse um 
  ponto de melhoria do projeto.
- RNF2
  - Foi atendido de maneira plena, visto que a bateria ocupa uma área em torno de 
  2$m^2$ e sua altura é em torno de 1,2m.
- RNF3
  - Foi atendido de maneira plena, pois conforme citado na sessão *4.1.2*, está 
  abaixo de 300ms.
- RNF4
  - Foi atendido de maneira parcial, pois houveram limitações financeiras que 
  dificutaram a implementação. Além do encarecimento ir de encontro a *RNF1*.

Sendo assim, é possível ver que o projeto foi executado de maneira satisfatória 
e cumpriu seu propósito para o aprendizado dos conceitos da disciplina.

// ============================================================================
// REFERÊNCIAS
// ============================================================================

// OPÇÃO 1: Bibliografia automática
// Se você usou o parâmetro bibliography-file no template, as referências
// são inseridas automaticamente. Também pode usar diretamente:
// #abnt-bibliography("examples/referencias.bib")

// OPÇÃO 2: Referências manuais (demonstração abaixo)

#heading(level: 1, numbering: none, "REFERÊNCIAS")

#set par(hanging-indent: 1.25cm, first-line-indent: 0pt)

GUO, Liangchao; HAN, Su-Ting; ZHOU, Ye. *Electromechanical coupling effects for data storage and synaptic devices. Nano Energy*, v. 77, p. 105156, 2020. Disponível em: https://www.sciencedirect.com/science/article/pii/S2211285520307345. Acesso em: 25 maio 2026.

ROHINI, S.; VIKINDRA REDDY, P.; TEJASREE, N.; SUDHEER, G.; RAKESH, S. Piezo-Step Power Generator. International Journal of Innovative Research in Science, Engineering and Technology, v. 13, n. 3, p. 2562–2568, mar. 2024. DOI: 10.15680/IJIRSET.2024.1303187. Disponível em: https://www.ijirset.com/upload/2024/march/187_Piezo.pdf. Acesso em: 22 jun. 2026.
