# **Projeto timBot**

**Status**: Protótipo em desenvolvimento 
**Foco**: Navegação em Labirinto

O timBot é um robô autônomo projetado para resolver labirintos utilizando algoritmos de exploração clássicos. Ele utiliza a plataforma ESP32 para processamento e sensores de distância para mapeamento em tempo real.

Baseado em: [teamjerry.hu](http://teamjerry.hu)

# **1 Requisitos**

## **1.1. Requisitos Funcionais** 

* **Navegação Autônoma:** O robô deve ser capaz de se mover pelo labirinto sem intervenção humana, utilizando um algoritmo de exploração (como a "Regra da Mão Direita”).  
* **Detecção de Obstáculos:** O sistema deve ler continuamente o ambiente frontal e lateral (esquerda/direita) para identificar paredes e evitar colisões.  
* **Controle de Rotação:** O robô deve ser capaz de realizar giros precisos (ex: 90 graus) e correções de trajetória para se manter alinhado aos corredores.

## **1.2. Requisitos Não Funcionais**

* **Dimensões Físicas:** O chassi e a disposição dos componentes devem ser compactos o suficiente para permitir a rotação do robô dentro do próprio eixo nos corredores do labirinto.

# **2 Hardware**

A tabela a seguir apresenta os custos estimados para os componentes de hardware essenciais do projeto.

| Componente | Quantidade | Custo Unitário Estimado (R$) | Custo Total Estimado (R$) |
| :---- | :---- | :---- | :---- |
| ESP32 devkit | 1 | 40,00 | 40,00 |
| Kit Chassi Robô 2WD (duas rodas) | 1 | 60,00 | 60,00 |
| Ponte H (Driver de Motor) | 1 | 20,00 | 20,00 |
| Bateria de lítio 18650 | 2 | 10,00 | 20,00 |
| Ultrassônicos HC-SR04 OU  Sensor De Distância Laser Vl53l0x | 3 | 20,00 | 60,00 |
| Acelerômetro E Giroscópio | 1 | 20 | 20 |
