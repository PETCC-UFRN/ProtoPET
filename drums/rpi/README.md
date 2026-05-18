# Setup

Baixe os pacotes de sistema
```bash
sudo apt install hydrogen python3-rtmidi
```

Habilite a comunicação e reinicie
```bash
sudo raspi-config # Interface Options -> Serial Port
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
