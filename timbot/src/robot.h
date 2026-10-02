#pragma once
#include <stdint.h>

void robot_init();

// Motores
void pararMotores();
void moverFrente();
void freiar();
void girarDireita();
void girarEsquerda();
void darMeiaVolta();

// Sensor
uint16_t olharEMedir(int angulo, const char* label);

// Navegação
void navegacao_executar();