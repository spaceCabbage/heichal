.PHONY: help dev prod build up down logs shell migrate createsuperuser test clean

# Load environment variables
include .env
export

# Default target
help: ## Show this help message
	@echo "Beis HaMikdash Management System"
	@echo "================================"
	@echo "Available commands:"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

# Development commands
dev: ## Start development environment
	@echo "Starting development environment..."
	@ENVIRONMENT=dev docker compose -f docker-compose.yml -f docker-compose.dev.yml up --build

dev-d: ## Start development environment in detached mode
	@echo "Starting development environment (detached)..."
	@ENVIRONMENT=dev docker compose -f docker-compose.yml -f docker-compose.dev.yml up --build -d

# Production commands
prod: ## Start production environment
	@echo "Starting production environment..."
	@ENVIRONMENT=prod docker compose -f docker-compose.yml -f docker-compose.prod.yml --profile prod up --build

prod-d: ## Start production environment in detached mode
	@echo "Starting production environment (detached)..."
	@ENVIRONMENT=prod docker compose -f docker-compose.yml -f docker-compose.prod.yml --profile prod up --build -d

# Build commands
build: ## Build all images
	@docker compose build

build-django: ## Build only Django image
	@docker compose build django

build-vue: ## Build only Vue image
	@docker compose build vue

# Container management
up: ## Start containers (use current ENVIRONMENT from .env)
	@docker compose up -d

down: ## Stop all containers
	@docker compose down

restart: ## Restart all containers
	@docker compose restart

# Logs
logs: ## Show all logs
	@docker compose logs -f

logs-django: ## Show Django logs
	@docker compose logs -f django

logs-vue: ## Show Vue logs
	@docker compose logs -f vue

logs-postgres: ## Show PostgreSQL logs
	@docker compose logs -f postgres

logs-caddy: ## Show Caddy logs
	@docker compose logs -f caddy

# Database commands
migrate: ## Run Django migrations
	@docker compose exec django python manage.py migrate

makemigrations: ## Create Django migrations
	@docker compose exec django python manage.py makemigrations

createsuperuser: ## Create Django superuser
	@docker compose exec django python manage.py createsuperuser

dbshell: ## Access database shell
	@docker compose exec postgres psql -U $(POSTGRES_USER) -d $(POSTGRES_DB)

# Django management
shell: ## Access Django shell
	@docker compose exec django python manage.py shell

collectstatic: ## Collect static files
	@docker compose exec django python manage.py collectstatic --noinput

# Testing
test: ## Run Django tests
	@docker compose exec django python manage.py test

test-vue: ## Run Vue tests
	@docker compose exec vue npm run test

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
	@docker compose exec vue npm update

# Security and maintenance
check-security: ## Run security checks
	@echo "Running Django security checks..."
	@docker compose exec django python manage.py check --deploy
	@echo "Running npm security audit..."
	@docker compose exec vue npm audit

update-requirements: ## Update Python requirements files
	@echo "Updating requirements..."
	@docker compose exec django pip freeze > server/requirements/current.txt

# Quick setup for new developers
setup: ## First-time setup for new developers
	@echo "Setting up Beis HaMikdash Management System..."
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