
# Variables
DOCKER_COMPOSE = docker compose
PHP_CONTAINER = php

# Colors
GREEN = \033[0;32m
NC = \033[0m # No Color

.PHONY: help start stop restart setup shell db-create db-migrate db-fixtures test phpstan cs-check cs-fix

help: ## Show this help message
	@echo "Usage: make [command]"
	@echo ""
	@echo "Commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  ${GREEN}%-20s${NC} %s\n", $$1, $$2}'

start: ## Start the Docker stack
	$(DOCKER_COMPOSE) up -d
	@echo "${GREEN}Stack started!${NC}"
	@echo "App available at: https://localhost"

stop: ## Stop the Docker stack
	$(DOCKER_COMPOSE) stop
	@echo "${GREEN}Stack stopped.${NC}"

restart: stop start ## Restart the Docker stack

setup: start ## Setup the project (install, database, fixtures)
	@echo "Installing dependencies..."
	$(DOCKER_COMPOSE) exec $(PHP_CONTAINER) composer install
	@echo "Waiting for database to be ready..."
	@sleep 5
	$(DOCKER_COMPOSE) exec $(PHP_CONTAINER) bin/console doctrine:database:create --if-not-exists
	$(DOCKER_COMPOSE) exec $(PHP_CONTAINER) bin/console doctrine:migrations:migrate --no-interaction
	$(DOCKER_COMPOSE) exec $(PHP_CONTAINER) bin/console doctrine:fixtures:load --no-interaction
	@echo "${GREEN}Setup complete!${NC}"
	@echo "API:     https://localhost/api"

shell: ## Open a shell in the PHP container
	$(DOCKER_COMPOSE) exec $(PHP_CONTAINER) bash

db-create: ## Create the database
	$(DOCKER_COMPOSE) exec $(PHP_CONTAINER) bin/console doctrine:database:create

db-migrate: ## Run migrations
	$(DOCKER_COMPOSE) exec $(PHP_CONTAINER) bin/console doctrine:migrations:migrate --no-interaction

db-fixtures: ## Load fixtures
	$(DOCKER_COMPOSE) exec $(PHP_CONTAINER) bin/console doctrine:fixtures:load --no-interaction

test: ## Run tests
	$(DOCKER_COMPOSE) exec $(PHP_CONTAINER) vendor/bin/simple-phpunit

phpstan: ## Run PHPStan static analysis
	$(DOCKER_COMPOSE) exec $(PHP_CONTAINER) vendor/bin/phpstan analyse

cs-check: ## Check coding standards
	$(DOCKER_COMPOSE) exec $(PHP_CONTAINER) vendor/bin/php-cs-fixer fix --dry-run --diff

cs-fix: ## Fix coding standards
	$(DOCKER_COMPOSE) exec $(PHP_CONTAINER) vendor/bin/php-cs-fixer fix
