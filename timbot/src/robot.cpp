#include "robot.h"
#include "config.h"
#include <Arduino.h>
#include <Wire.h>
#include <ESP32Servo.h>
#include <VL53L0X.h>

static Servo   _servo;
static VL53L0X _sensor;

void pararMotores() {
  digitalWrite(PINO_IN1, LOW);
  digitalWrite(PINO_IN2, LOW);
  digitalWrite(PINO_IN3, LOW);
  digitalWrite(PINO_IN4, LOW);
}

void moverFrente() {
  digitalWrite(PINO_IN1, HIGH); digitalWrite(PINO_IN2, LOW);
  digitalWrite(PINO_IN3, HIGH); digitalWrite(PINO_IN4, LOW);
}

void freiar() {
  digitalWrite(PINO_IN1, LOW);  digitalWrite(PINO_IN2, HIGH);
  digitalWrite(PINO_IN3, LOW);  digitalWrite(PINO_IN4, HIGH);
  delay(TEMPO_FREIO);
  pararMotores();
  delay(100);
}

void girarDireita() {
  digitalWrite(PINO_IN1, HIGH); digitalWrite(PINO_IN2, LOW);
  digitalWrite(PINO_IN3, LOW);  digitalWrite(PINO_IN4, HIGH);
  delay(TEMPO_GIRO_90);
  pararMotores();
}

void girarEsquerda() {
  digitalWrite(PINO_IN1, LOW);  digitalWrite(PINO_IN2, HIGH);
  digitalWrite(PINO_IN3, HIGH); digitalWrite(PINO_IN4, LOW);
  delay(TEMPO_GIRO_90);
  pararMotores();
}

void darMeiaVolta() {
  digitalWrite(PINO_IN1, LOW);  digitalWrite(PINO_IN2, HIGH);
  digitalWrite(PINO_IN3, HIGH); digitalWrite(PINO_IN4, LOW);
  delay(TEMPO_MEIA_VOLTA);
  pararMotores();
}


uint16_t olharEMedir(int angulo, const char* label) {
  _servo.write(angulo);
  delay(500);
  uint16_t dist = _sensor.readRangeSingleMillimeters();
  if (_sensor.timeoutOccurred()) {
    Serial.printf("  [%s] ERRO: Timeout!\n", label);
    return 9999;
  }
  Serial.printf("  [%s] %u mm %s\n", label, dist,
    dist > DISTANCIA_LIMITE ? "-> LIVRE" : "-> PAREDE");
  return dist;
}


void robot_init() {
  pinMode(PINO_IN1, OUTPUT); pinMode(PINO_IN2, OUTPUT);
  pinMode(PINO_IN3, OUTPUT); pinMode(PINO_IN4, OUTPUT);
  pararMotores();

  ESP32PWM::allocateTimer(0); ESP32PWM::allocateTimer(1);
  ESP32PWM::allocateTimer(2); ESP32PWM::allocateTimer(3);
  _servo.setPeriodHertz(50);
  _servo.attach(PINO_SERVO, 500, 2400);

  Wire.begin(I2C_SDA, I2C_SCL);
  _sensor.init();
  _sensor.setTimeout(500);

  _servo.write(ANGULO_CENTRO);
  delay(1000);
}


void navegacao_executar() {
  _servo.write(ANGULO_CENTRO);

  uint16_t distFrente = _sensor.readRangeSingleMillimeters();
  if (_sensor.timeoutOccurred()) { pararMotores(); delay(200); return; }

  Serial.printf("  [FRENTE] %u mm\n", distFrente);

  if (distFrente > DISTANCIA_LIMITE) {
    moverFrente();
    delay(10);
    return;
  }

  freiar();

  uint16_t distDireita = olharEMedir(ANGULO_DIREITA, "DIREITA");
  _servo.write(ANGULO_CENTRO); delay(300);
  if (distDireita > DISTANCIA_LIMITE) {
    Serial.println("=> Virando à direita!\n");
    girarDireita();
    return;
  }

  uint16_t distEsquerda = olharEMedir(ANGULO_ESQUERDA, "ESQUERDA");
  _servo.write(ANGULO_CENTRO); delay(300);
  if (distEsquerda > DISTANCIA_LIMITE) {
    Serial.println("=> Virando à esquerda!\n");
    girarEsquerda();
  } else {
    Serial.println("=> Beco sem saída! Dando meia-volta!\n");
    darMeiaVolta();
  }
}