Docker is one of the most popular containerization platforms, allowing developers to package applications and their dependencies into lightweight, portable containers. In this guide, we’ll go step by step through installing Docker, pulling images, running containers, and managing them on an Ubuntu server.

## Install Docker Engine on Ubuntu

The best practice is to follow the official Docker documentation:  
👉 [Install Docker Engine on Ubuntu](https://docs.docker.com/engine/install/ubuntu/?utm_source=chatgpt.com)

Once installed, confirm that the Docker service is running:
```bash
systemctl status docker
```

You should see `active (running)` in the output.

Verify that the Docker client can talk to the Docker daemon:

```bash
docker --version
docker version
docker info
```

If everything is working, you’re ready to start pulling images and running containers.

## Pulling Images and Running Containers

Docker images are blueprints for containers. Let’s pull an image from Docker Hub:

```bash
docker image pull redis:5.0.10
```

### Common Image Commands

- List images
```bash
docker images
docker image ls
```
- Run a container from an image
```bash
docker container run redis:5.0.10
```
- Remove a Docker image
```bash
docker rmi redis:5.0.10
```
- If the image is in use and you still want to remove it:
```bash
docker rmi -f IMAGE_ID
```
- Remove dangling (unused) images
```
docker image prune
```
- Remove all unused images (not just dangling ones)
```
docker image prune -a -f
```

## Running an Apache Webserver

Let’s pull and run the official Apache HTTP server image:
```bash
docker container run -P httpd
```

#### Breaking it down

- `docker container run` → Create and start a new container from an image.
- `httpd` → Official Apache HTTP server image.
- `-P` (uppercase P) → Publish all exposed ports (in this case port **80**) to **random available high ports** on the host machine.

Example mapping:
```bash
0.0.0.0:32768->80/tcp
```

That means port **80 inside the container** is mapped to port **32768 on your host**.  
You can now access Apache at: `http://<host-ip>:32768`

To see what port was mapped:
```bash
docker ps
```

If you want to map a specific host port instead of a random one:
```bash
docker container run -p 8080:80 httpd
```

Now Apache will be accessible at `http://<host-ip>:8080`.

## The Docker CLI in Action
Here are some essential Docker CLI commands:

Testing the installation

```bash
docker --version
docker version
docker info
docker container run hello-world
```

Getting help

```bash
docker help
docker container help
```

Searching for images on Docker Hub

```
docker search debian
docker search mongo
```

Pulling images

```bash
docker image pull redis:5.0.10 
docker image pull ubuntu:latest
docker image pull mysql        # default tag is latest
```

Listing images

```bash
docker images
docker image ls
```

Running containers

```bash
docker container run -P httpd
# Equivalent to:
docker container create -P httpd
docker container start <CONTAINER_ID>
docker container ls -a
```

Getting a shell into a container

```bash
docker container run -it centos
```

Press `Ctrl + P + Q` to detach without stopping the container.