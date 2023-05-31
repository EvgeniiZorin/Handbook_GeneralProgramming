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

`Dockerfile`: file containing all the necessary instructions to build an image. 

`Image`: Collection of all the required software in one place (e.g. Python, Tensorflow, etc); a package / template. It is used to create one or more containers.  

`Container`: Running instance of an image (the same or different images). Images by themselves don't do much aside from saving the information of your code and its dependencies. You need to run a container out of them to actually run the code within. Containers are usually meant to perform a single task but they can be used as runtimes to run software that you haven't installed.

---

Commands:

```powershell
# Build an image
# Here, `-t` is to specify name, `.` to specify current directory for the build
docker build -t python-imdb .
# The -t is to name and tag an image with the name:tag syntax. The name of the image is node-app and the tag is 0.1. 
# The tag is highly recommended when building Docker images. If you don't specify a tag, the tag will default to latest and it becomes more difficult to distinguish newer images from older ones.
docker build -t node-app:0.1 .

# Run 
# run a container from an image
docker run python-imdb
docker run python-imdb --name <container_name_to_specify> # if you want to specify running container name
# Run in interactive mode
docker run -t -i python-imdb
# If you want to run a FastAPI (e.g. flask), you need to specify port
# *Note for ports: you specify 8000 & 0.0.0.0, however, localhost opens at 127.0.0.1:8000*
docker run -p 8000:8000 --name container-name-custom node-app:0.1
# If you want the container to run in the background (not tied to the terminal's session), you need to specify the -d flag.
docker run -p 4000:80 --name my-app -d node-app:0.1

# Logs
# You don't have to write the entire container ID, as long as the initial characters uniquely identify the container. For example, you can execute docker logs 17b if the container ID is 17bcaca6f
docker logs [container_id]
# `-f` if If you want to follow the log's output as the container is running
```

Stop docker container
```powershell
docker stop <container_id>
```


```powershell
# List images available
docker images
# List running containers
docker ps
docker ps -a # list all containers, even ones that don't run
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
