# Handbook_GeneralProgramming

# Contents
- 
- [Docker](#Docker)


# Docker

**Use case 1: simple python script**
```py
# Create
docker build -t python-imdb .
# Run
docker run python-imdb
# Run in interactive mode
docker run -t -i python-imdb
```

**Use case 2: running a FastAPI (or e.g. Flask)**
```py
docker run -p 8000:8000 python-fastapi
```

*Note for ports: you specify 8000 & 0.0.0.0, however, localhost opens at 127.0.0.1:8000*

```py
# List running containers
docker ps
```
# API protocols

SOAP, REST, RPC, and others.
