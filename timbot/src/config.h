#pragma once

// --- Pinos do Servo ---
constexpr int PINO_SERVO       = 25;
constexpr int ANGULO_DIREITA   = 180;
constexpr int ANGULO_CENTRO    = 90;
constexpr int ANGULO_ESQUERDA  = 0;

// --- Distâncias ---
constexpr int DISTANCIA_LIMITE = 200; // mm

// --- Pinos da Ponte H L298N ---
constexpr int PINO_IN1 = 26;
constexpr int PINO_IN2 = 27;
constexpr int PINO_IN3 = 14;
constexpr int PINO_IN4 = 12;

// --- Calibração de Movimento (ms) ---
constexpr int TEMPO_GIRO_90    = 300;
constexpr int TEMPO_MEIA_VOLTA = 600;
constexpr int TEMPO_FREIO      = 150;

// --- I2C ---
constexpr int I2C_SDA = 32;
constexpr int I2C_SCL = 33;