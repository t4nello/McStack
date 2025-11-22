
# MCSwarm

A set of stacks to deploy minecraft server on linux OS with:
- Node Exporter
- Prometheus
- Grafana
- Traefik
- Portainer

## Prerequisites

To propelly setup the stacks you have to install docker engine accoring to the instructions on https://docs.docker.com/engine/install/, afer installation follow the steps on https://docs.docker.com/engine/install/linux-postinstall/ .

Install ```apache2-utils``` package to generate password for Traefik 

## Installation
1. Clone the repository

2. Go to cloned repository folder:

```bash
cd McSwarm
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

| Variable                   | Stack      | Required? | Default value                              |
|----------------------------|------------|-----------|--------------------------------------------|
| MINECRAFT_SERVER_PORT      | Managament | No        | 25565                                      |
| XMS                        | Server     | No        | 1024m                                      |
| XMX                        | Server     | No        | 4098m                                      |
| SERVER_DIR                 | Server     | Yes       |                                            |
| JAR_FILE_NAME              | Server     | Yes       | server.jar                                 |
| JDK_IMAGE_TAG              | Server     | Yes       | 19-jdk                                     |

Example values of the Environment Variables are stored in the `example-env-values` folder

## Endpoints

All endpoint begins with IP address of the server

- **`/traefik/dashboard/`** - Traefik dashboard (The trailing slash is mandatory!)
- **`/grafana`** - Grafana dashboard
- **`/portainer`** - Portainer administration panel
- **`/prometheus`** - Prometheus panel
## Dashboard

This project uses a dashboard based on the [Node Exporter Full](https://grafana.com/grafana/dashboards/1860-node-exporter-full/) from Grafana Labs.

