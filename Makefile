up_proxy:
	@echo "--- deploy proxy ---"
	@docker compose -f ./docker-compose/proxy/docker-compose.yml --env-file ./docker.env/.proxy.env up --detach --build

down_proxy:
	@echo "--- shutdown proxy ---"
	@docker compose -f ./docker-compose/proxy/docker-compose.yml --env-file ./docker.env/.proxy.env down

up_databases:
	@echo "--- deploy database ---"
	@docker compose -f ./docker-compose/databases/docker-compose.yml --env-file ./docker.env/.databases.env up --detach --build

down_databases:
	@echo "--- shutdown database ---"
	@docker compose -f ./docker-compose/databases/docker-compose.yml --env-file ./docker.env/.databases.env down

up:
	@echo "--- deploy action ---"
	@read -p "- module group (1: internal | 2: public): " group_id; \
	if [ $$group_id = "2" ]; then\
		docker compose -f ./docker-compose/public/docker-compose.yml --env-file ./docker.env/.public.env up --detach --build;\
	else\
		read -p "- module name (portainer) : " module_name;\
		test -f "./docker.env/.internal.$$module_name.env" && docker compose -f ./docker-compose/internal/$$module_name/docker-compose.yml --env-file ./docker.env/.internal.$$module_name.env up --detach --build;\
		test ! -f "./docker.env/.internal.$$module_name.env" && docker compose -f ./docker-compose/internal/$$module_name/docker-compose.yml up --detach --build;\
	fi

down:
	@echo "--- shutdown action ---"
	@read -p "- module group (1: internal | 2: public): " group_id; \
	if [ $$group_id = "2" ]; then\
		docker compose -f ./docker-compose/public/docker-compose.yml --env-file ./docker.env/.public.env down; \
	fi

install_shell_command:
	@echo "--- shell command installing... ---"
	@test ! -f "/usr/local/bin/ddocker" && sudo cp ddocker /usr/local/bin/
