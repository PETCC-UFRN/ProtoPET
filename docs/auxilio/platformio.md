# PlatformIO

PlatformIO é uma alternativa profissional ao Arduino IDE. Roda dentro do **VS Code**, oferece gerenciamento de bibliotecas, suporte a múltiplas placas e um terminal integrado.

## Instalação

1. Abra o VS code.
2. Abra a aba de extensões (`Ctrl+Shift+X`)
3. Busque por **PlatformIO IDE** e instale
4. Reinicie o VS Code — o ícone da formiga aparecerá na barra lateral

## Inicializar um Projeto

1. Clique no ícone do PlatformIO na barra lateral
2. Vá em **PIO Home → New Project**
3. Preencha:
   - **Name:** nome do seu projeto
   - **Board:**`Espressif ESP32 Dev Module`
   - **Framework:** `Arduino`
4. Clique em **Finish** e aguarde o PlatformIO baixar as dependências

## Estrutura do Projeto

```
meu-projeto/
├── src/
│   └── main.cpp        ← seu código principal fica aqui
├── include/            ← headers (.h) do projeto
├── lib/                ← bibliotecas locais
├── test/               ← testes unitários
└── platformio.ini      ← configurações da placa e bibliotecas
```

## Arquivo `platformio.ini`

Possui as configurações básicas

```ini
[env:esp32dev]
platform  = espressif32
board     = esp32dev
framework = arduino
monitor_speed = 115200
```

## Adicionar Bibliotecas

No `platformio.ini`, use a chave `lib_deps`:

```ini
[env:esp32dev]
platform  = espressif32
board     = esp32dev
framework = arduino
monitor_speed = 115200

lib_deps =
    adafruit/DHT sensor library @ ^1.4.6
    miguelbalboa/MFRC522 @ ^1.4.10
    olikraus/U8g2 @ ^2.35.7
```

Salve o arquivo e o PlatformIO irá baixar tudo automaticamente.

## Comandos Principais (barra inferior do VS Code)

| Botão     | Ação |
|-----------|------|
| Build   | Compila o projeto |
| Upload  | Compila e envia para o ESP32 |
| Monitor | Abre o monitor serial |
| Clean  | Limpa os arquivos compilados |