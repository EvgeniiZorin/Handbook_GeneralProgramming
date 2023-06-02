# Handbook_GeneralProgramming

- [Handbook_GeneralProgramming](#handbook-generalprogramming)
- [Docker](#docker)
- [API protocols](#api-protocols)
- [Network Protocols](#network-protocols)
- [OS](#os)
  * [Linux](#linux)
  * [Windows](#windows)

<small><i><a href='http://ecotrust-canada.github.io/markdown-toc/'>Table of contents generated with markdown-toc</a></i></small>

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

## Container

`Container`: Running instance of an image (the same or different images). Images by themselves don't do much aside from saving the information of your code and its dependencies. You need to run a container out of them to actually run the code within. Containers are usually meant to perform a single task but they can be used as runtimes to run software that you haven't installed.
- A container lives only as long as the process inside it is alive / running
- Container exists when the process inside it stops / crashes

---

## Commands:

**Image**

Flags for `docker build`:
- `-t`: specify name of the image to be created
- `.`: specifies current directory for the build

```powershell
### Build an image
# - image name can be `<name>` or with a tag, which is useful for distinguishing newer images from older ones: `<name:tag>`, e.g. `main-app:0.1`.
docker build -t <name> .
docker build -t node-app:0.1 .

### List images 
docker images
### Remove image
# If you want to remove an image, first make sure that no containers for that image are currently running
docker rmi <image_name>
docker rmi img1 img2 # Remove multiple images
```

**Container**

Flags for `docker run`:
- `-d`: run the container in the background and not tied to the currently-opened terminal session
- `--rm`: Delete this container after stopping running it. This is to avoid having to manually delete the container
- `-p`: performs port mapping

```powershell
### Run container
# - `--name` allows you to specify a custom name for the container
# - If you want to run a FastAPI (e.g. Flask), you need to specify port (*Note for ports: you specify 8000 & 0.0.0.0, however, localhost opens at 127.0.0.1:8000*)
docker run python-imdb
docker run python-imdb --name <containerNameThatYouWant>
docker run -p 8000:8000 --name containerNameCustom node-app:0.1
docker run -p 4000:80 --name my-app -d node-app:0.1
# If you want to work with terminal input for docker container, run in interactive mode and enable terminal
docker run -it img1

### View containers
# View running containers
docker ps
# List all containers, even the ones that are not running
docker ps -a
# Get detailed info about a container
docker inspect contName
# Get log of a container. `-f` if you want to follow the log's output as the container is running
docker logs [container_id]
### Stop docker container
docker stop <container_id>
### Remove container(s)
docker rm <containerName>
# Remove multiple containers
docker rm id1 id2
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


# API protocols

SOAP, REST, RPC, and others.

# Network Protocols

To find out my IP, run `ip r` in bash terminal. Your IP will be the one after "src".

| Protocol | Description | Notes | 
| - | - | - |
| FTP (file transfer protocol) | The original ftp | Sends unencrypted data. |
| FTPS (ftp over SSL/TLS) | | |
| SFTP (ftp over ssh) | | |
| SCP (secure copy protocol) | Network protocol that supports file transfers. |  |
| HTTP & HTTPS | | |
| AS2, AS3, AS4 | | |
| SSH (secure socket shell) | Network protocol that provides means of encrypted communcations between your PC and a server. Used for remote login and command-line execution. | |

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
