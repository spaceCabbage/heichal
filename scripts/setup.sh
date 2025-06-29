#!/bin/bash

# Beis HaMikdash Management System - Setup Script
# This script helps new developers get started quickly

set -e  # Exit on any error

echo "🏛️  Beis HaMikdash Management System Setup"
echo "========================================"

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker and Docker Compose first."
    echo "Visit: https://docs.docker.com/get-docker/"
    exit 1
fi

# Check if Docker Compose is available
if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null; then
    echo "❌ Docker Compose is not available. Please install Docker Compose."
    exit 1
fi

# Create .env file if it doesn't exist
if [ ! -f .env ]; then
    echo "📝 Creating .env file from template..."
    cp .env.example .env
    
    # Generate random secret keys
    echo "🔐 Generating secure secret keys..."
    
    if command -v openssl &> /dev/null; then
        DJANGO_SECRET=$(openssl rand -base64 32)
        JWT_SECRET=$(openssl rand -base64 32)
        
        # Replace placeholder keys in .env file
        if [[ "$OSTYPE" == "darwin"* ]]; then
            # macOS
            sed -i '' "s/your-super-secret-django-key-generate-a-new-one-please/$DJANGO_SECRET/" .env
            sed -i '' "s/another-super-secret-key-for-jwt-tokens/$JWT_SECRET/" .env
        else
            # Linux
            sed -i "s/your-super-secret-django-key-generate-a-new-one-please/$DJANGO_SECRET/" .env
            sed -i "s/another-super-secret-key-for-jwt-tokens/$JWT_SECRET/" .env
        fi
        
        echo "✅ Secret keys generated and updated in .env file"
    else
        echo "⚠️  OpenSSL not found. Please manually update the secret keys in .env file"
    fi
    
    echo ""
    echo "📋 Please review and update the .env file with your specific configuration:"
    echo "   - Database password"
    echo "   - Email settings (if needed)"
    echo "   - Domain name (for production)"
    echo ""
    read -p "Press Enter to continue after reviewing .env file..."
else
    echo "✅ .env file already exists"
fi

# Check which environment to set up
ENVIRONMENT=$(grep "^ENVIRONMENT=" .env | cut -d '=' -f2)
echo "🔧 Setting up for environment: $ENVIRONMENT"

# Build Docker images
echo "🐳 Building Docker images..."
docker compose build

# Start the services
echo "🚀 Starting services..."
if [ "$ENVIRONMENT" = "prod" ]; then
    docker compose -f docker-compose.yml -f docker-compose.prod.yml --profile prod up -d
else
    docker compose -f docker-compose.yml -f docker-compose.dev.yml up -d
fi

# Wait for database to be ready
echo "⏳ Waiting for database to be ready..."
sleep 15

# Run database migrations
echo "📊 Running database migrations..."
docker compose exec django python manage.py migrate

# Create directories for media files
echo "📁 Setting up media directories..."
docker compose exec django mkdir -p media/profiles media/documents media/images

# Collect static files (for production)
if [ "$ENVIRONMENT" = "prod" ]; then
    echo "📦 Collecting static files..."
    docker compose exec django python manage.py collectstatic --noinput
fi

# Check if services are running
echo "🔍 Checking service health..."
sleep 5

# Test Django
if curl -f http://localhost:8000/admin/ &> /dev/null; then
    echo "✅ Django is running"
else
    echo "❌ Django is not responding"
fi

# Test Vue (dev mode only)
if [ "$ENVIRONMENT" = "dev" ]; then
    if curl -f http://localhost:3000/ &> /dev/null; then
        echo "✅ Vue.js dev server is running"
    else
        echo "❌ Vue.js dev server is not responding"
    fi
fi

# Test PostgreSQL
if docker compose exec postgres pg_isready -U $(grep POSTGRES_USER .env | cut -d '=' -f2) &> /dev/null; then
    echo "✅ PostgreSQL is running"
else
    echo "❌ PostgreSQL is not responding"
fi

echo ""
echo "🎉 Setup complete!"
echo ""
echo "📋 Next steps:"
echo "   1. Create a superuser: docker compose exec django python manage.py createsuperuser"
echo "   2. Access the application:"

if [ "$ENVIRONMENT" = "dev" ]; then
    echo "      - Frontend (Vue): http://localhost:3000"
    echo "      - Backend API: http://localhost:8000/api"
    echo "      - Django Admin: http://localhost:8000/admin"
else
    echo "      - Application: http://localhost (or your domain)"
    echo "      - Django Admin: http://localhost/admin"
fi

echo "   3. View logs: docker compose logs -f"
echo "   4. Stop services: docker compose down"
echo ""
echo "🔧 Development commands:"
echo "   - make dev      # Start development environment"
echo "   - make logs     # View logs"
echo "   - make shell    # Access Django shell"
echo "   - make migrate  # Run migrations"
echo "   - make test     # Run tests"
echo ""
echo "📚 For more commands, run: make help"
echo ""
echo "May the Third Beis HaMikdash be built speedily in our days! 🏛️"