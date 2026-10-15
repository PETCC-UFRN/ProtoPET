# **Projeto timBot**

**Foco**: Navegação em Labirinto

O timBot é um robô autônomo projetado para resolver labirintos utilizando algoritmos de exploração clássicos. O projeto atua como uma aplicação prática e interativa de Sistemas Embarcados.

## **Requisitos**

### **Requisitos Funcionais**
* **Navegação Autônoma:** O robô deve ser capaz de se mover pelo labirinto sem intervenção humana, utilizando um algoritmo de exploração.
* **Detecção de Obstáculos:** O sistema deve ler continuamente o ambiente frontal e lateral (esquerda/direita) para identificar paredes e evitar colisões.
* **Controle de Rotação:** O robô deve ser capaz de realizar giros precisos e correções de trajetória para se manter alinhado aos corredores.

### **Requisitos Não Funcionais**
* **Dimensões Físicas:** O chassi e a disposição dos componentes devem ser compactos o suficiente para permitir a rotação do robô dentro do próprio eixo nos corredores do labirinto.
* **Energia:** A alimentação do TimBot deve prover autonomia suficiente para que o robô opere de forma contínua durante um grande período de tempo na exposição.

## **Hardware**

A arquitetura final do projeto substituiu os componentes de testes iniciais por módulos mais precisos para detecção e navegação em tempo real.

* **Microcontrolador:** ESP32-S3, escolhido por sua alta capacidade de processamento, periféricos integrados (I2C/PWM) e baixo consumo de potência.
* **Sensores de Distância:** 3 sensores a laser VL53L0X (Time-of-Flight) que realizam medições rápidas e absolutas de até 2 metros.
* **Posicionamento dos Sensores:** Os sensores foram acoplados na parte frontal com uma diferença de angulação de 45 graus para permitir a leitura simultânea das distâncias frontais e laterais.
* **Locomoção e Chassi:** 2 motores DC (operando entre 3V a 6V) montados em um chassi de duas rodas. O modelo 3D do chassi foi desenvolvido pela equipe e disponibilizado abertamente no repositório.
* **Driver de Motor:** Circuito integrado L298N (Ponte H dupla) para prover o controle de acionamento e velocidade bidirecional dos motores.
* **Alimentação:** 2 baterias de lítio 18650 (com tensão nominal de 3,7V cada) conectadas em série.
* **Regulação de Tensão:** Módulo Step Down regulador de tensão para garantir autonomia e proteção contra quedas de tensão que poderiam causar reinicializações indesejadas no microcontrolador.

## **Software**

* O programa de navegação lida com a percepção espacial realizando as leituras exclusivamente pelos 3 sensores frontais.
* O algoritmo principal efetua uma busca em profundidade pelo labirinto com preferência de manobra para as curvas à direita.
* O robô utiliza algoritmos de ajuste de direção que operam com base na leitura constante dos sensores a laser para realizar pequenas correções de trajetória.
* Os ajustes de direção detectam anomalias na rota através da distância lida nas paredes laterais, evitando aproximações exageradas e colisões.
  
## Modelo 3D 

Os modelos 3D do chassi estão em
[`3Dmodels/`](https://github.com/PETCC-UFRN/ProtoPET/tree/main/3Dmodels).
