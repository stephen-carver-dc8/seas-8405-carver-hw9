.PHONY: up down reset logs

DOCKER_COMPOSE := $(shell command -v docker-compose > /dev/null && echo docker-compose || echo docker compose)

before-up: after-down
	@$(DOCKER_COMPOSE) --project-directory ./before up -d

before-down:
	@$(DOCKER_COMPOSE) --project-directory ./before down

before-reset: before-down after-down
	@$(DOCKER_COMPOSE) --project-directory ./before up -d --build 
	@sleep 5
	@python3 ./before/test.py

before-logs:
	@$(DOCKER_COMPOSE) --project-directory ./before logs -f

after-up: before-down
	@$(DOCKER_COMPOSE) --project-directory ./after up -d

after-down:
	@$(DOCKER_COMPOSE) --project-directory ./after down

after-reset: after-down before-down
	@$(DOCKER_COMPOSE) --project-directory ./after up -d --build 
	@sleep 5
	@python3 ./after/test.py

after-logs:
	@$(DOCKER_COMPOSE) --project-directory ./after logs -f