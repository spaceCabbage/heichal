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
- `make test-client` - Run Vue.js tests (Note: test runner not yet configured)
- `cd client && npm run lint` - Run ESLint on Vue.js code
- `cd client && npm run format` - Format Vue.js code with Prettier
- `make check-security` - Run security checks for Django and npm

### Logs & Debugging
- `make logs` - View all container logs
- `make logs-server` - View Django server logs only
- `make logs-client` - View Vue.js development server logs
- `make shell` - Access Django shell

## Architecture Overview

This is a **Heichal Management System** with a Django REST API backend and Vue.js frontend, designed to support Heichal operations.

### Tech Stack
- **Backend**: Django 5.2 with Django REST Framework
- **Frontend**: Vue.js 3 with Composition API, Vite, and Tailwind CSS v4
- **State Management**: Pinia with @pinia/colada for data fetching
- **HTTP Client**: Axios with CSRF token handling
- **Icons**: Phosphor Icons for Vue
- **Database**: PostgreSQL (SQLite for development)
- **Containerization**: Docker Compose with separate dev/prod configurations
- **Reverse Proxy**: Caddy (production only)

### Project Structure
```
heichal/
├── server/           # Django backend
│   ├── apps/api/     # API app with health and info endpoints
│   ├── core/         # Django settings and configuration
│   └── requirements/ # Python dependencies (base.txt, dev.txt, prod.txt)
├── client/           # Vue.js frontend
│   ├── src/
│   │   ├── api/      # API client setup and query functions
│   │   ├── components/ # Vue components (HealthStatus, ApiInfo)
│   │   └── views/    # Page components (HomeView)
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
- Current API endpoints:
  - `GET /api/health/` - Health check with database connectivity
  - `GET /api/info/` - API information and version details
- Admin interface at `/admin/`

### Current State
The project has a working foundation with:
- Functional Django API with health check and info endpoints
- Vue.js frontend displaying API status and information
- Proper API client setup with CSRF protection and error handling
- Pinia state management with data fetching capabilities
- Basic UI components and routing structure

The architecture is prepared for the comprehensive heichal management features outlined in the README.md.

### Environment Variables
Uses python-decouple for configuration management. Key variables include:
- `ENVIRONMENT` - Set to "dev" or "prod"
- `DATABASE_URL` - PostgreSQL connection string
- `DJANGO_SECRET_KEY` - Django secret key
- `CORS_ALLOWED_ORIGINS` - CORS configuration for production

### Authentication
Currently uses Django's session authentication. JWT authentication is prepared but commented out in settings.py.