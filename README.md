# Handbook_GeneralProgramming

# Contents
- [Handbook General Programming](#handbook_generalprogramming)
- [Contents](#contents)
- [Docker](#docker)
- [API protocols](#api-protocols)
- [Network Protocols](#network-protocols)
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

# Network Protocols


| Protocol | Description | Notes | 
| - | - | - |
| FTP (file transfer protocol) | The original ftp | Sends unencrypted data. |
| FTPS (ftp over SSL/TLS) | | |
| SFTP (ftp over ssh) | | |
| SCP (secure copy protocol) | Network protocol that supports file transfers. |  |
| HTTP & HTTPS | | |
| AS2, AS3, AS4 | | |
| SSH (secure shell protocol) | Network protocol for operating network services securely over an unsecured network. Used for remote login and command-line execution. | |

| Program | Description |
| - | - |
| PuTTY | PuTTY is a free implementation of Telnet and SSH for Windows. |
| WinSCP | WinSCP free, open-source SCP, SFTP, FTP for Windows. |
| FileZilla | Like WinSCP but for macOS |

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
**Environment variables (GUI)**

You can set environment variable in GUI by following the following steps:
- Win+R
- `sysdm.cpl`
- "Advanced" tab
- "Environment Variables"
- "New"
- Define a variable
