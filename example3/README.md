# Docker of main.py + + write to file

## Build docker image

`docker build -t 230602_example3 .`

## Run a container from image

`docker run --mount type=bind,source="$(pwd)",target=/output3 230602_example3`
