.PHONY: help dev prod build up down logs shell migrate createsuperuser test clean

include .env
export

# Default target
help: ## Show this help message
	@echo "Heichal Management System"
	@echo "================================"
	@echo "Available commands:"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

# Development commands
dev: ## run full stack in dev mode
	@echo "Starting development environment..."
	@ENVIRONMENT=dev docker compose -f docker-compose.yml -f docker-compose.dev.yml up --build

dev-d:  ## run full stack in dev mode (detached)
	@echo "Starting development environment (detached)..."
	@ENVIRONMENT=dev docker compose -f docker-compose.yml -f docker-compose.dev.yml up --build -d

# Production commands
prod:
	@echo "Starting production environment..."
	@ENVIRONMENT=prod docker compose -f docker-compose.yml -f docker-compose.prod.yml --profile prod up --build

prod-d:
	@echo "Starting production environment (detached)..."
	@ENVIRONMENT=prod docker compose -f docker-compose.yml -f docker-compose.prod.yml --profile prod up --build -d

# Build commands
build:
	@docker compose build

build-server:
	@docker compose build server

build-client:
	@docker compose build client

build-no-cache: ## Build all containers without cache
	@docker compose build --no-cache

build-client-no-cache: ## Build client container without cache
	@docker compose build --no-cache client

build-server-no-cache: ## Build server container without cache
	@docker compose build --no-cache server

# Container management
up:
	@docker compose up -d

down:
	@docker compose down

restart:
	@docker compose restart

# Logs
logs: ## Show all logs
	@docker compose logs -f

logs-server: ## Show server logs
	@docker compose logs -f server

logs-client: ## Show client logs
	@docker compose logs -f client

logs-postgres: ## Show PostgreSQL logs
	@docker compose logs -f postgres

logs-caddy: ## Show Caddy logs
	@docker compose logs -f caddy

# Database commands
migrate: ## Run server migrations
	@docker compose exec server python manage.py migrate

makemigrations: ## Create server migrations
	@docker compose exec server python manage.py makemigrations

cohengadol: ## Create server superuser
	@echo "Creating Cohen Gadol account (superuser)"
	@docker compose exec server python manage.py createsuperuser --username cohengadol

dbshell: ## Access database shell
	@docker compose exec postgres psql -U $(POSTGRES_USER) -d $(POSTGRES_DB)

# Django management
shell: ## Access server shell
	@docker compose exec server python manage.py shell

collectstatic: ## Collect static files
	@docker compose exec server python manage.py collectstatic --noinput

# Testing
test:
	@docker compose exec server python manage.py test

test-client:
	@docker compose exec client npm run test

# Utility commands
clean: ## Clean up containers, networks, and volumes
	@echo "Cleaning up Docker resources..."
	@docker compose down -v --remove-orphans
	@docker system prune -f

clean-all: ## Clean up everything including images
	@echo "Cleaning up all Docker resources..."
	@docker compose down -v --remove-orphans --rmi all
	@docker system prune -af

backup-db: ## Backup database
	@echo "Creating database backup..."
	@docker compose exec postgres pg_dump -U $(POSTGRES_USER) $(POSTGRES_DB) > backup_$(shell date +%Y%m%d_%H%M%S).sql

restore-db: ## Restore database from backup (usage: make restore-db FILE=backup.sql)
	@echo "Restoring database from $(FILE)..."
	@docker compose exec -T postgres psql -U $(POSTGRES_USER) -d $(POSTGRES_DB) < $(FILE)

# Development helpers
install-deps: ## Install dependencies locally for IDE support
	@echo "Installing Python dependencies..."
	@cd server && pip install -r requirements/dev.txt
	@echo "Installing Node dependencies..."
	@cd client && npm install

update-deps: ## Update dependencies
	@echo "Updating Python dependencies..."
	@docker compose exec django pip install -r requirements/dev.txt --upgrade
	@echo "Updating Node dependencies..."
	@docker compose exec client npm update

# Security and maintenance
check-security: ## Run security checks
	@echo "Running Django security checks..."
	@docker compose exec django python manage.py check --deploy
	@echo "Running npm security audit..."
	@docker compose exec client npm audit

update-requirements: ## Update Python requirements files
	@echo "Updating requirements..."
	@docker compose exec django pip freeze > server/requirements/current.txt

# Quick setup for new developers
setup: ## First-time setup for new developers
	@echo "Setting up Heichal Management System..."
	@if [ ! -f .env ]; then \
		echo "Copying .env.example to .env..."; \
		cp .env.example .env; \
		echo "Please edit .env file with your configuration"; \
	fi
	@echo "Building containers..."
	@make build
	@echo "Starting development environment..."
	@make dev-d
	@echo "Waiting for database..."
	@sleep 10
	@echo "Running migrations..."
	@make migrate
	@echo "Setup complete! Create a superuser with: make createsuperuser"

# Deployment helpers
deploy-prod: ## Deploy to production
	@echo "Deploying to production..."
	@ENVIRONMENT=prod docker compose -f docker-compose.yml -f docker-compose.prod.yml --profile prod up --build -d
	@make migrate
	@make collectstatic
	@echo "Production deployment complete!"

health-check: ## Check service health
	@echo "Checking service health..."
	@docker compose ps
	@echo "\nDjango health:"
	@curl -f http://localhost:8000/api/health/ || echo "Django not responding"
	@echo "\nVue health (dev mode):"
	@curl -f http://localhost:3000/ || echo "Vue dev server not responding"