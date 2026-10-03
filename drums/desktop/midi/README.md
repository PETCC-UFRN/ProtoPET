# Drummies

Abaixo temos a descrição de como rodar um o "modo instrumento" do projeto Drummies. Uma vez tendo um computador desktop ou um **RaspberryPI**:

## No Raspberry

Habilite a comunicações, permissões e reinicie:

```bash
sudo raspi-config # Interface Options -> Serial Port
# Would you like a login shell to be accessible over serial? → No
# Would you like the serial port hardware to be enabled? → Yes
```



## Em ambos

Instale os pacotes necessários
```bash

sudo apt update
sudo apt install hydrogen libasound2-dev pkg-config cmake python3-rtmidi
```

Dê as permissões necessárias

```bash
sudo usermod -aG dialout $USER
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
python3 midi.py
```
