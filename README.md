# Temple Management System
An all-in-one digital platform to support the daily operations, scheduling, and management of the Third Temple, serving Cohanim, Leviim, and the Jewish people worldwide.


- [Temple Management System](#temple-management-system)
- [🚀 Installation \& Setup](#-installation--setup)
  - [Prerequisites](#prerequisites)
  - [Quick Start](#quick-start)
  - [Development vs Production](#development-vs-production)
  - [Quick Commands with Makefile](#quick-commands-with-makefile)
- [🏗️ Architecture](#️-architecture)
  - [📋 Core Features](#-core-features)
  - [🛠️ Technical Implementation Options](#️-technical-implementation-options)
  - [📦 Project Structure](#-project-structure)
- [📋 Detailed Development Roadmap](#-detailed-development-roadmap)
  - [🏗️ Phase 1: Foundation \& Core Authentication (Weeks 1-4)](#️-phase-1-foundation--core-authentication-weeks-1-4)
  - [📅 Phase 2: Korban Management System (Weeks 5-10)](#-phase-2-korban-management-system-weeks-5-10)
  - [👥 Phase 3: Staff Management (Weeks 11-16)](#-phase-3-staff-management-weeks-11-16)
  - [🏛️ Phase 4: Temple Operations (Weeks 17-22)](#️-phase-4-temple-operations-weeks-17-22)
  - [🌐 Phase 5: Public Interface \& Analytics (Weeks 23-28)](#-phase-5-public-interface--analytics-weeks-23-28)
  - [🚀 Phase 6: Advanced Features \& Optimization (Weeks 29-36)](#-phase-6-advanced-features--optimization-weeks-29-36)
  - [🎯 Success Milestones](#-success-milestones)
  - [📊 Priority Matrix](#-priority-matrix)



# 🚀 Installation & Setup

## Prerequisites
- Docker and Docker Compose
- Git

## Quick Start
```bash
# 1. Clone the repository
git clone <repository-url>
cd temple

# 2. Copy environment file and configure
cp .env.example .env

# 3. Start the application
docker compose up --build

# 4. Initialize the database (first run only)
docker compose exec django python manage.py migrate
docker compose exec django python manage.py createsuperuser

# 5. Access the application
# Frontend: http://localhost:3000 (dev) or http://localhost (prod)
# API: http://localhost:8000/api
# Admin: http://localhost:8000/admin
```

## Development vs Production

**Development Mode** (`ENVIRONMENT=dev`):
- Vue.js runs with Vite dev server (hot reload)
- Django runs with debug mode and auto-reload
- Database accessible on localhost:5432
- No SSL, no reverse proxy complexity

**Production Mode** (`ENVIRONMENT=prod`):
- Vue.js built and served by Caddy
- Django runs with gunicorn
- Caddy handles SSL and reverse proxy
- Optimized builds and caching

## Quick Commands with Makefile

```bash
# First-time setup
make setup              # Complete setup for new developers
make createsuperuser    # Create admin user

# Development
make dev                # Start development environment
make dev-d              # Start development (detached)
make logs               # View all logs
make logs-django        # View Django logs only

# Production  
make prod               # Start production environment
make deploy-prod        # Full production deployment

# Database operations
make migrate            # Run migrations
make makemigrations     # Create new migrations
make dbshell           # Access database

# Utilities
make test              # Run tests
make clean             # Clean up containers
make backup-db         # Backup database
```




# 🏗️ Architecture

- **Backend**: Django (Python) with REST API (`/server`)
- **Frontend**: Vue.js 3 with TypeScript + Vite (`/client`)
- **Database**: PostgreSQL
- **Reverse Proxy**: Caddy (SSL termination, static file serving)
- **Styling**: Tailwind CSS + Phosphor Icons
- **Deployment**: Docker Compose (dev/prod modes via .env)
- **Routing**: 
  - `/` - Vue.js SPA (served by Caddy in prod, Vite in dev)
  - `/api/*` - Django REST API endpoints
  - `/admin/*` - Django admin interface

## 📋 Core Features

### 🕍 Public Landing Page (Vue.js)
- [ ] Temple information and history
- [ ] Current events and announcements
- [ ] Live streaming of services
- [ ] Visitor information and guidelines
- [ ] Educational content about Temple service
- [ ] Donation portal
- [ ] Multi-language support (Hebrew, English, Aramaic)
- [ ] Accessibility compliance
- [ ] SEO optimization with meta tags
- [ ] Contact information and directions

### 🗓️ Korban Scheduling System
- [ ] Public korban reservation system
- [ ] Personal korban calendar
- [ ] Korban type selection (Olah, Shelamim, Chatat, etc.)
- [ ] Pricing and payment integration
- [ ] Availability checking against Cohen schedules
- [ ] Automatic conflict resolution
- [ ] Korban preparation reminders
- [ ] Special occasion scheduling (holidays, lifecycle events)
- [ ] Group korban coordination
- [ ] Korban status tracking
- [ ] Digital receipts and certificates
- [ ] Korban history and analytics

### 👥 User Management & Authentication
- [ ] Role-based access control (Cohen Gadol, Cohanim, Leviim, Yisraelim)
- [ ] Tribal verification system
- [ ] Two-factor authentication
- [ ] LDAP/Active Directory integration
- [ ] User profiles with spiritual lineage
- [ ] Permission inheritance by priestly courses (Mishmarot)
- [ ] Session management
- [ ] Account recovery system
- [ ] User activity logging
- [ ] Profile photo management

### 👨‍💼 Cohen Management Portal
- [ ] Shift scheduling and assignments
- [ ] Mishmar (priestly course) rotation management
- [ ] Cohen availability calendar
- [ ] Training and certification tracking
- [ ] Performance evaluations
- [ ] Purity status tracking (Tumah/Taharah)
- [ ] Emergency contact information
- [ ] Uniform and equipment tracking
- [ ] Cohen genealogy verification
- [ ] Duty assignment notifications
- [ ] Backup Cohen assignments
- [ ] Cohen skill specialization tracking

### 🎵 Levi Management Portal
- [ ] Musical service scheduling
- [ ] Instrument assignment and maintenance
- [ ] Choir practice coordination
- [ ] Song and melody database
- [ ] Voice part assignments
- [ ] Performance quality tracking
- [ ] Music theory resources
- [ ] Audio/video practice materials
- [ ] Temple music archives
- [ ] Guest musician coordination
- [ ] Sound system management
- [ ] Rehearsal room booking

### 📅 Temple Calendar & Events
- [ ] Hebrew calendar integration
- [ ] Holiday and festival scheduling
- [ ] Special service planning
- [ ] Event capacity management
- [ ] Weather contingency planning
- [ ] Rosh Chodesh and special date calculations
- [ ] Sabbatical and Jubilee year tracking
- [ ] Astronomical calculations for timing
- [ ] Multi-timezone support for diaspora
- [ ] Event registration system
- [ ] VIP and delegation management
- [ ] Media coverage coordination

### 🐄 Animal Management System
- [ ] Livestock inventory tracking
- [ ] Animal health records
- [ ] Breeding program management
- [ ] Feed scheduling and nutrition
- [ ] Veterinary appointment tracking
- [ ] Animal identification (RFID/tags)
- [ ] Quarantine management
- [ ] Animal fitness for sacrifice verification
- [ ] Procurement and sourcing
- [ ] Red heifer program management
- [ ] Parah Adumah preparation tracking
- [ ] Animal transportation logistics

### 🏪 Inventory & Supplies
- [ ] Sacred vessel tracking (Keilim)
- [ ] Clothing and vestment management
- [ ] Incense and oil inventory
- [ ] Food supplies for offerings
- [ ] Maintenance supplies tracking
- [ ] Vendor management
- [ ] Purchase order system
- [ ] Asset depreciation tracking
- [ ] Emergency supply planning
- [ ] Quality control documentation
- [ ] Storage location mapping
- [ ] Automated reorder points

### 💰 Financial Management
- [ ] Donation tracking and receipts
- [ ] Korban payment processing
- [ ] Half-shekel collection system
- [ ] Budget planning and reporting
- [ ] Expense categorization
- [ ] Financial audit trails
- [ ] Multi-currency support
- [ ] Automated accounting integration
- [ ] Tax compliance reporting
- [ ] Fraud detection
- [ ] Treasurer dashboard
- [ ] Financial forecasting

### 🔄 Temple Operations
- [ ] Daily service checklist systems
- [ ] Equipment maintenance scheduling
- [ ] Cleaning and preparation workflows
- [ ] Security system integration
- [ ] Visitor flow management
- [ ] Emergency response procedures
- [ ] Utility monitoring (water, electricity)
- [ ] Temperature and climate control
- [ ] Waste management tracking
- [ ] Construction project management
- [ ] Facility inspection logging
- [ ] Compliance monitoring

### 📊 Analytics & Reporting
- [ ] Service attendance analytics
- [ ] Korban statistics and trends
- [ ] Financial reporting dashboards
- [ ] Staff performance metrics
- [ ] Visitor demographics
- [ ] Seasonal trend analysis
- [ ] Resource utilization reports
- [ ] Predictive maintenance alerts
- [ ] Custom report builder
- [ ] Data export capabilities
- [ ] Business intelligence integration
- [ ] Historical data analysis

### 🔔 Notification System
- [ ] SMS and email notifications
- [ ] Push notifications for mobile app
- [ ] Emergency broadcast system
- [ ] Automated reminder system
- [ ] Multi-language notification support
- [ ] Notification preference management
- [ ] Integration with external systems
- [ ] Delivery confirmation tracking
- [ ] Message templating system
- [ ] Escalation procedures
- [ ] Silent/priority notification modes
- [ ] Notification analytics

### 📱 Mobile Integration
- [ ] Progressive Web App (PWA)
- [ ] Native mobile app support
- [ ] Offline functionality
- [ ] GPS integration for pilgrimage
- [ ] QR code scanning for identification
- [ ] Mobile payment integration
- [ ] Camera integration for documentation
- [ ] Biometric authentication
- [ ] Voice commands (Hebrew/Aramaic)
- [ ] Augmented reality features
- [ ] Digital compass for prayer direction
- [ ] Location-based services

### 🔐 Security & Compliance
- [ ] Audit logging system
- [ ] Data encryption at rest and in transit
- [ ] GDPR compliance tools
- [ ] Backup and disaster recovery
- [ ] Access control monitoring
- [ ] Security incident tracking
- [ ] Penetration testing integration
- [ ] Compliance reporting
- [ ] Data retention policies
- [ ] Privacy controls
- [ ] Security awareness training
- [ ] Vulnerability scanning

### 🌐 Integration Capabilities
- [ ] Jewish calendar APIs
- [ ] Weather service integration
- [ ] Banking and payment gateways
- [ ] Government registry systems
- [ ] Genealogy database connections
- [ ] Educational institution links
- [ ] Diaspora community portals
- [ ] Broadcasting system integration
- [ ] Social media automation
- [ ] Email marketing platforms
- [ ] CRM system integration
- [ ] Document management systems

## 🛠️ Technical Implementation Options

### Database Design
- **PostgreSQL** with custom schemas for:
  - User management and roles
  - Scheduling and calendar data
  - Inventory and asset tracking
  - Financial transactions
  - Audit logs and compliance

### Authentication & Authorization
- **Option 1**: Django's built-in auth with custom user model
- **Option 2**: JWT tokens with refresh rotation
- **Option 3**: OAuth2 integration with external providers
- **Option 4**: SAML for enterprise integration

### Frontend Architecture
- **Option 1**: Vue 3 with Composition API and Pinia
- **Option 2**: Nuxt.js for better SSR/SEO
- **Option 3**: Micro-frontend architecture for modularity

### Real-time Features
- **Option 1**: WebSocket implementation with Django Channels
- **Option 2**: Server-Sent Events for notifications
- **Option 3**: Real-time database with Firebase integration

### Payment Processing
- **Option 1**: Stripe integration with multi-currency
- **Option 2**: PayPal for international donations
- **Option 3**: Cryptocurrency payment options
- **Option 4**: Traditional banking integration for Israel

### Deployment Strategy
- **Option 1**: Single Docker container (current plan)
- **Option 2**: Docker Compose with separate services
- **Option 3**: Kubernetes deployment for scalability
- **Option 4**: Serverless architecture with AWS Lambda

## 📦 Project Structure

```
temple/
├── server/                     # Django application
│   ├── apps/
│   │   ├── authentication/     # User management & JWT auth
│   │   ├── scheduling/         # Korban and staff scheduling
│   │   ├── inventory/          # Asset and supply management
│   │   ├── financial/          # Payment and donation tracking
│   │   ├── operations/         # Daily operations management
│   │   └── analytics/          # Reporting and analytics
│   ├── core/                   # Django settings and shared utilities
│   ├── requirements/           # Dev/prod requirements
│   └── manage.py
├── client/                     # Vue.js application
│   ├── src/
│   │   ├── components/         # Reusable Vue components
│   │   ├── views/              # Page components
│   │   ├── stores/             # Pinia state management
│   │   ├── services/           # API integration
│   │   ├── router/             # Vue Router setup
│   │   └── utils/              # Helper functions
│   ├── public/                 # Static assets
│   ├── package.json
│   ├── vite.config.ts
│   └── tailwind.config.js
├── docker/                     # Docker configurations
│   ├── caddy/
│   │   └── Caddyfile
│   ├── django/
│   │   ├── Dockerfile.dev
│   │   └── Dockerfile.prod
│   └── vue/
│       ├── Dockerfile.dev
│       └── Dockerfile.prod
├── docs/                       # Documentation
├── scripts/                    # Deployment and utility scripts
├── .env.example               # Environment variables template
├── docker-compose.yml         # Main compose file
├── docker-compose.dev.yml     # Dev overrides
├── docker-compose.prod.yml    # Prod overrides
└── README.md
```


# 📋 Detailed Development Roadmap

## 🏗️ Phase 1: Foundation & Core Authentication (Weeks 1-4)
**Goal**: Basic system infrastructure and user management

### Week 1: Project Setup
- [ ] Docker compose configuration (dev/prod modes)
- [ ] Django project setup with apps structure
- [ ] Vue.js project setup with Vite, Tailwind, Phosphor Icons
- [ ] PostgreSQL integration
- [ ] Basic CI/CD pipeline

### Week 2: Authentication System
- [ ] Custom User model with roles (Cohen, Levi, Yisrael)
- [ ] JWT authentication endpoints
- [ ] User registration/login Vue components
- [ ] Role-based middleware and permissions
- [ ] Basic user profile management

### Week 3: Core Models & API
- [ ] User profile models (tribal lineage, contact info)
- [ ] Basic korban models (types, scheduling)
- [ ] REST API endpoints with Django REST Framework
- [ ] API documentation with Swagger/OpenAPI
- [ ] Basic error handling and validation

### Week 4: Frontend Foundation
- [ ] Vue Router setup with auth guards
- [ ] Pinia stores for auth and user state
- [ ] Base layout components with navigation
- [ ] Responsive design with Tailwind
- [ ] API service layer with axios

## 📅 Phase 2: Korban Management System (Weeks 5-10)
**Goal**: Complete korban scheduling and management

### Week 5-6: Korban Scheduling Core
- [ ] Korban type models (Olah, Shelamim, Chatat, etc.)
- [ ] Calendar integration with Hebrew dates
- [ ] Basic scheduling algorithm
- [ ] Availability checking system
- [ ] Conflict resolution logic

### Week 7-8: User Korban Interface
- [ ] Korban booking interface for public users
- [ ] Calendar component with availability display
- [ ] Korban type selection with pricing
- [ ] Booking confirmation and receipt system
- [ ] Personal korban history dashboard

### Week 9-10: Advanced Scheduling
- [ ] Recurring korban appointments
- [ ] Group korban coordination
- [ ] Holiday and special occasion handling
- [ ] Automated reminders system
- [ ] Korban modification and cancellation

## 👥 Phase 3: Staff Management (Weeks 11-16)
**Goal**: Cohen and Levi management portals

### Week 11-12: Cohen Management
- [ ] Cohen-specific user profiles
- [ ] Mishmar (priestly course) models and assignments
- [ ] Cohen availability calendar
- [ ] Shift scheduling system
- [ ] Purity status tracking

### Week 13-14: Levi Management  
- [ ] Levi-specific profiles and roles
- [ ] Musical service scheduling
- [ ] Instrument and choir management
- [ ] Practice session coordination
- [ ] Performance tracking

### Week 15-16: Staff Coordination
- [ ] Cross-functional scheduling (Cohen + Levi coordination)
- [ ] Emergency coverage system
- [ ] Staff communication tools
- [ ] Performance evaluation system
- [ ] Training and certification tracking

## 🏛️ Phase 4: Temple Operations (Weeks 17-22)
**Goal**: Daily operations and resource management

### Week 17-18: Inventory Management
- [ ] Sacred vessel tracking (Keilim)
- [ ] Clothing and vestment management
- [ ] Supply inventory with automated reordering
- [ ] Asset maintenance scheduling
- [ ] Vendor and procurement management

### Week 19-20: Financial System
- [ ] Payment processing integration
- [ ] Donation tracking and receipts
- [ ] Budget management
- [ ] Financial reporting dashboard
- [ ] Multi-currency support

### Week 21-22: Operations Dashboard
- [ ] Daily operations checklist
- [ ] Facility maintenance tracking
- [ ] Emergency procedures system
- [ ] Visitor management
- [ ] Security integration prep

## 🌐 Phase 5: Public Interface & Analytics (Weeks 23-28)
**Goal**: Public-facing features and system intelligence

### Week 23-24: Landing Page & Public Features
- [ ] Modern landing page with temple information
- [ ] Educational content management
- [ ] Event calendar for public
- [ ] Multi-language support (Hebrew, English)
- [ ] SEO optimization

### Week 25-26: Analytics & Reporting
- [ ] User behavior analytics
- [ ] Korban statistics and trends
- [ ] Staff performance metrics
- [ ] Financial reporting
- [ ] Custom report builder

### Week 27-28: Mobile & PWA
- [ ] Progressive Web App setup
- [ ] Mobile-responsive design refinement
- [ ] Offline functionality for critical features
- [ ] Push notifications
- [ ] Mobile-specific features

## 🚀 Phase 6: Advanced Features & Optimization (Weeks 29-36)
**Goal**: Advanced functionality and system optimization

### Week 29-30: Real-time Features
- [ ] WebSocket integration for live updates
- [ ] Real-time notifications system
- [ ] Live chat/messaging for staff
- [ ] Real-time dashboard updates
- [ ] Event broadcasting system

### Week 31-32: Integration & Automation
- [ ] External calendar integration
- [ ] Email marketing automation
- [ ] SMS notification system
- [ ] Weather service integration
- [ ] Banking/payment gateway integration

### Week 33-34: Security & Compliance
- [ ] Advanced security audit
- [ ] Data encryption implementation
- [ ] Backup and disaster recovery
- [ ] GDPR compliance features
- [ ] Security monitoring dashboard

### Week 35-36: Performance & Scalability
- [ ] Database optimization
- [ ] Caching layer implementation
- [ ] Load testing and optimization
- [ ] CDN integration
- [ ] Performance monitoring

## 🎯 Success Milestones

- **End of Phase 1**: Users can register, login, and basic system is operational
- **End of Phase 2**: Public can book korbanos, system handles scheduling
- **End of Phase 3**: Staff can manage their schedules and duties
- **End of Phase 4**: Complete operational management system
- **End of Phase 5**: Public-facing website with analytics
- **End of Phase 6**: Production-ready, scalable system

## 📊 Priority Matrix

**Must Have (Phase 1-3)**:
- User authentication and roles
- Korban scheduling and booking
- Staff schedule management
- Basic payment processing

**Should Have (Phase 4-5)**:
- Inventory management
- Public landing page
- Analytics and reporting
- Mobile optimization

**Could Have (Phase 6+)**:
- Real-time features
- Advanced integrations
- AI/ML capabilities
- Advanced analytics

---

**Note**: This system is designed to support the operations of the Third Temple when it is rebuilt, may it be speedily in our days. Until then, it serves as a comprehensive planning and educational tool.

*"And let them make Me a sanctuary, that I may dwell among them" - Exodus 25:8*