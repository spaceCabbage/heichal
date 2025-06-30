# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Commands

### Environment Setup
- `make setup` - Complete first-time setup for new developers
- `make dev` - Start development environment with hot reload
- `make dev-d` - Start development environment in detached mode
- `make prod` - Start production environment
- `make deploy-prod` - Full production deployment

### Database Operations
- `make migrate` - Run Django migrations
- `make makemigrations` - Create new Django migrations
- `make createsuperuser` - Create Django admin superuser
- `make dbshell` - Access PostgreSQL database shell

### Testing & Quality
- `make test` - Run Django tests
- `make test-client` - Run Vue.js tests (via `npm run test`)
- `cd client && npm run lint` - Run ESLint on Vue.js code
- `cd client && npm run format` - Format Vue.js code with Prettier
- `make check-security` - Run security checks for Django and npm

### Logs & Debugging
- `make logs` - View all container logs
- `make logs-server` - View Django server logs only
- `make logs-client` - View Vue.js development server logs
- `make shell` - Access Django shell

## Architecture Overview

This is a **Temple Management System** with a Django REST API backend and Vue.js frontend, designed to support Third Temple operations.

### Tech Stack
- **Backend**: Django 5.2 with Django REST Framework
- **Frontend**: Vue.js 3 with Composition API, Vite, and Tailwind CSS
- **Database**: PostgreSQL (SQLite for development)
- **Containerization**: Docker Compose with separate dev/prod configurations
- **Reverse Proxy**: Caddy (production only)

### Project Structure
```
temple/
├── server/           # Django backend
│   ├── apps/         # Django apps (currently empty, ready for development)
│   ├── core/         # Django settings and configuration
│   └── requirements/ # Python dependencies (base.txt, dev.txt, prod.txt)
├── client/           # Vue.js frontend
│   ├── src/          # Vue.js source code
│   └── package.json  # Node.js dependencies and scripts
├── docker/           # Docker configurations for different services
├── scripts/          # Utility scripts
└── Makefile          # Development commands
```

### Key Configuration Files
- **server/core/settings.py**: Django settings with environment-based configuration
- **client/vite.config.js**: Vite configuration for Vue.js development
- **docker-compose.yml**: Base Docker Compose configuration
- **docker-compose.dev.yml**: Development overrides (Vite dev server)
- **docker-compose.prod.yml**: Production overrides (Caddy reverse proxy)

### Development vs Production
- **Development**: Uses Vite dev server (port 3000) with hot reload, Django debug mode
- **Production**: Uses Caddy to serve built Vue.js files and proxy to Django (port 8000)

### API Documentation
- Django REST Framework with drf-spectacular for OpenAPI/Swagger documentation
- API endpoints available at `/api/`
- Admin interface at `/admin/`

### Current State
The project is in early development phase with basic Django and Vue.js setup. The architecture is prepared for the comprehensive temple management features outlined in the README.md, but most application logic is yet to be implemented.

### Environment Variables
Uses python-decouple for configuration management. Key variables include:
- `ENVIRONMENT` - Set to "dev" or "prod"
- `DATABASE_URL` - PostgreSQL connection string
- `DJANGO_SECRET_KEY` - Django secret key
- `CORS_ALLOWED_ORIGINS` - CORS configuration for production

### Authentication
Currently uses Django's session authentication. JWT authentication is prepared but commented out in settings.py.