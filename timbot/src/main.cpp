#include <Arduino.h>
#include <Wire.h>
#include <VL53L0X.h>


// Pinos I2C Seguros 
#define SDA_PIN 15
#define SCL_PIN 16

// Pinos XSHUT 
#define XSHUT_ESQ 9
#define XSHUT_FRENTE 18
#define XSHUT_DIR 17

// Pinos Ponte H MX1508 
const int pinoIN1 = 10; // Motor Esq - Frente
const int pinoIN2 = 11; // Motor Esq - Trás
const int pinoIN3 = 12; // Motor Dir - Frente
const int pinoIN4 = 13; // Motor Dir - Trás

VL53L0X sensorEsq;
VL53L0X sensorFrente;
VL53L0X sensorDir;

const int DISTANCIA_LIMITE = 100; // mm 
const int DISTANCIA_LIMITE_DIR = 200; // mm
const int DISTANCIA_LIMITE_FRENTE = 150; // mm
const int DISTANCIA_FREIO = 300;  // mm
const int DISTANCIA_MINIMA_LATERAL = 80; // mm

const float KP_CENTRALIZAR = 0.5;       
const int LARGURA_MAX_CORREDOR = 250;

const int VEL_FRENTE = 150; 
const int VEL_GIRO   = 200;
const int VEL_RE     = 200;


const float COMPENSACAO_DIR = 1.0; 
const float COMPENSACAO_ESQ = 1.0; 

const int TEMPO_GIRO_90    = 150;
const int TEMPO_MEIA_VOLTA = 400;

enum estado { SEGUINDO_CORREDOR, GIRANDO_ESQUERDA, GIRANDO_DIREITA, DANDO_MEIA_VOLTA };

void pararMotores() {
  analogWrite(pinoIN1, 0);
  analogWrite(pinoIN2, 0);
  analogWrite(pinoIN3, 0);
  analogWrite(pinoIN4, 0);
  delay(200);
}

void moverTras() {
  analogWrite(pinoIN1, 0);
  analogWrite(pinoIN2, VEL_RE * COMPENSACAO_ESQ);
  analogWrite(pinoIN3, 0);
  analogWrite(pinoIN4, VEL_RE * COMPENSACAO_DIR);
}

void moverFrente() {
  analogWrite(pinoIN1, VEL_FRENTE * COMPENSACAO_ESQ);
  analogWrite(pinoIN2, 0);
  analogWrite(pinoIN3, VEL_FRENTE * COMPENSACAO_DIR);
  analogWrite(pinoIN4, 0);
}

void moverFrentePoquinho() {
  analogWrite(pinoIN1, VEL_FRENTE * COMPENSACAO_ESQ);
  analogWrite(pinoIN2, 0);
  analogWrite(pinoIN3, VEL_FRENTE * COMPENSACAO_DIR);
  analogWrite(pinoIN4, 0);
  delay(200);
  pararMotores();
}

void moverTrasDireitaPoquinho() {
  analogWrite(pinoIN1, 0);
  analogWrite(pinoIN2, 0);
  analogWrite(pinoIN3, 0);
  analogWrite(pinoIN4, VEL_RE * COMPENSACAO_DIR);
  delay(200);
  pararMotores();
}

void moverTrasEsquerdaPoquinho() {
  analogWrite(pinoIN1, 0);
  analogWrite(pinoIN2, VEL_RE * COMPENSACAO_ESQ);
  analogWrite(pinoIN3, 0);
  analogWrite(pinoIN4, 0);
  delay(200);
  pararMotores();
}

void girarDireita() {
  // Motor Esquerdo p/ Frente, Direito p/ Trás
  analogWrite(pinoIN1, VEL_GIRO * COMPENSACAO_ESQ);
  analogWrite(pinoIN2, 0);
  analogWrite(pinoIN3, 0);
  //analogWrite(pinoIN4, VEL_GIRO * COMPENSACAO_DIR);
  delay(TEMPO_GIRO_90);
  pararMotores();
}

void girarEsquerda() {
  // Motor Esquerdo p/ Trás, Direito p/ Frente
  analogWrite(pinoIN1, 0);
  //analogWrite(pinoIN2, VEL_GIRO * COMPENSACAO_ESQ);
  analogWrite(pinoIN3, VEL_GIRO * COMPENSACAO_DIR);
  analogWrite(pinoIN4, 0);
  delay(TEMPO_GIRO_90);
  pararMotores();
}

void darMeiaVolta() {
  analogWrite(pinoIN1, 0);
  analogWrite(pinoIN2, VEL_GIRO * COMPENSACAO_ESQ);
  analogWrite(pinoIN3, VEL_GIRO * COMPENSACAO_DIR);
  analogWrite(pinoIN4, 0);
  delay(TEMPO_MEIA_VOLTA);
  pararMotores();
}

void freiar() {
  analogWrite(pinoIN1, 0);
  //analogWrite(pinoIN2, VEL_RE * COMPENSACAO_ESQ);
  analogWrite(pinoIN3, 0);
  //analogWrite(pinoIN4, VEL_RE * COMPENSACAO_DIR);
  //delay(50);
  pararMotores();
}

void setup() {
  Serial.begin(115200);
  delay(2000); // Pausa para o USB estabilizar
  
  Serial.println("\n--- Iniciando Setup do timBot (Versão 3 Sensores) ---");

  // Configura Pinos Motores
  pinMode(pinoIN1, OUTPUT);
  pinMode(pinoIN2, OUTPUT);
  pinMode(pinoIN3, OUTPUT);
  pinMode(pinoIN4, OUTPUT);
  pararMotores();

  // Configura Pinos XSHUT e reseta sensores
  pinMode(XSHUT_ESQ, OUTPUT);
  pinMode(XSHUT_FRENTE, OUTPUT);
  pinMode(XSHUT_DIR, OUTPUT);
  
  digitalWrite(XSHUT_ESQ, LOW);
  digitalWrite(XSHUT_FRENTE, LOW);
  digitalWrite(XSHUT_DIR, LOW);
  delay(50);

  // Inicia I2C
  Wire.begin(SDA_PIN, SCL_PIN);

  // Inicializa Sensor Esquerdo (0x30)
  digitalWrite(XSHUT_ESQ, HIGH);
  delay(50);
  sensorEsq.init();
  sensorEsq.setTimeout(500);
  sensorEsq.setAddress(0x30);

  // Inicializa Sensor Frente (0x31)
  digitalWrite(XSHUT_FRENTE, HIGH);
  delay(50);
  sensorFrente.init();
  sensorFrente.setTimeout(500);
  sensorFrente.setAddress(0x31);

  // Inicializa Sensor Direito (0x29 - Padrão)
  digitalWrite(XSHUT_DIR, HIGH);
  delay(50);
  sensorDir.init();
  sensorDir.setTimeout(500);

  // Inicia leituras contínuas 
  sensorEsq.startContinuous();
  sensorFrente.startContinuous();
  sensorDir.startContinuous();

  Serial.println("--- Setup Concluído. Entrando no labirinto! ---");
  delay(1000);
}


void loop() {
  int distEsq = sensorEsq.readRangeContinuousMillimeters();
  int distFrente = sensorFrente.readRangeContinuousMillimeters();
  int distDir = sensorDir.readRangeContinuousMillimeters();

  Serial.printf("Esq: %d | Frente: %d | Dir: %d\n", distEsq, distFrente, distDir);

  if(distEsq < DISTANCIA_LIMITE && distDir < DISTANCIA_LIMITE && distFrente < DISTANCIA_LIMITE) {
    freiar();
    darMeiaVolta();
    delay(100); 
    return;
  }
  else if(distDir <  DISTANCIA_MINIMA_LATERAL) {
    freiar();
    moverTrasDireitaPoquinho();
    delay(100); 
    return;
  }
  else if(distEsq <  DISTANCIA_MINIMA_LATERAL) {
    freiar();
    moverTrasEsquerdaPoquinho();
    delay(100); 
    return;
  }
  else if(distDir > DISTANCIA_LIMITE_DIR) {
    moverFrentePoquinho();
    freiar();
    girarEsquerda();
    delay(100); 
    return;
  }
  else if (distFrente < DISTANCIA_FREIO) {
    freiar();
    if (distEsq > distDir) {
      moverFrentePoquinho();
      girarDireita();
    } else {
      moverFrentePoquinho();
      girarEsquerda();
    }
    delay(100); 
    return;
  }

  moverFrente();
  delay(100); 
}


