# Backend Requirements - Shortcut Scale X

## Overview

A unified CRM system for recruitment and sales with AI-powered matching, vector search, and dual contact profiles. Built with Node.js/TypeScript, PostgreSQL with pgvector, and comprehensive API endpoints.

## Technology Stack

### Core Technologies

- **Runtime**: Node.js 18+ with TypeScript
- **Framework**: NestJS (Node.js framework with built-in TypeScript support)
- **Database**: PostgreSQL 15+ with pgvector extension
- **ORM**: TypeORM (NestJS integration) or Prisma
- **Authentication**: JWT with refresh tokens (@nestjs/jwt, @nestjs/passport)
- **Validation**: class-validator, class-transformer
- **Testing**: Jest with @nestjs/testing
- **Documentation**: OpenAPI/Swagger (@nestjs/swagger)

### AI & Vector Search

- **Vector Database**: pgvector extension for PostgreSQL
- **Embedding Model**: OpenAI text-embedding-3-small (1536 dimensions)
- **AI Services**: OpenAI API for embeddings and enrichment
- **Similarity Search**: Cosine similarity with configurable thresholds

### External Integrations

- **Communication**: Email (SMTP), WhatsApp Business API, LinkedIn API
- **File Storage**: AWS S3 or similar for attachments
- **Real-time**: WebSocket for live updates
- **Monitoring**: Winston for logging, Prometheus for metrics

## Phase 1: Foundation & Authentication (Week 1-2)

### 1.1 Project Setup

- [ ] Initialize NestJS project with TypeScript
- [ ] Set up NestJS CLI and project structure
- [ ] Configure environment variables (@nestjs/config)
- [ ] Set up database connection (TypeORM with PostgreSQL)
- [ ] Install and configure pgvector extension
- [ ] Set up TypeORM entities and migrations
- [ ] Configure logging (@nestjs/common Logger)
- [ ] Set up global exception filters and interceptors

### 1.2 Database Schema Implementation

- [ ] Create users table with role-based access
- [ ] Implement database migrations
- [ ] Set up database indexes for performance
- [ ] Create database triggers for updated_at timestamps
- [ ] Implement data validation constraints

### 1.3 Authentication System

- [ ] JWT strategy (@nestjs/jwt, @nestjs/passport)
- [ ] Refresh token mechanism with Redis
- [ ] Password hashing (bcrypt)
- [ ] Role-based guards (@nestjs/common Guards)
- [ ] Session management with Redis
- [ ] Password reset functionality

### 1.4 Basic API Structure

- [ ] Health check endpoint (@nestjs/terminus)
- [ ] API versioning with NestJS modules
- [ ] Request/response interceptors and pipes
- [ ] CORS configuration
- [ ] Rate limiting (@nestjs/throttler)
- [ ] API documentation setup (@nestjs/swagger)

## Phase 2: Core Contact Management (Week 3-4)

### 2.1 Contact System Foundation

- [ ] Implement clients table (organization/company info)
- [ ] Implement contacts table (base contact info)
- [ ] Create client_contacts table (many-to-many relationship)
- [ ] Create sales_profiles table (for contacts who buy from you)
- [ ] Create candidate_profiles table (for contacts who seek jobs)
- [ ] Implement contact_profile_audit_log
- [ ] Create contact_profile_summary view

### 2.2 Client API Endpoints

- [ ] GET /api/clients - List clients with filtering (ClientsController)
- [ ] POST /api/clients - Create client (ClientsService)
- [ ] GET /api/clients/:id - Get client details (ClientsController)
- [ ] PUT /api/clients/:id - Update client (ClientsService)
- [ ] DELETE /api/clients/:id - Delete client (ClientsService)
- [ ] GET /api/clients/:id/contacts - Get client contacts (ClientsService)
- [ ] GET /api/clients/:id/jobs - Get client jobs (ClientsService)
- [ ] GET /api/clients/:id/projects - Get client projects (ClientsService)

### 2.3 Contact API Endpoints

- [ ] GET /api/contacts - List contacts with filtering (ContactsController)
- [ ] POST /api/contacts - Create contact with profiles (ContactsService)
- [ ] GET /api/contacts/:id - Get contact details (ContactsController)
- [ ] PUT /api/contacts/:id - Update contact (ContactsService)
- [ ] DELETE /api/contacts/:id - Delete contact (ContactsService)
- [ ] POST /api/contacts/:id/sales-profile - Add sales profile (SalesProfilesService)
- [ ] POST /api/contacts/:id/candidate-profile - Add candidate profile (CandidateProfilesService)
- [ ] GET /api/contacts/:id/profiles - Get all profiles for contact (ContactsService)
- [ ] PUT /api/contacts/:id/client-relationships - Manage client relationships (ContactsService)

### 2.4 Client Business Logic

- [ ] Client organization management
- [ ] Client contact relationships
- [ ] Client assignment to users
- [ ] Client search and filtering
- [ ] Client validation and verification

### 2.5 Contact Business Logic

- [ ] Dual profile detection and management (sales + candidate)
- [ ] Primary profile logic (only one primary per type)
- [ ] Client-contact relationship management
- [ ] Contact assignment to users
- [ ] Contact search and filtering
- [ ] Contact validation (email format, phone format)
- [ ] Cross-profile insights (sales opportunities from candidates, etc.)

### 2.6 Client Profile Management

- [ ] Client organization CRUD operations
- [ ] Client contact management
- [ ] Client relationship tracking
- [ ] Client audit trail
- [ ] Client summary generation

### 2.7 Contact Profile Management

- [ ] Sales profile CRUD operations
- [ ] Candidate profile CRUD operations
- [ ] Profile switching (make primary)
- [ ] Profile audit trail
- [ ] Contact summary generation
- [ ] Dual profile analytics and insights

## Phase 3: Job & Recruitment System (Week 5-6)

### 3.1 Job Management

- [ ] Implement jobs table with vector embeddings
- [ ] Create job_applications table
- [ ] Create application_stages table
- [ ] Job CRUD operations
- [ ] Job status management

### 3.2 Job API Endpoints

- [ ] GET /api/jobs - List jobs with filtering
- [ ] POST /api/jobs - Create job
- [ ] GET /api/jobs/:id - Get job details
- [ ] PUT /api/jobs/:id - Update job
- [ ] DELETE /api/jobs/:id - Delete job
- [ ] POST /api/jobs/:id/close - Close job
- [ ] GET /api/jobs/board - Kanban board view

### 3.3 Application Tracking

- [ ] POST /api/applications - Create application
- [ ] GET /api/applications - List applications
- [ ] PUT /api/applications/:id - Update application
- [ ] POST /api/applications/:id/move-stage - Move through pipeline
- [ ] GET /api/applications/:id/timeline - Application history

### 3.4 Recruitment Analytics

- [ ] Basic recruitment metrics
- [ ] Pipeline conversion rates
- [ ] Time-to-fill calculations
- [ ] Recruiter performance tracking

## Phase 4: Sales CRM System (Week 7-8)

### 4.1 Sales Foundation

- [ ] Implement deals table
- [ ] Create deal_stage_history table
- [ ] Create projects table
- [ ] Create project_team_members table
- [ ] Create sales_activities table

### 4.2 Sales Pipeline Management

- [ ] Create sales_pipelines table
- [ ] Create pipeline_stages table
- [ ] Pipeline CRUD operations
- [ ] Stage management and ordering

### 4.3 Deal Management

- [ ] GET /api/deals - List deals with filtering
- [ ] POST /api/deals - Create deal
- [ ] PUT /api/deals/:id - Update deal
- [ ] POST /api/deals/:id/move-stage - Move deal stage
- [ ] GET /api/deals/board - Sales board view

### 4.4 Project Management

- [ ] GET /api/projects - List projects
- [ ] POST /api/projects - Create project
- [ ] PUT /api/projects/:id - Update project
- [ ] Project team management
- [ ] Project timeline tracking

### 4.5 Sales Activities

- [ ] GET /api/sales-activities - List activities
- [ ] POST /api/sales-activities - Create activity
- [ ] PUT /api/sales-activities/:id/complete - Complete activity
- [ ] Activity scheduling and reminders

## Phase 5: AI & Vector Search (Week 9-10)

### 5.1 Vector Database Setup

- [ ] Configure pgvector extension
- [ ] Create vector similarity indexes
- [ ] Set up embedding generation pipeline
- [ ] Implement vector search utilities

### 5.2 AI Integration

- [ ] OpenAI API integration
- [ ] Embedding generation service
- [ ] Vector similarity search
- [ ] Contact enrichment service

### 5.3 AI API Endpoints

- [ ] POST /api/ai/vector-match-candidates - Match candidates to jobs
- [ ] POST /api/ai/vector-match-jobs - Match jobs to candidates
- [ ] POST /api/ai/update-embeddings - Update embeddings
- [ ] POST /api/ai/enrich-contact - Enrich contact data
- [ ] POST /api/ai/lead-scoring - Score leads

### 5.4 Matching Algorithm

- [ ] Skills-based matching
- [ ] Experience level matching
- [ ] Salary range matching
- [ ] Location-based filtering
- [ ] Availability matching

## Phase 6: Communication System (Week 11-12)

### 6.1 Communication Foundation

- [ ] Implement communications table
- [ ] Create communication_templates table
- [ ] Communication status tracking
- [ ] External platform integration

### 6.2 Communication API

- [ ] GET /api/communications - List communications
- [ ] POST /api/communications - Send communication
- [ ] PUT /api/communications/:id - Update communication
- [ ] GET /api/communications/templates - List templates

### 6.3 External Integrations

- [ ] Email integration (SMTP)
- [ ] WhatsApp Business API
- [ ] LinkedIn API
- [ ] Communication scheduling
- [ ] Delivery status tracking

### 6.4 Template System

- [ ] Template CRUD operations
- [ ] Variable substitution
- [ ] Template categories
- [ ] Template analytics

## Phase 7: Advanced Features (Week 13-14)

### 7.1 Real-time Updates

- [ ] WebSocket implementation
- [ ] Real-time notifications
- [ ] Live dashboard updates
- [ ] Activity feeds

### 7.2 Advanced Analytics

- [ ] Comprehensive reporting
- [ ] Data visualization endpoints
- [ ] Export functionality (CSV, PDF)
- [ ] Custom dashboard metrics

### 7.3 Performance Optimization

- [ ] Database query optimization
- [ ] Caching layer (Redis)
- [ ] API response optimization
- [ ] Background job processing

### 7.4 Security Enhancements

- [ ] API rate limiting
- [ ] Input sanitization
- [ ] SQL injection prevention
- [ ] Audit logging

## Phase 8: Testing & Deployment (Week 15-16)

### 8.1 Testing

- [ ] Unit tests for all services
- [ ] Integration tests for API endpoints
- [ ] Database migration tests
- [ ] Performance testing
- [ ] Security testing

### 8.2 Documentation

- [ ] API documentation (OpenAPI)
- [ ] Database schema documentation
- [ ] Deployment guide
- [ ] User manual

### 8.3 Deployment

- [ ] Docker containerization
- [ ] CI/CD pipeline setup
- [ ] Environment configuration
- [ ] Monitoring and alerting

## Database Schema Implementation Priority

### High Priority (Phase 1-2)

1. users
2. clients
3. contacts
4. client_profiles
5. candidate_profiles
6. contact_profile_audit_log

### Medium Priority (Phase 3-4)

1. jobs
2. job_applications
3. application_stages
4. deals
5. projects
6. sales_activities

### Low Priority (Phase 5-6)

1. communications
2. communication_templates
3. sales_pipelines
4. pipeline_stages

## API Endpoints Implementation Order

### Phase 1: Authentication

- POST /api/auth/login
- POST /api/auth/refresh
- POST /api/auth/logout
- GET /api/auth/me

### Phase 2: Clients & Contacts

- GET /api/clients
- POST /api/clients
- GET /api/clients/:id
- PUT /api/clients/:id
- DELETE /api/clients/:id
- GET /api/contacts
- POST /api/contacts
- GET /api/contacts/:id
- PUT /api/contacts/:id
- DELETE /api/contacts/:id

### Phase 3: Jobs & Applications

- GET /api/jobs
- POST /api/jobs
- GET /api/jobs/:id
- GET /api/applications
- POST /api/applications

### Phase 4: Sales CRM

- GET /api/deals
- POST /api/deals
- GET /api/projects
- POST /api/projects
- GET /api/sales-activities

### Phase 5: AI & Matching

- POST /api/ai/vector-match-candidates
- POST /api/ai/vector-match-jobs
- POST /api/ai/update-embeddings

### Phase 6: Communication

- GET /api/communications
- POST /api/communications
- GET /api/communications/templates

## Technical Considerations

### Performance

- Database indexing strategy
- Query optimization
- Caching strategy
- Pagination for large datasets
- Background job processing

### Scalability

- Horizontal scaling preparation
- Database sharding strategy
- Microservices architecture consideration
- Load balancing

### Security

- Input validation
- SQL injection prevention
- XSS protection
- CSRF protection
- Rate limiting
- Audit logging

### Monitoring

- Application metrics
- Database performance monitoring
- Error tracking
- User activity logging
- API usage analytics

## Success Metrics

### Technical Metrics

- API response time < 200ms
- Database query performance
- 99.9% uptime
- Zero security vulnerabilities

### Business Metrics

- User adoption rate
- Feature usage statistics
- System performance under load
- User satisfaction scores

## Risk Mitigation

### Technical Risks

- Database performance issues
- Vector search accuracy
- External API dependencies
- Data migration complexity

### Business Risks

- User adoption challenges
- Feature scope creep
- Integration complexity
- Timeline delays

## Future Enhancements

### Phase 9+ Considerations

- Mobile API endpoints
- Advanced AI features
- Third-party integrations
- Advanced analytics
- Multi-tenant architecture
- Internationalization
