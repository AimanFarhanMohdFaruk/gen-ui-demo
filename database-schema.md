# Database Schema Design

## Overview

This schema supports both Recruitment CRM and Sales CRM with a shared stages system, using the recommended **Polymorphic Stages with JSON Configuration** approach.

## Core Tables

### 1. Users & Authentication

```sql
-- Users table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    role VARCHAR(20) NOT NULL DEFAULT 'user', -- 'admin', 'recruiter', 'sales', 'user'
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- User sessions
CREATE TABLE user_sessions (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    session_token VARCHAR(255) UNIQUE NOT NULL,
    expires_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);
```

### 2. Companies

```sql
CREATE TABLE companies (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    industry VARCHAR(100),
    size VARCHAR(50), -- '1-10', '11-50', '51-200', '201-1000', '1000+'
    location VARCHAR(200),
    website VARCHAR(255),
    description TEXT,
    status VARCHAR(20) DEFAULT 'active', -- 'active', 'inactive', 'prospect'
    assigned_user_id INTEGER REFERENCES users(id),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);
```

### 3. Contacts

```sql
CREATE TABLE contacts (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(50),
    location VARCHAR(200),
    skills TEXT[], -- Array of skills
    experience_years INTEGER,
    availability_status VARCHAR(20) DEFAULT 'available', -- 'available', 'employed', 'unavailable'
    salary_expectations_min INTEGER,
    salary_expectations_max INTEGER,
    source VARCHAR(100), -- 'linkedin', 'referral', 'website', 'import'
    assigned_user_id INTEGER REFERENCES users(id),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Contact skills embeddings for AI matching
CREATE TABLE contact_embeddings (
    id SERIAL PRIMARY KEY,
    contact_id INTEGER REFERENCES contacts(id) ON DELETE CASCADE,
    embedding_vector VECTOR(384), -- Using 384-dimensional vectors
    created_at TIMESTAMP DEFAULT NOW()
);
```

### 4. Client Profiles (Sales Relationships)

```sql
CREATE TABLE client_profiles (
    id SERIAL PRIMARY KEY,
    contact_id INTEGER REFERENCES contacts(id) ON DELETE CASCADE,
    company_id INTEGER REFERENCES companies(id) ON DELETE CASCADE,
    role VARCHAR(100), -- 'Primary Contact', 'Decision Maker', 'Influencer', etc.
    budget_range_min INTEGER,
    budget_range_max INTEGER,
    decision_authority VARCHAR(20), -- 'none', 'low', 'medium', 'high'
    preferred_contact_method VARCHAR(20), -- 'email', 'phone', 'linkedin'
    notes TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(contact_id, company_id)
);
```

### 5. Shared Stages System

```sql
CREATE TABLE stages (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    pipeline_type VARCHAR(20) NOT NULL, -- 'recruitment' or 'sales'
    order_index INTEGER NOT NULL,
    color VARCHAR(7), -- hex color code
    is_active BOOLEAN DEFAULT true,
    config JSONB, -- Pipeline-specific configuration
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(pipeline_type, order_index)
);

-- Stage history tracking
CREATE TABLE stage_history (
    id SERIAL PRIMARY KEY,
    entity_type VARCHAR(20) NOT NULL, -- 'job' or 'deal'
    entity_id INTEGER NOT NULL,
    from_stage_id INTEGER REFERENCES stages(id),
    to_stage_id INTEGER REFERENCES stages(id),
    changed_by_user_id INTEGER REFERENCES users(id),
    notes TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);
```

### 6. Jobs (Recruitment)

```sql
CREATE TABLE jobs (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    company_id INTEGER REFERENCES companies(id),
    description TEXT,
    requirements TEXT,
    salary_min INTEGER,
    salary_max INTEGER,
    location VARCHAR(200),
    job_type VARCHAR(20), -- 'full-time', 'part-time', 'contract', 'freelance'
    urgency_level VARCHAR(20) DEFAULT 'normal', -- 'low', 'normal', 'high', 'urgent'
    stage_id INTEGER REFERENCES stages(id),
    assigned_user_id INTEGER REFERENCES users(id),
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Job requirements embeddings for AI matching
CREATE TABLE job_embeddings (
    id SERIAL PRIMARY KEY,
    job_id INTEGER REFERENCES jobs(id) ON DELETE CASCADE,
    embedding_vector VECTOR(384),
    created_at TIMESTAMP DEFAULT NOW()
);
```

### 7. Deals (Sales)

```sql
CREATE TABLE deals (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    company_id INTEGER REFERENCES companies(id),
    description TEXT,
    value INTEGER, -- Deal value in currency
    currency VARCHAR(3) DEFAULT 'USD',
    timeline_days INTEGER,
    stage_id INTEGER REFERENCES stages(id),
    probability INTEGER DEFAULT 0, -- 0-100%
    assigned_user_id INTEGER REFERENCES users(id),
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);
```

### 8. Applications (Job Applications)

```sql
CREATE TABLE applications (
    id SERIAL PRIMARY KEY,
    job_id INTEGER REFERENCES jobs(id) ON DELETE CASCADE,
    contact_id INTEGER REFERENCES contacts(id) ON DELETE CASCADE,
    status VARCHAR(20) DEFAULT 'applied', -- 'applied', 'screening', 'interviewing', 'offer', 'hired', 'rejected'
    match_score DECIMAL(5,2), -- AI-generated match score
    notes TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(job_id, contact_id)
);
```

### 9. Contact Job History (Employment History)

```sql
CREATE TABLE contact_job_history (
    id SERIAL PRIMARY KEY,
    contact_id INTEGER REFERENCES contacts(id) ON DELETE CASCADE,
    company_name VARCHAR(200) NOT NULL,
    job_title VARCHAR(200) NOT NULL,
    start_date DATE,
    end_date DATE,
    is_current_job BOOLEAN DEFAULT false,
    location VARCHAR(200),
    description TEXT,
    responsibilities TEXT[],
    skills_used TEXT[],
    salary_min INTEGER,
    salary_max INTEGER,
    currency VARCHAR(3) DEFAULT 'USD',
    reason_for_leaving VARCHAR(500),
    supervisor_name VARCHAR(200),
    supervisor_contact VARCHAR(255),
    achievements TEXT[],
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Index for efficient querying
CREATE INDEX idx_contact_job_history_contact_id ON contact_job_history(contact_id);
CREATE INDEX idx_contact_job_history_company_name ON contact_job_history(company_name);
CREATE INDEX idx_contact_job_history_job_title ON contact_job_history(job_title);
CREATE INDEX idx_contact_job_history_dates ON contact_job_history(start_date, end_date);
CREATE INDEX idx_contact_job_history_current ON contact_job_history(is_current_job);
CREATE INDEX idx_contact_job_history_skills ON contact_job_history USING GIN(skills_used);
```

### 10. Projects (From Won Deals)

```sql
CREATE TABLE projects (
    id SERIAL PRIMARY KEY,
    deal_id INTEGER REFERENCES deals(id),
    title VARCHAR(200) NOT NULL,
    description TEXT,
    start_date DATE,
    end_date DATE,
    budget INTEGER,
    status VARCHAR(20) DEFAULT 'planning', -- 'planning', 'active', 'completed', 'cancelled'
    assigned_user_id INTEGER REFERENCES users(id),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);
```

### 11. Activities & Communications

```sql
CREATE TABLE activities (
    id SERIAL PRIMARY KEY,
    activity_type VARCHAR(20) NOT NULL, -- 'call', 'meeting', 'email', 'interview', 'demo'
    title VARCHAR(200) NOT NULL,
    description TEXT,
    scheduled_at TIMESTAMP,
    duration_minutes INTEGER,
    status VARCHAR(20) DEFAULT 'scheduled', -- 'scheduled', 'completed', 'cancelled'

    -- Polymorphic relationship
    related_entity_type VARCHAR(20), -- 'job', 'deal', 'contact', 'company'
    related_entity_id INTEGER,

    -- Participants
    organizer_user_id INTEGER REFERENCES users(id),
    participants JSONB, -- Array of user/contact IDs

    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Communication history
CREATE TABLE communications (
    id SERIAL PRIMARY KEY,
    communication_type VARCHAR(20) NOT NULL, -- 'email', 'sms', 'linkedin', 'call'
    subject VARCHAR(200),
    content TEXT,
    direction VARCHAR(10) NOT NULL, -- 'inbound', 'outbound'

    -- Sender/Recipient
    from_user_id INTEGER REFERENCES users(id),
    to_contact_id INTEGER REFERENCES contacts(id),

    -- Related entities
    related_entity_type VARCHAR(20), -- 'job', 'deal', 'application'
    related_entity_id INTEGER,

    status VARCHAR(20) DEFAULT 'sent', -- 'sent', 'delivered', 'read', 'failed'
    sent_at TIMESTAMP DEFAULT NOW(),
    created_at TIMESTAMP DEFAULT NOW()
);
```

## Sample Data

### Stages Data

```sql
-- Insert recruitment stages
INSERT INTO stages (name, pipeline_type, order_index, color, config) VALUES
('Draft', 'recruitment', 1, '#6B7280', '{
    "requires_approval": false,
    "auto_notify": false,
    "candidate_visible": false,
    "estimated_duration_days": 1,
    "allowed_actions": ["edit", "delete", "publish"]
}'),
('Posted', 'recruitment', 2, '#3B82F6', '{
    "requires_approval": false,
    "auto_notify": true,
    "candidate_visible": true,
    "estimated_duration_days": 30,
    "auto_archive_after_days": 90,
    "allowed_actions": ["view", "edit", "archive", "find_candidates"]
}'),
('Screening', 'recruitment', 3, '#F59E0B', '{
    "requires_approval": false,
    "auto_notify": true,
    "candidate_visible": true,
    "estimated_duration_days": 7,
    "allowed_actions": ["view", "edit", "schedule_interview", "reject"]
}'),
('Interviewing', 'recruitment', 4, '#8B5CF6', '{
    "requires_approval": false,
    "auto_notify": true,
    "candidate_visible": true,
    "estimated_duration_days": 14,
    "requires_interview_scheduling": true,
    "allowed_actions": ["view", "edit", "schedule_interview", "rate_candidate", "make_offer"]
}'),
('Offer', 'recruitment', 5, '#10B981', '{
    "requires_approval": true,
    "auto_notify": true,
    "candidate_visible": true,
    "estimated_duration_days": 7,
    "allowed_actions": ["view", "edit", "send_offer", "negotiate"]
}'),
('Hired', 'recruitment', 6, '#059669', '{
    "requires_approval": false,
    "auto_notify": true,
    "candidate_visible": true,
    "estimated_duration_days": 0,
    "allowed_actions": ["view", "archive", "onboard"]
}'),
('Rejected', 'recruitment', 7, '#EF4444', '{
    "requires_approval": false,
    "auto_notify": true,
    "candidate_visible": true,
    "estimated_duration_days": 0,
    "allowed_actions": ["view", "archive", "reapply"]
}');

-- Insert sales stages
INSERT INTO stages (name, pipeline_type, order_index, color, config) VALUES
('Lead', 'sales', 1, '#6B7280', '{
    "requires_qualification": true,
    "auto_assign": true,
    "estimated_duration_days": 7,
    "probability": 10,
    "allowed_actions": ["edit", "qualify", "assign", "disqualify"]
}'),
('Qualified', 'sales', 2, '#3B82F6', '{
    "requires_qualification": false,
    "auto_assign": false,
    "estimated_duration_days": 14,
    "probability": 25,
    "requires_budget_confirmation": true,
    "allowed_actions": ["edit", "create_proposal", "schedule_meeting", "disqualify"]
}'),
('Proposal', 'sales', 3, '#F59E0B', '{
    "requires_qualification": false,
    "auto_assign": false,
    "estimated_duration_days": 21,
    "probability": 50,
    "requires_proposal_approval": true,
    "allowed_actions": ["edit", "send_proposal", "negotiate", "close_won", "close_lost"]
}'),
('Negotiation', 'sales', 4, '#8B5CF6', '{
    "requires_qualification": false,
    "auto_assign": false,
    "estimated_duration_days": 14,
    "probability": 75,
    "allowed_actions": ["edit", "negotiate", "close_won", "close_lost"]
}'),
('Won', 'sales', 5, '#10B981', '{
    "requires_qualification": false,
    "auto_assign": false,
    "estimated_duration_days": 0,
    "probability": 100,
    "auto_create_project": true,
    "allowed_actions": ["view", "create_project", "archive"]
}'),
('Lost', 'sales', 6, '#EF4444', '{
    "requires_qualification": false,
    "auto_assign": false,
    "estimated_duration_days": 0,
    "probability": 0,
    "allowed_actions": ["view", "archive", "reactivate"]
}');
```

### Sample Companies

```sql
INSERT INTO companies (name, industry, size, location, website, description) VALUES
('TechCorp Inc', 'Technology', '201-1000', 'San Francisco, CA', 'https://techcorp.com', 'Leading software development company'),
('StartupXYZ', 'SaaS', '11-50', 'Austin, TX', 'https://startupxyz.com', 'Innovative startup in the SaaS space'),
('Global Solutions', 'Consulting', '1000+', 'New York, NY', 'https://globalsolutions.com', 'International consulting firm');
```

### Sample Contacts

```sql
INSERT INTO contacts (first_name, last_name, email, phone, location, skills, experience_years, availability_status, salary_expectations_min, salary_expectations_max) VALUES
('John', 'Doe', 'john.doe@email.com', '+1-555-0101', 'San Francisco, CA', ARRAY['JavaScript', 'React', 'Node.js'], 5, 'available', 80000, 120000),
('Jane', 'Smith', 'jane.smith@email.com', '+1-555-0102', 'Austin, TX', ARRAY['Python', 'Django', 'AWS'], 3, 'employed', 70000, 100000),
('Mike', 'Johnson', 'mike.johnson@email.com', '+1-555-0103', 'New York, NY', ARRAY['Sales', 'CRM', 'Business Development'], 8, 'available', 90000, 150000);
```

### Sample Contact Job History

```sql
-- John Doe's employment history
INSERT INTO contact_job_history (contact_id, company_name, job_title, start_date, end_date, is_current_job, location, description, responsibilities, skills_used, salary_min, salary_max, reason_for_leaving, achievements) VALUES
(1, 'TechStartup Inc', 'Junior Frontend Developer', '2020-01-15', '2021-06-30', false, 'San Francisco, CA', 'Built user interfaces for web applications', ARRAY['Developed responsive web applications', 'Collaborated with design team', 'Participated in code reviews'], ARRAY['JavaScript', 'React', 'HTML', 'CSS'], 65000, 75000, 'Career growth opportunity', ARRAY['Improved page load speed by 40%', 'Mentored 2 junior developers']),
(1, 'WebSolutions Corp', 'Frontend Developer', '2021-07-01', '2023-03-15', false, 'San Francisco, CA', 'Led frontend development for enterprise applications', ARRAY['Led frontend team of 3 developers', 'Architected component library', 'Implemented CI/CD pipelines'], ARRAY['JavaScript', 'React', 'TypeScript', 'Node.js', 'Docker'], 85000, 95000, 'Better compensation and growth', ARRAY['Reduced bundle size by 30%', 'Implemented design system used by 50+ developers']),
(1, 'Innovation Labs', 'Senior Frontend Developer', '2023-04-01', NULL, true, 'San Francisco, CA', 'Senior developer working on cutting-edge web applications', ARRAY['Lead technical decisions', 'Mentor junior developers', 'Architect scalable solutions'], ARRAY['JavaScript', 'React', 'TypeScript', 'Node.js', 'GraphQL', 'AWS'], 110000, 130000, NULL, ARRAY['Led migration to TypeScript', 'Improved team velocity by 25%']);

-- Jane Smith's employment history
INSERT INTO contact_job_history (contact_id, company_name, job_title, start_date, end_date, is_current_job, location, description, responsibilities, skills_used, salary_min, salary_max, reason_for_leaving, achievements) VALUES
(2, 'DataCorp', 'Python Developer', '2021-03-01', '2022-08-31', false, 'Austin, TX', 'Developed data processing applications', ARRAY['Built ETL pipelines', 'Optimized database queries', 'Created REST APIs'], ARRAY['Python', 'Django', 'PostgreSQL', 'Pandas'], 60000, 70000, 'Relocation', ARRAY['Reduced data processing time by 60%', 'Built 5 production APIs']),
(2, 'CloudTech Solutions', 'Backend Engineer', '2022-09-01', NULL, true, 'Austin, TX', 'Full-stack development with focus on backend systems', ARRAY['Design and implement APIs', 'Manage cloud infrastructure', 'Database optimization'], ARRAY['Python', 'Django', 'AWS', 'Docker', 'Kubernetes'], 75000, 85000, NULL, ARRAY['Scaled system to handle 1M+ users', 'Reduced AWS costs by 40%']);

-- Mike Johnson's employment history
INSERT INTO contact_job_history (contact_id, company_name, job_title, start_date, end_date, is_current_job, location, description, responsibilities, skills_used, salary_min, salary_max, reason_for_leaving, achievements) VALUES
(3, 'SalesForce Inc', 'Sales Representative', '2016-01-01', '2018-12-31', false, 'New York, NY', 'B2B sales for enterprise software', ARRAY['Prospecting new clients', 'Managing sales pipeline', 'Negotiating contracts'], ARRAY['Sales', 'CRM', 'Negotiation', 'Presentation'], 60000, 80000, 'Career advancement', ARRAY['Exceeded quota by 150%', 'Closed $2M in new business']),
(3, 'Enterprise Solutions', 'Senior Sales Manager', '2019-01-01', '2021-06-30', false, 'New York, NY', 'Led sales team and managed key accounts', ARRAY['Managing team of 5 sales reps', 'Key account management', 'Sales strategy development'], ARRAY['Sales Management', 'CRM', 'Team Leadership', 'Strategic Planning'], 90000, 120000, 'Company restructuring', ARRAY['Grew team revenue by 200%', 'Retained 95% of key accounts']),
(3, 'Global Tech', 'Director of Business Development', '2021-07-01', '2023-11-30', false, 'New York, NY', 'Strategic business development and partnerships', ARRAY['Strategic partnerships', 'Market expansion', 'Revenue growth strategy'], ARRAY['Business Development', 'Strategic Planning', 'Partnership Management', 'Market Analysis'], 120000, 150000, 'Seeking new challenges', ARRAY['Launched 3 new markets', 'Generated $5M in new partnerships']),
(3, 'StartupXYZ', 'VP of Sales', '2023-12-01', NULL, true, 'New York, NY', 'Leading sales strategy for growing startup', ARRAY['Sales strategy and execution', 'Team leadership', 'Revenue optimization'], ARRAY['Sales Leadership', 'Strategy', 'Team Management', 'Revenue Growth'], 140000, 180000, NULL, ARRAY['Built sales team from 0 to 15 reps', 'Achieved 300% revenue growth']);
```

### Sample Jobs

```sql
INSERT INTO jobs (title, company_id, description, requirements, salary_min, salary_max, location, job_type, urgency_level, stage_id) VALUES
('Senior Frontend Developer', 1, 'Build amazing user interfaces', 'React, TypeScript, 5+ years experience', 100000, 150000, 'San Francisco, CA', 'full-time', 'high', 2),
('Python Backend Engineer', 2, 'Scale our backend systems', 'Python, Django, PostgreSQL, 3+ years experience', 80000, 120000, 'Austin, TX', 'full-time', 'normal', 2),
('Sales Manager', 3, 'Lead our sales team', 'Sales experience, CRM knowledge, leadership', 90000, 140000, 'New York, NY', 'full-time', 'normal', 2);
```

### Sample Deals

```sql
INSERT INTO deals (title, company_id, description, value, currency, timeline_days, stage_id, probability) VALUES
('Enterprise Software License', 1, 'Annual software license for 500 users', 500000, 'USD', 90, 3, 50),
('Consulting Project', 3, '6-month consulting engagement', 250000, 'USD', 180, 2, 25),
('SaaS Subscription', 2, 'Monthly SaaS subscription for 100 users', 12000, 'USD', 30, 4, 75);
```

## Indexes for Performance

```sql
-- Performance indexes
CREATE INDEX idx_contacts_email ON contacts(email);
CREATE INDEX idx_contacts_skills ON contacts USING GIN(skills);
CREATE INDEX idx_contacts_assigned_user ON contacts(assigned_user_id);
CREATE INDEX idx_contacts_availability ON contacts(availability_status);

CREATE INDEX idx_jobs_company ON jobs(company_id);
CREATE INDEX idx_jobs_stage ON jobs(stage_id);
CREATE INDEX idx_jobs_assigned_user ON jobs(assigned_user_id);
CREATE INDEX idx_jobs_active ON jobs(is_active);

CREATE INDEX idx_deals_company ON deals(company_id);
CREATE INDEX idx_deals_stage ON deals(stage_id);
CREATE INDEX idx_deals_assigned_user ON deals(assigned_user_id);
CREATE INDEX idx_deals_active ON deals(is_active);

CREATE INDEX idx_applications_job_contact ON applications(job_id, contact_id);
CREATE INDEX idx_applications_status ON applications(status);

-- Contact job history indexes
CREATE INDEX idx_contact_job_history_contact_id ON contact_job_history(contact_id);
CREATE INDEX idx_contact_job_history_company_name ON contact_job_history(company_name);
CREATE INDEX idx_contact_job_history_job_title ON contact_job_history(job_title);
CREATE INDEX idx_contact_job_history_dates ON contact_job_history(start_date, end_date);
CREATE INDEX idx_contact_job_history_current ON contact_job_history(is_current_job);
CREATE INDEX idx_contact_job_history_skills ON contact_job_history USING GIN(skills_used);

CREATE INDEX idx_activities_entity ON activities(related_entity_type, related_entity_id);
CREATE INDEX idx_activities_scheduled ON activities(scheduled_at);
CREATE INDEX idx_activities_organizer ON activities(organizer_user_id);

CREATE INDEX idx_communications_contact ON communications(to_contact_id);
CREATE INDEX idx_communications_entity ON communications(related_entity_type, related_entity_id);
CREATE INDEX idx_communications_sent_at ON communications(sent_at);

-- JSONB indexes for stage configurations
CREATE INDEX idx_stages_config ON stages USING GIN(config);
CREATE INDEX idx_stages_pipeline_type ON stages(pipeline_type);

-- Vector similarity indexes (if using pgvector)
CREATE INDEX idx_contact_embeddings_vector ON contact_embeddings USING ivfflat (embedding_vector vector_cosine_ops);
CREATE INDEX idx_job_embeddings_vector ON job_embeddings USING ivfflat (embedding_vector vector_cosine_ops);
```

## Key Relationships

1. **Companies** → **Jobs** (One-to-Many)
2. **Companies** → **Deals** (One-to-Many)
3. **Contacts** → **Client Profiles** → **Companies** (Many-to-Many through client_profiles)
4. **Jobs** → **Applications** → **Contacts** (Many-to-Many through applications)
5. **Deals** → **Projects** (One-to-One when deal is won)
6. **Stages** → **Jobs** and **Deals** (Polymorphic relationship)
7. **Users** → **Assigned entities** (Jobs, Deals, Contacts, Companies)

## Benefits of This Schema

1. **Shared Stages**: Single stages table handles both recruitment and sales
2. **Flexible Configuration**: JSONB allows pipeline-specific stage properties
3. **AI-Ready**: Embeddings tables for vector similarity search
4. **Audit Trail**: Stage history tracking for compliance
5. **Scalable**: Proper indexing for performance
6. **Extensible**: Easy to add new pipeline types or entities

Would you like me to:

1. **Create the migration scripts** from your current schema?
2. **Design the API endpoints** that work with this schema?
3. **Create sample queries** for common operations?
4. **Add more advanced features** like workflows or automation?
