# Docker MySQL Replication with HAProxy

![License](https://img.shields.io/badge/license-MIT-blue.svg)


This project sets up a highly available MySQL replication environment using Docker with HAProxy as a load balancer. It demonstrates a master-master replication setup, allowing for distributed database access and improved fault tolerance.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Configuration](#configuration)
- [Usage](#usage)
- [License](#license)

## Prerequisites

- [Docker](https://www.docker.com/) installed on your machine
- [Docker Compose](https://docs.docker.com/compose/) installed on your machine

## Getting Started

1. Clone this repository:

```bash
   git clone https://github.com/yourusername/docker-mysql-replication-haproxy.git
   cd docker-mysql-replication-haproxy

```
2. Build and start the containers:

   make up

## Configuration

### Docker Compose File

The `docker-compose.yml` file defines three services: `mysql1`, `mysql2`, and `haproxy`. Here is a brief description of each service:

- **mysql1**: The first MySQL instance, serving as one of the master nodes.
- **mysql2**: The second MySQL instance, serving as the second master node.
- **haproxy**: The load balancer that distributes traffic between the two MySQL instances.

### MySQL Configuration

In the MySQL configuration files, you can adjust settings related to replication, character sets, logging, etc. Below are the key configuration options:

- `server-id`: Unique identifier for each MySQL server instance.

## Usage

### Initializing Replication

After the containers are up and running, you can initialize the replication by executing the following command:

```bash
docker exec -it mysql1 mysql -uroot -proot -e "CHANGE MASTER TO MASTER_HOST='mysql2', MASTER_USER='repl', MASTER_PASSWORD='repl_password', MASTER_AUTO_POSITION=1; START SLAVE;"

docker exec -it mysql2 mysql -uroot -proot -e "CHANGE MASTER TO MASTER_HOST='mysql1', MASTER_USER='repl', MASTER_PASSWORD='repl_password', MASTER_AUTO_POSITION=1; START SLAVE;"
```

### Accessing MySQL

You can access MySQL from your host machine using the following commands:

docker exec -it mysql1 mysql -uroot -proot

docker exec -it mysql2 mysql -uroot -proot

### Accessing HAProxy

You can access to HAProxy through mysql1 or mysql2 container:

docker exec -it mysql1 mysql -h haproxy -uroot -proot


### Replciation status

To check replication status:

```bash
make replication-status
```

### Run in docker
```bash
make build
make up
make help
```

## License
This project is licensed under the MIT License - see the LICENSE file for details.
