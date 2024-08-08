.PHONY: build up down logs clean ps shell  help restart replication-status

export COMPOSE_PROJECT_NAME := mysql-replication

all:
	@make -s help

up:
	@echo "Starting Docker containers..."
	docker compose up -d
	@make -s ps

build:
	@echo "Building Docker images..."
	docker compose build --no-cache

down:
	@echo "Stopping Docker containers..."
	docker compose down --remove-orphans

ps:
	@echo "List of Docker containers..."
	docker compose ps

logs:
	@echo "Fetching logs from Docker containers..."
	docker compose logs --tail=100 --follow

clean:
	@echo "Removing stopped containers and unused volumes..."
	docker compose down -v --rm all
	docker system prune -f

restart:
	@make -s down
	@make -s up

shell:
	@read -p "Enter the Docker container name: " name; \
	docker compose exec -it $$name sh

replication-status:
	@echo "Replciation status"
	docker exec -it mysql1 mysql -uroot -proot -e "SHOW SLAVE STATUS\G"
	docker exec -it mysql2 mysql -uroot -proot -e "SHOW SLAVE STATUS\G"

help:
	@echo "Commands for the docker group:"
	@echo "  make up                 - Start Docker containers in detached mode"
	@echo "  make build              - Build Docker images for the services defined in the Docker Compose file"
	@echo "  make down               - Stop and remove Docker containers, networks, and volumes"
	@echo "  make restart            - Restart Docker containers"
	@echo "  make clean              - Remove stopped containers and unused volumes to free up space"
	@echo "  make ps                 - List the status of Docker containers"
	@echo "  make logs               - Display and follow the logs of Docker containers"
	@echo "  make shell              - Enter the shell of a specified Docker container"
	@echo "  make replication-status - Replciation status"
