// #include <Arduino.h>
// #include "robot.h"

// void setup() {
//   Serial.begin(115200);
//   robot_init();
//   Serial.println("--- timBot iniciado! ---");
// }

// void loop() {
//   navegacao_executar();
// }

#include <Arduino.h>
#include <Wire.h>
#include <ESP32Servo.h>
#include <VL53L0X.h>

Servo meuServo;
VL53L0X sensor;

// ---------------- Servo ----------------
const int pinoServo = 7;

const int ANGULO_DIREITA = 0;
const int ANGULO_CENTRO  = 90;
const int ANGULO_ESQUERDA = 180;

// ---------------- Sensor ----------------
const int DISTANCIA_LIMITE = 50;
const int DISTANCIA_FREIO = 150;

// Pinos I2C seguros e válidos para o ESP32-S3
#define I2C_SDA 4
#define I2C_SCL 5

// ---------------- L298N ----------------
const int pinoENA = 40;
const int pinoENB = 35; // Alterado para 6 para não colidir com o I2C SCL (pino 5)

const int pinoIN1 = 39;
const int pinoIN2 = 38;
const int pinoIN3 = 37;
const int pinoIN4 = 36;

// ---------------- PWM (Configurações API Antiga) ----------------
const int canalENA = 4;
const int canalENB = 5;

const int frequenciaPWM = 1000;
const int resolucaoPWM = 8;

// Velocidades Base
const int VEL_FRENTE = 150; 
const int VEL_GIRO   = 150;
const int VEL_RE     = 100;

// ---------------- Calibração de Trajetória ----------------s
// Multiplicadores aceitam valores de 0.00 (parado) a 1.00 (100% da força).
const float COMPENSACAO_MOTOR_ESQUERDO = 0.94; 
const float COMPENSACAO_MOTOR_DIREITO  = 1.00; 

// ---------------- Calibração de Tempo ----------------
const int TEMPO_GIRO_90    = 200;
const int TEMPO_MEIA_VOLTA = 400;

// =====================================================
// MOTORES
// =====================================================

void definirVelocidadeMotores(int velEsquerda, int velDireita) {
  velEsquerda = constrain(velEsquerda, 0, 255);
  velDireita  = constrain(velDireita, 0, 255);

  ledcWrite(canalENA, velEsquerda);
  ledcWrite(canalENB, velDireita);
}

void definirVelocidade(int velocidade) {
  int velEsq = (int)(velocidade * COMPENSACAO_MOTOR_ESQUERDO);
  int velDir = (int)(velocidade * COMPENSACAO_MOTOR_DIREITO);
  definirVelocidadeMotores(velEsq, velDir);
}

void pararMotores() {
  definirVelocidadeMotores(0, 0);

  digitalWrite(pinoIN1, LOW);
  digitalWrite(pinoIN2, LOW);
  digitalWrite(pinoIN3, LOW);
  digitalWrite(pinoIN4, LOW);
}

void moverFrente() {
  definirVelocidade(VEL_FRENTE);

  digitalWrite(pinoIN1, HIGH);
  digitalWrite(pinoIN2, LOW);

  digitalWrite(pinoIN3, HIGH);
  digitalWrite(pinoIN4, LOW);
}

// CORRIGIDO: Invertido os pinos digitais para girar para a direita corretamente
void girarDireita() {
  definirVelocidade(VEL_GIRO);

  digitalWrite(pinoIN1, LOW);
  digitalWrite(pinoIN2, HIGH);

  digitalWrite(pinoIN3, HIGH);
  digitalWrite(pinoIN4, LOW);

  delay(TEMPO_GIRO_90);

  pararMotores();
}

// CORRIGIDO: Invertido os pinos digitais para girar para a esquerda corretamente
void girarEsquerda() {
  definirVelocidade(VEL_GIRO);

  digitalWrite(pinoIN1, HIGH);
  digitalWrite(pinoIN2, LOW);

  digitalWrite(pinoIN3, LOW);
  digitalWrite(pinoIN4, HIGH);

  delay(TEMPO_GIRO_90);

  pararMotores();
}

void darMeiaVolta() {
  definirVelocidade(VEL_GIRO);

  digitalWrite(pinoIN1, LOW);
  digitalWrite(pinoIN2, HIGH);

  digitalWrite(pinoIN3, HIGH);
  digitalWrite(pinoIN4, LOW);

  delay(TEMPO_MEIA_VOLTA);

  pararMotores();
}

void freiar() {
  definirVelocidade(VEL_RE);

  digitalWrite(pinoIN1, LOW);
  digitalWrite(pinoIN2, HIGH);

  digitalWrite(pinoIN3, LOW);
  digitalWrite(pinoIN4, HIGH);

  delay(250);

  pararMotores();

  // delay(100);
}

// =====================================================
// SENSOR
// =====================================================

uint16_t olharEMedir(int angulo, const char* label) {
  meuServo.write(angulo);
  delay(500);

  uint16_t distancia = sensor.readRangeSingleMillimeters();

  if (sensor.timeoutOccurred()) {
    Serial.printf("[%s] TIMEOUT\n", label);
    return 9999;
  }

  Serial.printf(
    "[%s] %u mm %s\n",
    label,
    distancia,
    distancia > DISTANCIA_LIMITE ? "-> LIVRE" : "-> PAREDE"
  );

  return distancia;
}

// =====================================================
// SETUP
// =====================================================

void setup() {
  Serial.begin(115200);

  unsigned long startMillis = millis();
  while (!Serial && (millis() - startMillis < 3000)) { delay(10); }

  ledcSetup(canalENA, frequenciaPWM, resolucaoPWM);
  ledcAttachPin(pinoENA, canalENA);

  ledcSetup(canalENB, frequenciaPWM, resolucaoPWM);
  ledcAttachPin(pinoENB, canalENB);

  pinMode(pinoIN1, OUTPUT);
  pinMode(pinoIN2, OUTPUT);
  pinMode(pinoIN3, OUTPUT);
  pinMode(pinoIN4, OUTPUT);
  pararMotores();

  ESP32PWM::allocateTimer(3); 
  meuServo.setPeriodHertz(50); 
  
  if (!meuServo.attach(pinoServo, 500, 2400)) {
    Serial.println("Erro crítico: Não foi possível inicializar o Servo no pino 7!");
  }

  Wire.begin(I2C_SDA, I2C_SCL);
  if (!sensor.init()) {
    Serial.println("Falha ao encontrar o VL53L0X! Travado.");
    while (1) { delay(1000); }
  }
  sensor.setTimeout(500);

  Serial.println("\n--- timBot iniciado com sucesso no ESP32-S3! ---");
  meuServo.write(ANGULO_CENTRO);
  delay(1000);
}

// =====================================================
// LOOP (Prioridade de decisão: Direita -> Esquerda)
// =====================================================

void loop() {
  // Variável que lembra se o robô estava andando (não reseta a cada loop)
  static bool estavaAndandoFrente = false; 

  meuServo.write(ANGULO_CENTRO);
  
  // Pequena pausa para o servo centralizar antes de medir
  delay(100); 

  uint16_t distFrente = sensor.readRangeSingleMillimeters();

  if (sensor.timeoutOccurred()) {
    pararMotores();
    estavaAndandoFrente = false;
    delay(200);
    return;
  }

  Serial.printf("[FRENTE] %u mm\n", distFrente);

  // --- SE O CAMINHO ESTIVER LIVRE ---
  if (distFrente > DISTANCIA_FREIO) {
    moverFrente();
    estavaAndandoFrente = true; // Registra que está em movimento
    delay(10);
    return;
  }

  // --- SE ENCONTRAR PAREDE ---
  
  // Só aplica o contra-golpe do freio se realmente estava indo para frente
  if (estavaAndandoFrente) {
    freiar();
    estavaAndandoFrente = false; // Agora está parado
  }

  // 1º Passo: Olha e testa a DIREITA
  uint16_t distDireita = olharEMedir(ANGULO_DIREITA, "DIREITA");
  meuServo.write(ANGULO_CENTRO);
  delay(300);

  if (distDireita > DISTANCIA_LIMITE) {
    Serial.println("=> Virando para DIREITA");
    girarDireita();
    return;
  }

  // 2º Passo: Se a direita estiver bloqueada, olha e testa a ESQUERDA
  uint16_t distEsquerda = olharEMedir(ANGULO_ESQUERDA, "ESQUERDA");
  meuServo.write(ANGULO_CENTRO);
  delay(300);

  if (distEsquerda > DISTANCIA_LIMITE) {
    Serial.println("=> Virando para ESQUERDA");
    girarEsquerda();
  }
  else {
    Serial.println("=> Beco sem saída! Meia-volta");
    darMeiaVolta();
  }
}
