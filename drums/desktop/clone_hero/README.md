# Drummies

Abaixo temos a descrição de como rodar um o "modo jogo" do projeto Drummies, que consiste
basicamente em mapear as batidas da bateria para teclas dentro do jogo [**Clone Hero**](https://clonehero.net/).

# Jogo
Antes de mais nada, é necessário instalar o [jogo](https://clonehero.net/launcher/).

Após isso, mapeie as teclas conforme descrito em `clonehero.py`, ou seja, por padrão:

| Ação | Tecla |
| -------- | -------- |
| Verde | a |
| Vermelho  | a |
| Amarelo  | a |
| Azul  | a |
| Laranja  | a |

# Setup

Crie o ambiente virtual python e entre nele e entre nele

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
python3 clone_hero.py
```

