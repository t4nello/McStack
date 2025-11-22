
# McStack

A set of stacks to deploy minecraft server on linux OS with:
- Node Exporter
- Prometheus
- Grafana
- Traefik
- Portainer

## Prerequisites

To properly set up the stacks, you have to install Docker Engine according to the instructions on [https://docs.docker.com/engine/install/](https://docs.docker.com/engine/install/). After installation, follow the steps on [https://docs.docker.com/engine/install/linux-postinstall/](https://docs.docker.com/engine/install/linux-postinstall/).

Install the `apache2-utils` package to generate a password for Traefik:

```bash
sudo apt install apache2-utils
```

### Additional Docker configuration

After installing Docker, you need to add an environment variable for the Docker service:

1. Edit the Docker service file:

```bash
sudo nano /etc/systemd/system/multi-user.target.wants/docker.service
```

2. Add the following line under the `[Service]` section:

```
Environment=DOCKER_MIN_API_VERSION=1.24
```

3. Reload systemd and restart the Docker service:

```bash
sudo systemctl daemon-reload
sudo systemctl restart docker.service
```

This ensures the environment variable is applied correctly and Docker uses the minimum API version.


## Installation
1. Clone the repository

2. Go to cloned repository folder:

```bash
cd McStack
```
4. create username and password for traefik dashboard:

```bash
htpasswd -Bc -C 6 ./management/usersfile <username>
```
At this point you will be asked to type then retype password.

5. To deploy the application, you need to grant execute permissions to the deploy script and then run it:
Parameter <port> is used to set the port for minecraft server. Alloved values are 0-65535. If parameter is empty, default 25565 will be used
```bash
chmod +x deploy.sh
./deploy.sh  <port>
```

Login to Portainer ```http:<ip>/portainer``` then deploy other stacks

Before deployment the Minecraft server stack it is necessary to create folder on your machine with all neccesary files needed to run minecraft server like server.jar and eula.txt, then pass te proper values into the right environment variables. During first startup of the stack, if all variables are passed correctly, all neccesary files like server.properites, world etc. will be created. After that you can stop the stack and modify your server and run it again.

## Environment Variables

### Management
| MINECRAFT_SERVER_PORT  | Management | No        | 25565         | Exposed port on which the Minecraft server will run |


### Monitoring
| Variable    | Stack      | Required? | Default value | Description                             |
|------------ |------------|-----------|---------------|-----------------------------------------|
| DEPLOY_DIR  | Monitoring | Yes       |               | Absolute path to the cloned repository  |

### Server
| Variable       | Stack  | Required? | Default value | Description                                           |
|----------------|--------|-----------|---------------|-------------------------------------------------------|
| XMS            | Server | No        | 1024m         | Initial heap size for the JVM                        |
| XMX            | Server | No        | 4098m         | Maximum heap size for the JVM                        |
| SERVER_DIR     | Server | Yes       |               | Absolute path to directory where the Minecraft server files are stored|
| JAR_FILE_NAME  | Server | Yes       | server.jar    | Name of the Minecraft server JAR file                |
| JDK_IMAGE_TAG  | Server | Yes       | 19-jdk        | Docker image tag of the JDK to run the server        |



Example values of the Environment Variables are stored in the `example-env-values` folder

## Endpoints

All endpoint begins with IP address of the server (The trailing slashes in the endpoints are mandatory!)

- **`/traefik/dashboard/`** - Traefik dashboard 
- **`/grafana/`** - Grafana dashboard
- **`/portainer/`** - Portainer administration panel
- **`/prometheus/`** - Prometheus panel
## Dashboard

This project uses a dashboard based on the [Node Exporter Full](https://grafana.com/grafana/dashboards/1860-node-exporter-full/) from Grafana Labs.

