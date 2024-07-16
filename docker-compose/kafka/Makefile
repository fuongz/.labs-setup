DOCKER_COMPOSE := docker compose
DOCKER := docker


deploy:
	@echo "- Build:"
	@$(DOCKER_COMPOSE) up --detach --build

ps:
	@$(DOCKER) ps --format "table {{.Image}}\t{{.Ports}}\t{{.Names}}"
