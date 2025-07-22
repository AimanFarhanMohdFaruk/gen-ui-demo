-- =====================================================
-- CORRECTED DATABASE SCHEMA
-- =====================================================

-- 1. CLIENTS (Organizations/Companies)
CREATE TABLE clients (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) NOT NULL,
  industry VARCHAR(100),
  company_size ENUM('STARTUP', 'SMALL', 'MEDIUM', 'LARGE', 'ENTERPRISE'),
  website TEXT,
  description TEXT,
  address TEXT,
  city VARCHAR(100),
  state VARCHAR(100),
  country VARCHAR(100),
  postal_code VARCHAR(20),
  phone VARCHAR(50),
  email VARCHAR(255),
  linkedin_url TEXT,
  annual_revenue DECIMAL(15,2),
  employee_count INTEGER,
  founded_year INTEGER,
  is_active BOOLEAN DEFAULT TRUE,
  assigned_to UUID REFERENCES users(id) ON DELETE SET NULL,
  source VARCHAR(100), -- How the client was acquired
  tags TEXT[] DEFAULT '{}',
  notes TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- 2. CONTACTS (People)
CREATE TABLE contacts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  email VARCHAR(255),
  phone VARCHAR(50),
  linkedin_url TEXT,
  location VARCHAR(255),
  source VARCHAR(100), -- How they were acquired
  notes TEXT,
  assigned_to UUID REFERENCES users(id) ON DELETE SET NULL,
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- 3. CLIENT-CONTACT RELATIONSHIPS (Many-to-Many)
CREATE TABLE client_contacts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  client_id UUID NOT NULL REFERENCES clients(id) ON DELETE CASCADE,
  contact_id UUID NOT NULL REFERENCES contacts(id) ON DELETE CASCADE,
  role VARCHAR(100), -- Primary contact, Decision maker, etc.
  position VARCHAR(255), -- Job title at this client
  is_primary BOOLEAN DEFAULT FALSE, -- Primary contact for this client
  created_at TIMESTAMP DEFAULT NOW(),
  UNIQUE(client_id, contact_id)
);

-- 4. SALES PROFILES (For contacts who are potential buyers)
CREATE TABLE sales_profiles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  contact_id UUID NOT NULL REFERENCES contacts(id) ON DELETE CASCADE,
  client_id UUID REFERENCES clients(id) ON DELETE SET NULL, -- Optional: if they work for a known client
  budget_range VARCHAR(50),
  decision_authority ENUM('NONE', 'INFLUENCER', 'DECISION_MAKER', 'FINAL_DECISION'),
  preferred_contact_method ENUM('EMAIL', 'PHONE', 'LINKEDIN', 'WHATSAPP'),
  sales_stage ENUM('LEAD', 'PROSPECT', 'QUALIFIED', 'OPPORTUNITY', 'CUSTOMER'),
  is_primary BOOLEAN DEFAULT FALSE, -- Primary sales profile for this contact
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- 5. CANDIDATE PROFILES (For contacts who are job seekers)
CREATE TABLE candidate_profiles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  contact_id UUID NOT NULL REFERENCES contacts(id) ON DELETE CASCADE,
  skills TEXT[] NOT NULL DEFAULT '{}',
  experience_years INTEGER CHECK (experience_years >= 0),
  salary_expectation DECIMAL(10,2) CHECK (salary_expectation > 0),
  availability_status ENUM('ACTIVE', 'PASSIVE', 'NOT_AVAILABLE') DEFAULT 'ACTIVE',
  preferred_work_type ENUM('FULL_TIME', 'PART_TIME', 'CONTRACT', 'FREELANCE'),
  remote_preference ENUM('ONSITE', 'HYBRID', 'REMOTE'),
  notice_period_days INTEGER DEFAULT 30,
  is_primary BOOLEAN DEFAULT FALSE, -- Primary candidate profile for this contact

  -- Vector embeddings for semantic matching
  skills_embedding vector(1536), -- OpenAI text-embedding-3-small
  experience_embedding vector(1536), -- Experience description embedding
  profile_embedding vector(1536), -- Combined profile embedding

  -- Metadata for filtering and search optimization
  embedding_metadata JSONB, -- Experience level, location, salary range, etc.
  embedding_updated_at TIMESTAMP DEFAULT NOW(),

  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- 6. JOBS (Posted by clients)
CREATE TABLE jobs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title VARCHAR(255) NOT NULL,
  client_id UUID NOT NULL REFERENCES clients(id) ON DELETE CASCADE,
  description TEXT,
  requirements TEXT[] NOT NULL DEFAULT '{}',
  salary_range_min DECIMAL(10,2) CHECK (salary_range_min > 0),
  salary_range_max DECIMAL(10,2) CHECK (salary_range_max >= salary_range_min),
  location VARCHAR(255),
  job_type ENUM('FULL_TIME', 'PART_TIME', 'CONTRACT', 'FREELANCE') NOT NULL,
  status ENUM('OPEN', 'IN_PROGRESS', 'CLOSED', 'ON_HOLD') DEFAULT 'OPEN',
  assigned_recruiter UUID REFERENCES users(id) ON DELETE SET NULL,
  priority ENUM('LOW', 'MEDIUM', 'HIGH', 'URGENT') DEFAULT 'MEDIUM',
  remote_allowed BOOLEAN DEFAULT FALSE,

  -- Vector embeddings for semantic matching
  requirements_embedding vector(1536),
  description_embedding vector(1536),
  job_embedding vector(1536),

  -- Metadata for filtering and search optimization
  embedding_metadata JSONB,
  embedding_updated_at TIMESTAMP DEFAULT NOW(),

  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- 7. DEALS (Sales opportunities with clients)
CREATE TABLE deals (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title VARCHAR(255) NOT NULL,
  description TEXT,
  client_id UUID NOT NULL REFERENCES clients(id) ON DELETE CASCADE,
  contact_id UUID REFERENCES contacts(id) ON DELETE SET NULL, -- Primary contact for this deal
  amount DECIMAL(12,2) CHECK (amount > 0),
  currency VARCHAR(3) DEFAULT 'USD',
  stage ENUM('LEAD', 'CONTACT_MADE', 'PROPOSAL_SENT', 'NEGOTIATION', 'CLOSED_WON', 'CLOSED_LOST') NOT NULL,
  probability INTEGER CHECK (probability >= 0 AND probability <= 100),
  expected_close_date DATE,
  actual_close_date DATE,
  assigned_to UUID REFERENCES users(id) ON DELETE SET NULL,
  source VARCHAR(100),
  tags TEXT[] DEFAULT '{}',
  notes TEXT,
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- 8. PROJECTS (Work delivered to clients)
CREATE TABLE projects (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) NOT NULL,
  description TEXT,
  client_id UUID NOT NULL REFERENCES clients(id) ON DELETE CASCADE,
  deal_id UUID REFERENCES deals(id) ON DELETE SET NULL,
  status ENUM('PLANNING', 'IN_PROGRESS', 'ON_HOLD', 'COMPLETED', 'CANCELLED') DEFAULT 'PLANNING',
  start_date DATE,
  end_date DATE,
  budget DECIMAL(12,2) CHECK (budget > 0),
  actual_cost DECIMAL(12,2) CHECK (actual_cost >= 0),
  assigned_to UUID REFERENCES users(id) ON DELETE SET NULL,
  deliverables TEXT[] DEFAULT '{}',
  notes TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  CHECK (end_date IS NULL OR end_date >= start_date)
);

-- =====================================================
-- AUDIT TABLES
-- =====================================================

-- Contact profile audit trail
CREATE TABLE contact_profile_audit_log (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  contact_id UUID NOT NULL REFERENCES contacts(id) ON DELETE CASCADE,
  profile_type ENUM('SALES', 'CANDIDATE') NOT NULL,
  profile_id UUID NOT NULL,
  user_id UUID REFERENCES users(id) ON DELETE SET NULL,
  action VARCHAR(50) NOT NULL, -- 'CREATE', 'UPDATE', 'DELETE', 'PRIMARY_CHANGE'
  field_name VARCHAR(100),
  old_value TEXT,
  new_value TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Client audit trail
CREATE TABLE client_audit_log (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  client_id UUID NOT NULL REFERENCES clients(id) ON DELETE CASCADE,
  user_id UUID REFERENCES users(id) ON DELETE SET NULL,
  action VARCHAR(50) NOT NULL, -- 'CREATE', 'UPDATE', 'DELETE', 'ASSIGN'
  field_name VARCHAR(100),
  old_value TEXT,
  new_value TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);

-- =====================================================
-- SUMMARY VIEWS
-- =====================================================

-- Contact profile summary view
CREATE VIEW contact_profile_summary AS
SELECT
  c.id,
  c.first_name,
  c.last_name,
  c.email,
  c.phone,
  c.location,
  c.assigned_to,
  c.is_active,
  
  -- Sales profile info
  sp.budget_range as sales_budget,
  sp.decision_authority as sales_authority,
  sp.sales_stage as sales_stage,
  sp.is_primary as is_primary_sales,
  
  -- Candidate profile info
  canp.skills as candidate_skills,
  canp.experience_years as candidate_experience,
  canp.availability_status as candidate_availability,
  canp.is_primary as is_primary_candidate,
  
  -- Profile existence flags
  CASE WHEN sp.id IS NOT NULL THEN TRUE ELSE FALSE END as has_sales_profile,
  CASE WHEN canp.id IS NOT NULL THEN TRUE ELSE FALSE END as has_candidate_profile,
  
  -- Client relationships
  COUNT(DISTINCT cc.client_id) as total_clients,
  COUNT(DISTINCT CASE WHEN cc.is_primary THEN cc.client_id END) as primary_client_count
  
FROM contacts c
LEFT JOIN sales_profiles sp ON c.id = sp.contact_id
LEFT JOIN candidate_profiles canp ON c.id = canp.contact_id
LEFT JOIN client_contacts cc ON c.id = cc.contact_id
GROUP BY 
  c.id, c.first_name, c.last_name, c.email, c.phone, c.location, 
  c.assigned_to, c.is_active, sp.budget_range, sp.decision_authority, 
  sp.sales_stage, sp.is_primary, canp.skills, canp.experience_years, 
  canp.availability_status, canp.is_primary, sp.id, canp.id;

-- Client summary view
CREATE VIEW client_summary AS
SELECT
  c.id,
  c.name,
  c.industry,
  c.company_size,
  c.is_active,
  c.assigned_to,
  
  -- Contact info
  COUNT(DISTINCT cc.contact_id) as total_contacts,
  COUNT(DISTINCT CASE WHEN cc.is_primary THEN cc.contact_id END) as primary_contacts,
  
  -- Job info
  COUNT(j.id) as total_jobs,
  COUNT(CASE WHEN j.status = 'OPEN' THEN 1 END) as open_jobs,
  
  -- Deal info
  COUNT(d.id) as total_deals,
  COUNT(CASE WHEN d.stage = 'CLOSED_WON' THEN 1 END) as won_deals,
  SUM(CASE WHEN d.stage = 'CLOSED_WON' THEN d.amount ELSE 0 END) as total_revenue,
  
  -- Project info
  COUNT(p.id) as total_projects,
  COUNT(CASE WHEN p.status = 'COMPLETED' THEN 1 END) as completed_projects,
  
  -- Last activity
  MAX(GREATEST(c.updated_at, j.updated_at, d.updated_at, p.updated_at)) as last_activity
  
FROM clients c
LEFT JOIN client_contacts cc ON c.id = cc.client_id
LEFT JOIN jobs j ON c.id = j.client_id
LEFT JOIN deals d ON c.id = d.client_id
LEFT JOIN projects p ON c.id = p.client_id
GROUP BY c.id, c.name, c.industry, c.company_size, c.is_active, c.assigned_to;

-- =====================================================
-- CONSTRAINTS AND INDEXES
-- =====================================================

-- Ensure unique email per contact
CREATE UNIQUE INDEX idx_contacts_email_unique
  ON contacts(LOWER(email)) WHERE email IS NOT NULL;

-- Ensure unique phone per contact
CREATE UNIQUE INDEX idx_contacts_phone_unique
  ON contacts(phone) WHERE phone IS NOT NULL;

-- Ensure only one primary profile per type per contact
CREATE UNIQUE INDEX idx_sales_profiles_primary
  ON sales_profiles(contact_id, is_primary) WHERE is_primary = TRUE;

CREATE UNIQUE INDEX idx_candidate_profiles_primary
  ON candidate_profiles(contact_id, is_primary) WHERE is_primary = TRUE;

-- Ensure only one primary contact per client
CREATE UNIQUE INDEX idx_client_contacts_primary
  ON client_contacts(client_id, is_primary) WHERE is_primary = TRUE;

-- Performance indexes
CREATE INDEX idx_contacts_search ON contacts(first_name, last_name) WHERE is_active = TRUE;
CREATE INDEX idx_contacts_location_active ON contacts(location, is_active) WHERE is_active = TRUE;
CREATE INDEX idx_contacts_assigned_active ON contacts(assigned_to, is_active) WHERE is_active = TRUE;

CREATE INDEX idx_clients_search ON clients(name) WHERE is_active = TRUE;
CREATE INDEX idx_clients_industry ON clients(industry) WHERE is_active = TRUE;
CREATE INDEX idx_clients_assigned ON clients(assigned_to) WHERE is_active = TRUE;

CREATE INDEX idx_client_contacts_client ON client_contacts(client_id);
CREATE INDEX idx_client_contacts_contact ON client_contacts(contact_id);

CREATE INDEX idx_sales_profiles_contact ON sales_profiles(contact_id);
CREATE INDEX idx_candidate_profiles_contact ON candidate_profiles(contact_id);
CREATE INDEX idx_candidate_profiles_skills_gin ON candidate_profiles USING GIN(skills);

-- Vector similarity indexes
CREATE INDEX idx_candidate_profiles_skills_embedding ON candidate_profiles USING ivfflat (skills_embedding vector_cosine_ops) WITH (lists = 100);
CREATE INDEX idx_candidate_profiles_profile_embedding ON candidate_profiles USING ivfflat (profile_embedding vector_cosine_ops) WITH (lists = 100);
CREATE INDEX idx_jobs_requirements_embedding ON jobs USING ivfflat (requirements_embedding vector_cosine_ops) WITH (lists = 100);
CREATE INDEX idx_jobs_job_embedding ON jobs USING ivfflat (job_embedding vector_cosine_ops) WITH (lists = 100); 