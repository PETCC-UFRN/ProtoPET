# Drums

Este consiste em um projeto que visa fazer uma bateria eletrônica

Instale o `ttymidi` para criar uma porta MIDI virtual, conecte o Arduino e veja 
qual o porta está sendo usada em `/dev`. Depois dê o seguinte comando:

```
ttymidi -s /dev/ttyUSB0 -b 115200
```

O software usado é o `Hydrogen`

![Circuito da bateria](/assets/hello-world.png "Circuito da bateria")

# **1 Requisitos**

## **1.1. Requisitos Funcionais** 

* **Detecção de Impacto:** O sistema deve ser capaz de detectar batidas, de diferentes intensidades, em oito superfícies de forma independente, utilizando sensores piezoeléctricos.  
* **Conversão de Sinal:** O ESP32 deve ler os sinais analógicos gerados pelos sensores e convertê-los em dados digitais.  
* **Transmissão de Dados:** O ESP32 deve enviar os dados das batidas para o computador, via protocolo MIDI over USB.  
* **Mapeamento de Som:** O sistema deve mapear cada uma das superfícies para um som específico.  
* **Saída de Áudio:** O computador deve reproduzir o som correspondente ao receber o sinal.

## **1.2. Requisitos Não Funcionais**

* **Baixa Latência:** O tempo de resposta deve ser curto ( menor que 15 milissegundos).  
* **Sensibilidade:** O sistema deve tratar ruídos (toques leves e vibrações indesejadas).   
* **Isolamento Acústico:** A redução do barulho gerado pelo impacto dos materiais é necessária.

# **2 Hardware**

A tabela a seguir apresenta os custos estimados para os componentes de hardware essenciais do projeto.

| Componente | Quantidade | Custo Unitário Estimado (R$) | Custo Total Estimado (R$) |
| :---- | :---- | :---- | :---- |
| ESP32 devkit | 1 | 40,00 | 40,00 |
| Sensor Piezoelétrico | 8 | 2,00 | 16,00 |
| Resistor 10k | 8 | \- | \- |
| Computador com software | 1 | \- | \- |
| Potes de sorvete | 2 | \- | \- |
| Pote de manteiga (10kg) | 1 | \- | \- |
| Tampas de potes de sorvete | 4 | \- | \- |
| colheres de pau | 2 | \- | \- |