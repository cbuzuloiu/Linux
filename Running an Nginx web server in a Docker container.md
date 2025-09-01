```bash
docker container run -d -p 8080:80 --name mysite nginx
```

### Step-by-step explanation:

1. **`docker container run`**
    - Tells Docker to create and start a new container from the given image (`nginx` in this case).
2. **`-d` (detached mode)**
    - Runs the container in the background.
    - Without `-d`, Docker runs the container attached to your terminal, and you’d see the logs streaming.
    - With `-d`, you just get the container ID and it keeps running in the background.
3. **`-p 8080:80` (port mapping)**    
    - Maps a port from your **host machine** (the left side, `8080`) to a port inside the **container** (the right side, `80`).
    - `80` is the default HTTP port that Nginx listens on inside the container.
    - `8080` is the port on your machine you’ll use to reach it.
    - So if you go to `http://localhost:8080` (or your server’s IP with `:8080`), you’ll hit the Nginx web server running inside the container.
    
    >This is different from `-P` (uppercase), which maps to a **random high port**. Here you **choose the port explicitly**.
1. **`--name mysite`**
    - Assigns a custom name to your container (`mysite`).
    - Without this, Docker gives it a random funny name (like `peaceful_panda`).
    - With a name, it’s easier to manage:
        - `docker stop mysite`
        - `docker start mysite`
        - `docker logs mysite`
2. **`nginx`**
    - The image to run.
    - If you don’t already have it locally, Docker will **pull it from Docker Hub** automatically.
    - This image includes the official Nginx web server.

### What happens after running the command:
- Docker pulls the `nginx` image (if not already present).
- Creates a new container named `mysite`.
- Runs Nginx inside it in **detached mode**.
- Exposes port **8080 on your host → 80 inside the container**.

So, accessing `http://<host-ip>:8080` will display the Nginx welcome page.

```bash
docker ps                     # See running containers and their ports
docker logs mysite            # View logs of the nginx container
docker exec -it mysite bash   # Get inside the container
```

