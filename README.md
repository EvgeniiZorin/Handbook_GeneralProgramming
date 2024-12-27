# Handbook_GeneralProgramming

- [Handbook\_GeneralProgramming](#handbook_generalprogramming)
- [Programming languages classification](#programming-languages-classification)
- [Version Control Systems](#version-control-systems)
- [Docker](#docker)
  - [Dockerfile](#dockerfile)
  - [Image](#image)
  - [Container](#container)
  - [docker-compose up](#docker-compose-up)
- [API protocols](#api-protocols)
- [Communication Protocols](#communication-protocols)
  - [IP](#ip)
  - [File Transfer Protocols](#file-transfer-protocols)
  - [Protocols to control other equipment / devices](#protocols-to-control-other-equipment--devices)
    - [SSH](#ssh)
  - [Protocols to send voice and data](#protocols-to-send-voice-and-data)
  - [Network / internet protocols](#network--internet-protocols)
- [OS](#os)
  - [Linux](#linux)

<small><i><a href='http://ecotrust-canada.github.io/markdown-toc/'>Table of contents generated with markdown-toc</a></i></small>

# Programming languages classification

Based on how they execute commands:
- **Procedural** programming languages:
  - Concerned with how to perform tasks;
  - Centered around sets of instructions that are executed sequentially;
  - Procedural languages advantages:
    - Precise control over program execution;
    - Efficiency - memory usage and execution speed
  - Examples: C, Pascal, Fortran, Python, etc.
- **Non-procedural** (a.k.a. declarative) programming languages: 
  - Concerned with what the task is;
  - allow programmers to specify what they want without detailing how to achieve it, resulting in more concise code. 
  - The programmer specifies what the program should accomplish rather than detailing how to achieve it;
  - Advantages:
    - Abstraction that allows to focus on the what the problem is, rather than implementation details
    - Readability and concise code;
  - Examples: SQL, HTML, Prolog

# Version Control Systems

VCS is a system for source code management that makes the workflow of developers simpler and more robust.

Examples of VCS:
- Git: open-source, fast
- Git LFS
- SVN

Examples of version control hosting services:
- Github
- Gitlab
- Bitbucket

# Docker

Docker is a remarkable tool that enables you to transport your software together with its complete set of dependencies. This is advantageous because it allows you to run software without the necessity of installing the required interpreters or compilers.

To provide a clearer explanation, let's consider an example: Imagine you have trained a Deep Learning model utilizing Python and various libraries like Tensorflow or JAX. To accomplish this, you created a virtual environment on your personal computer. Everything functions smoothly, but now you desire to share this model with a colleague who lacks Python installation, let alone any of the obligatory libraries. In a pre-Docker era, your colleague would have to install all the aforementioned software simply to execute your model. However, by installing Docker, you can distribute a Docker image containing all your software, which will suffice entirely.

## Dockerfile

`Dockerfile`: file containing all the necessary instructions to build an image. A text file written in the `INSTRUCTION ARGUMENT` format. 

Instructions:
- `FROM`: start from base OS or another image. Has to be the 1st instruction
- `RUN`: install dependencies
- `COPY`: copies files from local system onto docker image
- `ENTRYPOINT`, `CMD`: run commands

Specify command: `CMD cmd param1` or `CMD ["cmd", "param1"]`.

`CMD` runs exact command as specified, e.g. `CMD ["sleep", "10"]`. `ENTRYPOINT` runs command appending parameters from cmd line, e.g. `ENTRYPOINT ['sleep']`, then provide argument from cmd line.

Provide default value for entrypoint:
```powershell
ENTRYPOINT ["sleep"]

CMD ["5"]
```

Example Dockerfile:
```Dockerfile
FROM python:3.10.10

ADD main.py .

ADD requirements.txt .

RUN pip install -r requirements.txt

CMD ["python", "main.py"]
```

## Image

`Image`: Collection of all the required software in one place (e.g. Python, Tensorflow, etc); a package / template. It is used to create one or more containers.  

Flags for `docker build`:
- `-t`: specify name of the image to be created
- `.`: specifies current directory for the build

```powershell
### Build an image
# - image name can be `<name>` or with a tag, which is useful for distinguishing newer images from older ones: `<name:tag>`, e.g. `main-app:0.1`.
docker build -t <name> .
docker build -t node-app:0.1 .

### clear cache
docker builder prune

### List images 
docker images
### Remove image
### If you want to remove an image, first make sure that no containers for that image are currently running
docker rmi <image_name>
docker rmi img1 img2 # Remove multiple images
docker image rm <id1> <id2>

### Remove <none> images
docker rmi $(docker images --filter "dangling=true" -q --no-trunc)
```

**Publish image**
```powershell
### Make img available on public registry (Docker registry / hub)
docker push imgname
### Manually export Docker image (so that you can send it privately)
# 1. Build your image
# 2. Export image as .tar archive
docker save my-image:latest > my-img.tar
# 3. Use exported image
docker load < my-img.tar
```


## Container

`Container`: Running instance of an image (the same or different images). Images by themselves don't do much aside from saving the information of your code and its dependencies. You need to run a container out of them to actually run the code within. Containers are usually meant to perform a single task but they can be used as runtimes to run software that you haven't installed.
- A container lives only as long as the process inside it is alive / running
- Container exists when the process inside it stops / crashes

Flags for `docker run`:
- `-d`: run the container in the background and not tied to the currently-opened terminal session
- `--rm`: Delete this container after stopping running it. This is to avoid having to manually delete the container
- `-p`: performs port mapping

```powershell
### Run container from image
# - `--name` allows you to specify a custom name for the container
# - If you want to run a FastAPI (e.g. Flask), you need to specify port (*Note for ports: you specify 8000 & 0.0.0.0, however, localhost opens at 127.0.0.1:8000*)
docker run python-imdb
docker run python-imdb --name <containerNameThatYouWant>
docker run -p 8000:8000 --name containerNameCustom node-app:0.1
docker run -p 4000:80 --name my-app -d node-app:0.1
# If you want to work with terminal input for docker container, run in interactive mode and enable terminal
docker run -it img1
### Resume run of a stopped container
docker start <container_id>

### View containers
# View running containers
docker ps # add -q to get a more standardised output, one container per line
# List all containers, even the ones that are not running
docker ps -a
# Get detailed info about a container
docker inspect contName
# Get log of a container. `-f` if you want to follow the log's output as the container is running
docker logs [container_id]

### Stop docker container
# Stop one
docker stop <container_id>
# Stop many 
docker stop <container_id1> <container_id2>
# Stop all runnning containers
docker ps -q | xargs docker stop

### Remove container(s)
docker rm <containerName>
# Remove multiple containers
docker rm id1 id2
```

You can connect to terminal of the container's environment:
```powershell
### Connect to container environment,
### where you can browse the environment with termianl
docker exec -it <cont_id> bash
# Disconnect
exit

### Connect to container's terminal with stdinput
### so if your code has `input` requirements, you can provide it from the terminal from this command
docker attach [OPTIONS] <CONTAINER_ID>
```

## docker-compose up

You can also create many containers from one Dockerfile using docker-compose:
- Run the same script many times with different passable parameters / arguments;
- Run different scripts within the same program directory that are responsible for doing different things.

There are two versions of "compose":
- `docker-compose`: external plugin that requires installation
- `docker compose`: a function of `docker`, no need to install

This is what a `docker-compose.yaml` file looks like:
```yaml
version: "3"
services:
  website: # name of the 1st container that you can specify
    image: nginx
    
    ports:
      - "8081:80"
    restart: always
  website2: # name of the 2nd container
    image: nginx
    ports:
      - "8082:80"
    restart: always
```

And here are some commands to run docker-compose:

```powershell
docker-compose up -d
### Force rebuild
docker-compose up -d --build

### check containers within the docker-compose
docker-compose ps

### Stop containers
docker-compose stop

### Remove all containers associated with the images in docker-compose (but not images themselves)
docker-compose down
```

# API protocols

SOAP, REST, RPC, and others.

# Communication Protocols

Capas del modelo OSI.

## IP

To find out my IP, run `ip r` in bash terminal or `ipconfig` in Powershell (or `ifconfig`). Your IP will be the one after "src".

## File Transfer Protocols

To send whatever type of file.

| Protocol | Description | Notes | 
| - | - | - |
| FTP (file transfer protocol) | The original ftp | Sends unencrypted data. |
| FTPS (ftp over SSL/TLS) | | |
| SFTP (ftp over ssh) | | |
| SCP (secure copy protocol) | Network protocol that supports file transfers. | |

## Protocols to control other equipment / devices

| Protocol | Description | Notes | 
| - | - | - |
| SSH (Secure Socket Shell) | Network protocol that provides means of encrypted communcations between your PC and a server. Used for remote login and command-line execution. | Cannot transfer files. |
| VNC | | Examples: teamviewer, anydesk. Can transfer files. |

### SSH

**Using SSH for git clone**
- Here's an instruction: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
- Run in bash: `ssh-keygen -t ed25519 -C "your_email@example.com"`
  - <u>It is important to use the email you used in the github / gitlab repository from where you are trying to git clone a repository!</u>
- When given a prompt "Enter file in which to save the key", you either just hit enter for the default option (your credentials will save to `~/.ssh`) or name the files something like `id_rsa`
- Next prompt "Enter passphrase (empty for no passphrase)" - just hit Enter to not utilise the passphrase
- At the end, either in `~/.ssh` or in the working directory, you will have three files:
  - Private key in `id_rsa` - do not share with anyone
  - Public key in `id_rsa.pub` - generally shareable
  - `known_hosts` directory - who knows what will be there
- Go to Gitlab / Github settings, SSH keys, add an SSH key with the key from `id_rsa.pub`
- Then you can clone the Gitlab / Github repository with SSH and in the terminal if / when you are prompted, you can insert the SSH key from `ssh_keys.pub`


## Protocols to send voice and data

| Protocol | Description | Notes | 
| - | - | - |
| RTSP | Streaming | |
| TCP/IP | Ethernet network. | |
| HTTP | | |

## Network / internet protocols

| Protocol | Description | Notes | 
| - | - | - |
| ipv4 | Decimal system (only numbers) with 4 billion total number of combinations possible. | `192.168.100.30` |
| ipv6 | Hexadecimal system with way more combinations. | |

---

**SSH**
```bash
# Connect via ssh
ssh <username>@<server IP>
```

If you can't connect, on your server use command `sudo service ssh status`. If it says "unit ssh.service could not be found", run the following command: `sudo apt-get install openssh-server`.

**SCP**

Importantly, remember that to do scp you DO NOT loging via ssh! Just write the scp commands directly in the console without an ssh command.
```bash
# Download file from server
scp <username>@<ip>:<full path of file> <address on local machine or current dir>
# Add flag -r after scp if you want to download a directory
# Example:
scp evgenii_zorin@123.456.789.0:/home/evgenii_zorin/Desktop/example.txt /mnt/c/Users/evgen/Desktop

# Upload file onto server
scp <path from where upload> <username>@<ip>:<full_path to where upload>
# Example:
scp /mnt/c/Users/evgen/Desktop/example.txt evgenii_zorin@123.456.789.0:/home/evgenii_zorin/Desktop
```

There are also some GUI applications that emulate the abovementioned functionalities:
| Program | Description | Notes |
| - | - | - |
| PuTTY | PuTTY is a free implementation of Telnet and SSH for Windows. | |
| WinSCP | WinSCP free, open-source SCP, SFTP, FTP for Windows. | Just login using info of remote machine (IP, username, and pw), and now you can transfer files between your local machine and the remote machine. |
| FileZilla | Like WinSCP but for macOS | |


# OS

## Linux

Before installing a Linux distro, you can check available popular distros at https://distrowatch.com/ and create a bootable USB at https://rufus.ie/en/. 
