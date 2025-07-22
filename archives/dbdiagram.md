# Database ERD Commands for dbdiagram.io

Copy and paste the following commands into [dbdiagram.io](https://dbdiagram.io) to generate the Entity Relationship Diagram for your Recruitment & Sales CRM system.

```sql
// Users & Authentication
Table users {
  id integer [primary key, increment]
  email varchar(255) [unique, not null]
  password_hash varchar(255) [not null]
  first_name varchar(100) [not null]
  last_name varchar(100) [not null]
  role varchar(20) [not null, default: 'user']
  is_active boolean [default: true]
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]
}

Table user_sessions {
  id integer [primary key, increment]
  user_id integer [ref: > users.id, not null]
  session_token varchar(255) [unique, not null]
  expires_at timestamp [not null]
  created_at timestamp [default: `now()`]
}

// Companies
Table companies {
  id integer [primary key, increment]
  name varchar(200) [not null]
  industry varchar(100)
  size varchar(50)
  location varchar(200)
  website varchar(255)
  description text
  status varchar(20) [default: 'active']
  assigned_user_id integer [ref: > users.id]
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]
}

// Contacts
Table contacts {
  id integer [primary key, increment]
  first_name varchar(100) [not null]
  last_name varchar(100) [not null]
  email varchar(255)
  phone varchar(50)
  location varchar(200)
  skills text[]
  experience_years integer
  availability_status varchar(20) [default: 'available']
  salary_expectations_min integer
  salary_expectations_max integer
  source varchar(100)
  assigned_user_id integer [ref: > users.id]
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]
}

// Contact Embeddings for AI
Table contact_embeddings {
  id integer [primary key, increment]
  contact_id integer [ref: > contacts.id, not null]
  embedding_vector vector(384)
  created_at timestamp [default: `now()`]
}

// Contact Job History
Table contact_job_history {
  id integer [primary key, increment]
  contact_id integer [ref: > contacts.id, not null]
  company_name varchar(200) [not null]
  job_title varchar(200) [not null]
  start_date date
  end_date date
  is_current_job boolean [default: false]
  location varchar(200)
  description text
  responsibilities text[]
  skills_used text[]
  salary_min integer
  salary_max integer
  currency varchar(3) [default: 'USD']
  reason_for_leaving varchar(500)
  supervisor_name varchar(200)
  supervisor_contact varchar(255)
  achievements text[]
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]
}

// Client Profiles (Sales Relationships)
Table client_profiles {
  id integer [primary key, increment]
  contact_id integer [ref: > contacts.id, not null]
  company_id integer [ref: > companies.id, not null]
  role varchar(100)
  budget_range_min integer
  budget_range_max integer
  decision_authority varchar(20)
  preferred_contact_method varchar(20)
  notes text
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]
}

// Shared Stages System
Table stages {
  id integer [primary key, increment]
  name varchar(100) [not null]
  pipeline_type varchar(20) [not null]
  order_index integer [not null]
  color varchar(7)
  is_active boolean [default: true]
  config jsonb
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]
}

// Stage History Tracking
Table stage_history {
  id integer [primary key, increment]
  entity_type varchar(20) [not null]
  entity_id integer [not null]
  from_stage_id integer [ref: > stages.id]
  to_stage_id integer [ref: > stages.id]
  changed_by_user_id integer [ref: > users.id]
  notes text
  created_at timestamp [default: `now()`]
}

// Jobs (Recruitment)
Table jobs {
  id integer [primary key, increment]
  title varchar(200) [not null]
  company_id integer [ref: > companies.id]
  description text
  requirements text
  salary_min integer
  salary_max integer
  location varchar(200)
  job_type varchar(20)
  urgency_level varchar(20) [default: 'normal']
  stage_id integer [ref: > stages.id]
  assigned_user_id integer [ref: > users.id]
  is_active boolean [default: true]
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]
}

// Job Embeddings for AI
Table job_embeddings {
  id integer [primary key, increment]
  job_id integer [ref: > jobs.id, not null]
  embedding_vector vector(384)
  created_at timestamp [default: `now()`]
}

// Deals (Sales)
Table deals {
  id integer [primary key, increment]
  title varchar(200) [not null]
  company_id integer [ref: > companies.id]
  description text
  value integer
  currency varchar(3) [default: 'USD']
  timeline_days integer
  stage_id integer [ref: > stages.id]
  probability integer [default: 0]
  assigned_user_id integer [ref: > users.id]
  is_active boolean [default: true]
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]
}

// Applications (Job Applications)
Table applications {
  id integer [primary key, increment]
  job_id integer [ref: > jobs.id, not null]
  contact_id integer [ref: > contacts.id, not null]
  status varchar(20) [default: 'applied']
  match_score decimal(5,2)
  notes text
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]
}

// Projects (From Won Deals)
Table projects {
  id integer [primary key, increment]
  deal_id integer [ref: > deals.id]
  title varchar(200) [not null]
  description text
  start_date date
  end_date date
  budget integer
  status varchar(20) [default: 'planning']
  assigned_user_id integer [ref: > users.id]
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]
}

// Activities
Table activities {
  id integer [primary key, increment]
  activity_type varchar(20) [not null]
  title varchar(200) [not null]
  description text
  scheduled_at timestamp
  duration_minutes integer
  status varchar(20) [default: 'scheduled']
  related_entity_type varchar(20)
  related_entity_id integer
  organizer_user_id integer [ref: > users.id]
  participants jsonb
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]
}

// Communications
Table communications {
  id integer [primary key, increment]
  communication_type varchar(20) [not null]
  subject varchar(200)
  content text
  direction varchar(10) [not null]
  from_user_id integer [ref: > users.id]
  to_contact_id integer [ref: > contacts.id]
  related_entity_type varchar(20)
  related_entity_id integer
  status varchar(20) [default: 'sent']
  sent_at timestamp [default: `now()`]
  created_at timestamp [default: `now()`]
}

// Relationships
Ref: users.id < user_sessions.user_id
Ref: users.id < companies.assigned_user_id
Ref: users.id < contacts.assigned_user_id
Ref: users.id < jobs.assigned_user_id
Ref: users.id < deals.assigned_user_id
Ref: users.id < projects.assigned_user_id
Ref: users.id < activities.organizer_user_id
Ref: users.id < communications.from_user_id
Ref: users.id < stage_history.changed_by_user_id

Ref: contacts.id < contact_embeddings.contact_id
Ref: contacts.id < contact_job_history.contact_id
Ref: contacts.id < client_profiles.contact_id
Ref: contacts.id < applications.contact_id
Ref: contacts.id < communications.to_contact_id

Ref: companies.id < jobs.company_id
Ref: companies.id < deals.company_id
Ref: companies.id < client_profiles.company_id

Ref: stages.id < jobs.stage_id
Ref: stages.id < deals.stage_id
Ref: stages.id < stage_history.from_stage_id
Ref: stages.id < stage_history.to_stage_id

Ref: jobs.id < job_embeddings.job_id
Ref: jobs.id < applications.job_id

Ref: deals.id < projects.deal_id

// Notes for the diagram
Note: "This diagram shows the complete database schema for a Recruitment & Sales CRM system with shared stages, AI embeddings, and comprehensive audit trails."
```

## How to Use:

1. Go to [dbdiagram.io](https://dbdiagram.io)
2. Click "Create New Diagram"
3. Copy and paste the SQL commands above
4. The diagram will automatically generate showing all tables and relationships

## Key Features of the ERD:

### **Core Entities**:

- **Users**: System users with roles (admin, recruiter, sales, user)
- **Companies**: Business entities for both recruitment and sales
- **Contacts**: People (default candidate info, with optional client profiles)
- **Jobs**: Recruitment opportunities
- **Deals**: Sales opportunities
- **Projects**: Created from won deals

### **Shared Systems**:

- **Stages**: Single table for both recruitment and sales pipelines
- **Activities**: Polymorphic activities for all entities
- **Communications**: Unified communication tracking

### **AI & Analytics**:

- **Embeddings**: Vector storage for AI matching
- **Job History**: Employment history for contacts
- **Stage History**: Audit trail for stage changes

### **Relationships**:

- **One-to-Many**: Companies → Jobs, Companies → Deals
- **Many-to-Many**: Contacts ↔ Companies (through client_profiles)
- **Many-to-Many**: Jobs ↔ Contacts (through applications)
- **Polymorphic**: Activities and Communications can relate to any entity

The diagram will show all foreign key relationships, data types, and constraints, making it easy to understand the complete database structure at a glance.
