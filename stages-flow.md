# Shared Stages System Design

## Problem Statement

We have two CRM systems:

1. **Recruitment CRM** - Job pipeline with stages (Draft → Posted → Interviewing → Offer → Hired/Rejected)
2. **Sales CRM** - Deal pipeline with stages (Lead → Qualified → Proposal → Negotiation → Won/Lost)

Both need stage management, but we want to avoid redundant database tables.

## Design Options

### Option 1: Generic Stages Table with Type Discrimination

```sql
-- Core stages table
CREATE TABLE stages (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    pipeline_type VARCHAR(20) NOT NULL, -- 'recruitment' or 'sales'
    order_index INTEGER NOT NULL,
    color VARCHAR(7), -- hex color code
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(pipeline_type, order_index)
);

-- Pipeline entities reference stages
CREATE TABLE jobs (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    stage_id INTEGER REFERENCES stages(id),
    -- other job fields...
);

CREATE TABLE deals (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    stage_id INTEGER REFERENCES deals(id),
    -- other deal fields...
);

-- Sample data
INSERT INTO stages (name, pipeline_type, order_index, color) VALUES
-- Recruitment stages
('Draft', 'recruitment', 1, '#6B7280'),
('Posted', 'recruitment', 2, '#3B82F6'),
('Screening', 'recruitment', 3, '#F59E0B'),
('Interviewing', 'recruitment', 4, '#8B5CF6'),
('Offer', 'recruitment', 5, '#10B981'),
('Hired', 'recruitment', 6, '#059669'),
('Rejected', 'recruitment', 7, '#EF4444'),

-- Sales stages
('Lead', 'sales', 1, '#6B7280'),
('Qualified', 'sales', 2, '#3B82F6'),
('Proposal', 'sales', 3, '#F59E0B'),
('Negotiation', 'sales', 4, '#8B5CF6'),
('Won', 'sales', 5, '#10B981'),
('Lost', 'sales', 6, '#EF4444');
```

**Pros:**

- Single table for all stages
- Easy to query stages by pipeline type
- Flexible for future pipeline types
- Simple foreign key relationships

**Cons:**

- No pipeline-specific stage properties
- Limited customization per pipeline

### Option 2: Polymorphic Stages with JSON Configuration

```sql
-- Core stages table with flexible configuration
CREATE TABLE stages (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    pipeline_type VARCHAR(20) NOT NULL,
    order_index INTEGER NOT NULL,
    color VARCHAR(7),
    is_active BOOLEAN DEFAULT true,
    config JSONB, -- Pipeline-specific configuration
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(pipeline_type, order_index)
);

-- Sample data with pipeline-specific config
INSERT INTO stages (name, pipeline_type, order_index, color, config) VALUES
-- Recruitment stages with job-specific config
('Draft', 'recruitment', 1, '#6B7280', '{
    "requires_approval": false,
    "auto_notify": false,
    "candidate_visible": false,
    "estimated_duration_days": 1
}'),
('Posted', 'recruitment', 2, '#3B82F6', '{
    "requires_approval": false,
    "auto_notify": true,
    "candidate_visible": true,
    "estimated_duration_days": 30,
    "auto_archive_after_days": 90
}'),
('Interviewing', 'recruitment', 4, '#8B5CF6', '{
    "requires_approval": false,
    "auto_notify": true,
    "candidate_visible": true,
    "estimated_duration_days": 14,
    "requires_interview_scheduling": true
}'),

-- Sales stages with deal-specific config
('Lead', 'sales', 1, '#6B7280', '{
    "requires_qualification": true,
    "auto_assign": true,
    "estimated_duration_days": 7,
    "probability": 10
}'),
('Qualified', 'sales', 2, '#3B82F6', '{
    "requires_qualification": false,
    "auto_assign": false,
    "estimated_duration_days": 14,
    "probability": 25,
    "requires_budget_confirmation": true
}'),
('Proposal', 'sales', 3, '#F59E0B', '{
    "requires_qualification": false,
    "auto_assign": false,
    "estimated_duration_days": 21,
    "probability": 50,
    "requires_proposal_approval": true
}'),
('Won', 'sales', 5, '#10B981', '{
    "requires_qualification": false,
    "auto_assign": false,
    "estimated_duration_days": 0,
    "probability": 100,
    "auto_create_project": true
}');
```

**Pros:**

- Flexible configuration per pipeline
- Easy to add new pipeline types
- Rich metadata for each stage
- JSONB allows complex configurations

**Cons:**

- More complex queries
- Schema validation needed for JSON
- Potential performance impact with large JSON

### Option 3: Template-Based Stages with Inheritance

```sql
-- Stage templates (base configurations)
CREATE TABLE stage_templates (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    template_type VARCHAR(20) NOT NULL, -- 'recruitment' or 'sales'
    base_config JSONB NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Actual stages (instances of templates)
CREATE TABLE stages (
    id SERIAL PRIMARY KEY,
    template_id INTEGER REFERENCES stage_templates(id),
    pipeline_id INTEGER, -- Could be user_id or org_id for customization
    name VARCHAR(100) NOT NULL,
    order_index INTEGER NOT NULL,
    color VARCHAR(7),
    is_active BOOLEAN DEFAULT true,
    custom_config JSONB, -- Override template config
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(pipeline_id, order_index)
);

-- Sample template data
INSERT INTO stage_templates (name, template_type, base_config) VALUES
-- Recruitment templates
('Job Draft', 'recruitment', '{
    "requires_approval": false,
    "auto_notify": false,
    "candidate_visible": false,
    "estimated_duration_days": 1,
    "actions": ["edit", "delete", "publish"]
}'),
('Job Posted', 'recruitment', '{
    "requires_approval": false,
    "auto_notify": true,
    "candidate_visible": true,
    "estimated_duration_days": 30,
    "auto_archive_after_days": 90,
    "actions": ["view", "edit", "archive", "find_candidates"]
}'),
('Job Interviewing', 'recruitment', '{
    "requires_approval": false,
    "auto_notify": true,
    "candidate_visible": true,
    "estimated_duration_days": 14,
    "requires_interview_scheduling": true,
    "actions": ["view", "edit", "schedule_interview", "rate_candidate"]
}'),

-- Sales templates
('Deal Lead', 'sales', '{
    "requires_qualification": true,
    "auto_assign": true,
    "estimated_duration_days": 7,
    "probability": 10,
    "actions": ["edit", "qualify", "assign"]
}'),
('Deal Qualified', 'sales', '{
    "requires_qualification": false,
    "auto_assign": false,
    "estimated_duration_days": 14,
    "probability": 25,
    "requires_budget_confirmation": true,
    "actions": ["edit", "create_proposal", "schedule_meeting"]
}'),
('Deal Won', 'sales', '{
    "requires_qualification": false,
    "auto_assign": false,
    "estimated_duration_days": 0,
    "probability": 100,
    "auto_create_project": true,
    "actions": ["view", "create_project", "archive"]
}');
```

**Pros:**

- Reusable templates
- Per-user/organization customization
- Clear separation of concerns
- Easy to maintain standard configurations

**Cons:**

- More complex setup
- Two-table relationship
- Potential for template drift

### Option 4: Event-Driven Stage System

```sql
-- Core stages table
CREATE TABLE stages (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    pipeline_type VARCHAR(20) NOT NULL,
    order_index INTEGER NOT NULL,
    color VARCHAR(7),
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(pipeline_type, order_index)
);

-- Stage transitions (what triggers stage changes)
CREATE TABLE stage_transitions (
    id SERIAL PRIMARY KEY,
    from_stage_id INTEGER REFERENCES stages(id),
    to_stage_id INTEGER REFERENCES stages(id),
    trigger_type VARCHAR(50) NOT NULL, -- 'manual', 'automatic', 'time_based', 'condition_based'
    trigger_config JSONB, -- Configuration for the trigger
    created_at TIMESTAMP DEFAULT NOW()
);

-- Stage actions (what can be done in each stage)
CREATE TABLE stage_actions (
    id SERIAL PRIMARY KEY,
    stage_id INTEGER REFERENCES stages(id),
    action_name VARCHAR(50) NOT NULL,
    action_type VARCHAR(50) NOT NULL, -- 'api_call', 'notification', 'data_update', 'workflow'
    action_config JSONB NOT NULL,
    is_required BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Sample data
INSERT INTO stages (name, pipeline_type, order_index, color) VALUES
-- Recruitment stages
('Draft', 'recruitment', 1, '#6B7280'),
('Posted', 'recruitment', 2, '#3B82F6'),
('Interviewing', 'recruitment', 3, '#8B5CF6'),
('Offer', 'recruitment', 4, '#10B981'),
('Hired', 'recruitment', 5, '#059669'),

-- Sales stages
('Lead', 'sales', 1, '#6B7280'),
('Qualified', 'sales', 2, '#3B82F6'),
('Proposal', 'sales', 3, '#F59E0B'),
('Won', 'sales', 4, '#10B981');

-- Sample transitions
INSERT INTO stage_transitions (from_stage_id, to_stage_id, trigger_type, trigger_config) VALUES
-- Recruitment transitions
(1, 2, 'manual', '{"requires_approval": false}'),
(2, 3, 'condition_based', '{"condition": "has_candidates", "min_candidates": 1}'),
(3, 4, 'manual', '{"requires_interview_completion": true}'),
(4, 5, 'manual', '{"requires_offer_acceptance": true}'),

-- Sales transitions
(5, 6, 'manual', '{"requires_qualification": true}'),
(6, 7, 'manual', '{"requires_proposal_creation": true}'),
(7, 8, 'manual', '{"requires_contract_signing": true}');

-- Sample actions
INSERT INTO stage_actions (stage_id, action_name, action_type, action_config, is_required) VALUES
-- Recruitment actions
(2, 'notify_candidates', 'notification', '{"template": "job_posted", "channels": ["email", "sms"]}', false),
(3, 'schedule_interview', 'workflow', '{"workflow": "interview_scheduling", "auto_assign": true}', true),
(4, 'send_offer', 'api_call', '{"endpoint": "/api/offers", "method": "POST"}', true),

-- Sales actions
(6, 'qualify_lead', 'data_update', '{"fields": ["budget", "timeline", "decision_maker"]}', true),
(7, 'create_proposal', 'workflow', '{"workflow": "proposal_creation", "templates": ["standard", "custom"]}', true),
(8, 'create_project', 'api_call', '{"endpoint": "/api/projects", "method": "POST", "auto_create": true}', true);
```

**Pros:**

- Highly flexible and extensible
- Clear separation of stages, transitions, and actions
- Easy to add new trigger types
- Workflow automation ready

**Cons:**

- Most complex to implement
- Requires more sophisticated application logic
- Potential performance overhead

## Recommended Approach

For your use case, I recommend **Option 2 (Polymorphic Stages with JSON Configuration)** because:

1. **Balanced Complexity** - Not too simple, not too complex
2. **Pipeline-Specific Features** - Can handle recruitment vs sales differences
3. **Future-Proof** - Easy to add new pipeline types
4. **Performance** - JSONB is well-optimized in PostgreSQL
5. **Flexibility** - Can add new properties without schema changes

## Implementation Considerations

### API Design

```typescript
// Get stages for a pipeline
GET /api/stages?pipeline_type=recruitment
GET /api/stages?pipeline_type=sales

// Get stage with configuration
GET /api/stages/{id}

// Update stage configuration
PUT /api/stages/{id}/config

// Move entity to next stage
POST /api/jobs/{id}/move-stage
POST /api/deals/{id}/move-stage
```

### Frontend Considerations

- Stage configuration UI for admins
- Drag-and-drop stage reordering
- Stage-specific forms and validations
- Color coding and visual indicators
- Stage transition rules and validation

Would you like me to:

1. **Dive deeper into Option 2** with more detailed schema and examples?
2. **Explore the API design** for stage management?
3. **Create state diagrams** for stage transitions?
4. **Design the frontend components** for stage management?
