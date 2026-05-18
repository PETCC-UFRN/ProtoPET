# Setup

Atualize e baixe os pacotes de sistema
```bash
sudo apt update
sudo apt install hydrogen libasound2-dev pkg-config cmake python3-rtmidi
```

Habilite a comunicação e reinicie
```bash
sudo raspi-config # Interface Options -> Serial Port
# Would you like a login shell to be accessible over serial? → No
 # Would you like the serial port hardware to be enabled? → Yes
sudo reboot
```

Crie o ambiente e entre nele

```bash
python -m venv .venv
source .venv/bin/activate
```

Depois instale as dependências

```bash
pip install -r requirements.txt
```

Rode

```bash
python3 uart.py
```
