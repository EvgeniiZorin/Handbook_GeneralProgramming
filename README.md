# Handbook_GeneralProgramming

# Contents
- [Handbook General Programming](#handbook_generalprogramming)
- [Contents](#contents)
- [Docker](#docker)
- [API protocols](#api-protocols)
- [OS](#os)
  - [Linux](#linux)
  - [Windows](#windows)


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

# OS

## Linux

Before installing a Linux distro, you can check available popular distros at https://distrowatch.com/ and create a bootable USB at https://rufus.ie/en/. 

## Windows

**Environment variables (Powershell)**

```py
# List all environment variables
Get-ChildItem Env:
# Print a specific environment variable
echo $Env:EMAIL_USER

# Set an env var:
[Environment]::SetEnvironmentVariable("variable_name","variable_value","User")
### Then, reopen the terminal
```
