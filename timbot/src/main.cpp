#include <Arduino.h>
#include <Wire.h>
#include <ESP32Servo.h>
#include <VL53L0X.h>

Servo meuServo;
VL53L0X sensor;

// --- Pinos do Servo e Sensor ---
const int pinoServo        = 25;
const int ANGULO_DIREITA   = 180;
const int ANGULO_CENTRO    = 90;
const int ANGULO_ESQUERDA  = 0;

// --- Distâncias ---
const int DISTANCIA_LIMITE = 200;

// --- Pinos da Ponte H L298N ---
const int pinoIN1 = 26;
const int pinoIN2 = 27;
const int pinoIN3 = 14;
const int pinoIN4 = 12;

// --- Calibração de Movimento (ms) ---
const int TEMPO_GIRO_90    = 300;
const int TEMPO_MEIA_VOLTA = 600; // dobro do giro de 90°

// --- Motores ---

void moverFrente() {
  digitalWrite(pinoIN1, HIGH);
  digitalWrite(pinoIN2, LOW);
  digitalWrite(pinoIN3, HIGH);
  digitalWrite(pinoIN4, LOW);
}

void pararMotores() {
  digitalWrite(pinoIN1, LOW);
  digitalWrite(pinoIN2, LOW);
  digitalWrite(pinoIN3, LOW);
  digitalWrite(pinoIN4, LOW);
}

void girarDireita() {
  digitalWrite(pinoIN1, HIGH);
  digitalWrite(pinoIN2, LOW);
  digitalWrite(pinoIN3, LOW);
  digitalWrite(pinoIN4, HIGH);
  delay(TEMPO_GIRO_90);
  pararMotores();
}

void girarEsquerda() {
  digitalWrite(pinoIN1, LOW);
  digitalWrite(pinoIN2, HIGH);
  digitalWrite(pinoIN3, HIGH);
  digitalWrite(pinoIN4, LOW);
  delay(TEMPO_GIRO_90);
  pararMotores();
}

void darMeiaVolta() {
  digitalWrite(pinoIN1, LOW);
  digitalWrite(pinoIN2, HIGH);
  digitalWrite(pinoIN3, HIGH);
  digitalWrite(pinoIN4, LOW);
  delay(TEMPO_MEIA_VOLTA);
  pararMotores();
}

void freiar() {
  // Ré por um tempo curto para cancelar a inércia
  digitalWrite(pinoIN1, LOW);
  digitalWrite(pinoIN2, HIGH);
  digitalWrite(pinoIN3, LOW);
  digitalWrite(pinoIN4, HIGH);
  delay(150); // ajusta esse valor se precisar
  pararMotores();
  delay(100);
}

// --- Sensor ---

uint16_t olharEMedir(int angulo, const char* label) {
  meuServo.write(angulo);
  delay(500);

  uint16_t distancia = sensor.readRangeSingleMillimeters();

  if (sensor.timeoutOccurred()) {
    Serial.printf("  [%s] ERRO: Timeout!\n", label);
    return 9999;
  }

  Serial.printf("  [%s] %u mm %s\n",
    label,
    distancia,
    distancia > DISTANCIA_LIMITE ? "→ LIVRE" : "→ PAREDE"
  );
  return distancia;
}

// -----------------------------------------------------------

void setup() {
  Serial.begin(115200);

  pinMode(pinoIN1, OUTPUT);
  pinMode(pinoIN2, OUTPUT);
  pinMode(pinoIN3, OUTPUT);
  pinMode(pinoIN4, OUTPUT);
  pararMotores();

  ESP32PWM::allocateTimer(0);
  ESP32PWM::allocateTimer(1);
  ESP32PWM::allocateTimer(2);
  ESP32PWM::allocateTimer(3);
  meuServo.setPeriodHertz(50);
  meuServo.attach(pinoServo, 500, 2400);

  Wire.begin(32, 33);
  sensor.init();
  sensor.setTimeout(500);

  Serial.println("--- timBot iniciado! ---");
  meuServo.write(ANGULO_CENTRO);
  delay(1000);
}

void loop() {
  meuServo.write(ANGULO_CENTRO);
  //delay(300);

  uint16_t distFrente = sensor.readRangeSingleMillimeters();

  if (sensor.timeoutOccurred()) {
    pararMotores();
    delay(200);
    return;
  }

  Serial.printf("  [FRENTE] %u mm\n", distFrente);

  if (distFrente > DISTANCIA_LIMITE) {
    moverFrente();
    delay(10);
    return;
  }

  // --- FRENTE BLOQUEADA ---
  freiar();

  uint16_t distDireita = olharEMedir(ANGULO_DIREITA, "DIREITA");
  meuServo.write(ANGULO_CENTRO);
  delay(300);

  if (distDireita > DISTANCIA_LIMITE) {
    Serial.println("=> Virando à direita!\n");
    girarDireita();
    return;
  }

  uint16_t distEsquerda = olharEMedir(ANGULO_ESQUERDA, "ESQUERDA");
  meuServo.write(ANGULO_CENTRO);
  delay(300);

  if (distEsquerda > DISTANCIA_LIMITE) {
    Serial.println("=> Virando à esquerda!\n");
    girarEsquerda();
  } else {
    Serial.println("=> Beco sem saída! Dando meia-volta!\n");
    darMeiaVolta();
  }
}