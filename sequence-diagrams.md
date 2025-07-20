# Sequence Diagrams

## 0. New User Onboarding & Empty Dashboard

```mermaid
sequenceDiagram
    participant U as New User
    participant UI as Frontend UI
    participant API as Backend API
    participant DB as Database
    participant AI as AI Service

    U->>UI: Complete sign up
    UI->>API: POST /api/auth/signup
    API->>DB: Create user account
    DB-->>API: Return user ID
    API-->>UI: Return user session
    UI-->>U: Redirect to empty dashboard

    UI->>API: GET /api/dashboard/empty-state
    API->>DB: Check if user has any data
    DB-->>API: Return empty state (no companies, contacts, jobs, deals)
    API-->>UI: Return empty dashboard data
    UI-->>U: Display empty dashboard with setup options

    Note over U: User sees 4 setup options: Companies, Contacts, Jobs, Deals

    U->>UI: Click "Create Companies"
    UI-->>U: Open company creation modal with tabs

    U->>UI: Choose "Manual Entry" tab
    UI-->>U: Show company form fields

    U->>UI: Fill company details (name, industry, size, location, etc.)
    U->>UI: Click "Save Company"

    UI->>API: POST /api/companies
    API->>DB: Insert new company
    DB-->>API: Return company ID
    API-->>UI: Return created company
    UI-->>U: Close modal, show company created

    UI->>API: GET /api/dashboard/updated-state
    API->>DB: Query user's data
    DB-->>API: Return updated dashboard data
    API-->>UI: Return dashboard with company data
    UI-->>U: Update dashboard showing company

    U->>UI: Click "Create Contacts"
    UI-->>U: Open contact creation modal

    U->>UI: Choose "Import Data" tab
    UI-->>U: Show file upload interface

    U->>UI: Upload CSV file with contact data
    UI->>API: POST /api/contacts/import
    API->>API: Parse CSV file
    API->>API: Validate contact data
    API-->>UI: Return preview of imported data

    UI-->>U: Show data preview with column mapping
    U->>UI: Confirm column mapping
    U->>UI: Click "Import Contacts"

    UI->>API: POST /api/contacts/import/confirm
    API->>DB: Insert multiple contacts
    API->>AI: Generate embeddings for skills
    AI-->>API: Return embeddings
    API->>DB: Store embeddings
    DB-->>API: Return contact IDs
    API-->>UI: Return imported contacts
    UI-->>U: Close modal, show contacts imported

    UI->>API: GET /api/dashboard/updated-state
    API->>DB: Query user's data
    DB-->>API: Return updated dashboard data
    API-->>UI: Return dashboard with company and contacts
    UI-->>U: Update dashboard showing progress

    U->>UI: Click "Create Jobs"
    UI-->>U: Open job creation modal

    U->>UI: Fill job details (title, company dropdown, requirements, etc.)
    U->>UI: Click "Save Job"

    UI->>API: POST /api/jobs
    API->>DB: Insert new job
    API->>AI: Generate embeddings for job requirements
    AI-->>API: Return embeddings
    API->>DB: Store job embeddings
    DB-->>API: Return job ID
    API-->>UI: Return created job
    UI-->>U: Close modal, show job created

    UI->>API: GET /api/dashboard/updated-state
    API->>DB: Query user's data
    DB-->>API: Return updated dashboard data
    API-->>UI: Return dashboard with company, contacts, and jobs
    UI-->>U: Update dashboard showing more data

    U->>UI: Click "Create Deals"
    UI-->>U: Open deal creation modal

    U->>UI: Fill deal details (name, company dropdown, value, timeline, etc.)
    U->>UI: Click "Save Deal"

    UI->>API: POST /api/deals
    API->>DB: Insert new deal
    DB-->>API: Return deal ID
    API-->>UI: Return created deal
    UI-->>U: Close modal, show deal created

    UI->>API: GET /api/dashboard/full-state
    API->>DB: Query complete user data
    DB-->>API: Return full dashboard data
    API-->>UI: Return complete dashboard
    UI-->>U: Display full dashboard with all data and analytics
```

## 1. Contact Creation & Client Profile Setup

```mermaid
sequenceDiagram
    participant U as User
    participant UI as Frontend UI
    participant API as Backend API
    participant DB as Database
    participant AI as AI Service

    U->>UI: Navigate to Contacts
    UI->>API: GET /api/contacts
    API->>DB: Query contacts
    DB-->>API: Return contact list
    API-->>UI: Return contact data
    UI-->>U: Display contact list

    U->>UI: Click "Create New Contact"
    UI-->>U: Show contact creation form

    U->>UI: Fill contact details (name, email, phone, location)
    U->>UI: Add personal details (skills, experience, availability)
    U->>UI: Click "Save Contact"

    UI->>API: POST /api/contacts
    Note over API: Validate contact data
    API->>DB: Insert new contact
    DB-->>API: Return contact ID
    API->>AI: Generate vector embeddings for skills
    AI-->>API: Return embeddings
    API->>DB: Store embeddings
    API-->>UI: Return created contact
    UI-->>U: Show contact created successfully

    U->>UI: Click "Add Client Profile" (optional)
    UI-->>U: Show client profile form

    U->>UI: Select company from dropdown
    U->>UI: Set role (Primary, Decision Maker, etc.)
    U->>UI: Add budget range and decision authority
    U->>UI: Set preferred contact method
    U->>UI: Click "Save Client Profile"

    UI->>API: POST /api/contacts/{id}/client-profiles
    API->>DB: Insert client profile
    DB-->>API: Return client profile ID
    API-->>UI: Return created client profile
    UI-->>U: Show client profile added successfully

    U->>UI: Click "Assign to User"
    UI->>API: PUT /api/contacts/{id}/assign
    API->>DB: Update contact assignment
    DB-->>API: Confirm update
    API-->>UI: Return updated contact
    UI-->>U: Show assignment successful
```

## 2. Job Posting & Candidate Matching

```mermaid
sequenceDiagram
    participant R as Recruiter
    participant UI as Frontend UI
    participant API as Backend API
    participant DB as Database
    participant AI as AI Service
    participant C as Candidate

    R->>UI: Navigate to Jobs
    UI->>API: GET /api/jobs
    API->>DB: Query jobs
    DB-->>API: Return job list
    API-->>UI: Return job data
    UI-->>R: Display job list

    R->>UI: Click "Create New Job"
    UI-->>R: Show job creation form

    R->>UI: Fill job details (title, requirements, salary, location)
    R->>UI: Select company from dropdown
    R->>UI: Click "Save Job"

    UI->>API: POST /api/jobs
    API->>DB: Insert new job
    DB-->>API: Return job ID
    API->>AI: Generate vector embeddings for job requirements
    AI-->>API: Return embeddings
    API->>DB: Store job embeddings
    API-->>UI: Return created job
    UI-->>R: Show job created successfully

    R->>UI: Click "Find Candidates"
    UI->>API: GET /api/jobs/{id}/candidates
    API->>AI: Find matching candidates
    AI->>DB: Query contacts with similar skills
    DB-->>AI: Return candidate data
    AI->>AI: Calculate MatchScore for each candidate
    AI-->>API: Return ranked candidate list with scores
    API-->>UI: Return candidate matches
    UI-->>R: Display candidate matches with MatchScore

    R->>UI: Select candidates for outreach
    R->>UI: Click "Send Outreach"
    UI->>API: POST /api/jobs/{id}/outreach
    API->>DB: Create applications for selected candidates
    API->>API: Send personalized messages
    API-->>UI: Return outreach status
    UI-->>R: Show outreach sent successfully

    Note over C: Candidate receives message
    C->>UI: View job opportunity
    C->>UI: Click "Apply" or "Decline"
    UI->>API: PUT /api/applications/{id}/status
    API->>DB: Update application status
    DB-->>API: Confirm update
    API-->>UI: Return updated application
    UI-->>C: Show application updated
```

## 3. Deal Creation & Project Generation

```mermaid
sequenceDiagram
    participant S as Sales Rep
    participant UI as Frontend UI
    participant API as Backend API
    participant DB as Database
    participant P as Project Manager

    S->>UI: Navigate to Deals
    UI->>API: GET /api/deals
    API->>DB: Query deals
    DB-->>API: Return deal list
    API-->>UI: Return deal data
    UI-->>S: Display deal list

    S->>UI: Click "Create New Deal"
    UI-->>S: Show deal creation form

    S->>UI: Select company from dropdown
    S->>UI: Fill deal details (value, timeline, description)
    S->>UI: Set deal stage (Lead, Qualified, etc.)
    S->>UI: Click "Save Deal"

    UI->>API: POST /api/deals
    API->>DB: Insert new deal
    DB-->>API: Return deal ID
    API-->>UI: Return created deal
    UI-->>S: Show deal created successfully

    S->>UI: Click "Schedule Activity"
    UI-->>S: Show activity scheduling form

    S->>UI: Select activity type (call, meeting, demo)
    S->>UI: Set activity details and participants
    S->>UI: Click "Schedule Activity"

    UI->>API: POST /api/deals/{id}/activities
    API->>DB: Insert activity
    API->>API: Send calendar invitations
    DB-->>API: Return activity ID
    API-->>UI: Return scheduled activity
    UI-->>S: Show activity scheduled

    Note over S: Conduct activity and update deal
    S->>UI: Update deal stage to "Won"
    UI->>API: PUT /api/deals/{id}/stage
    API->>DB: Update deal stage
    DB-->>API: Confirm update
    API-->>UI: Return updated deal
    UI-->>S: Show deal won

    S->>UI: Click "Create Project"
    UI->>API: POST /api/deals/{id}/projects
    API->>DB: Create project from deal
    DB-->>API: Return project ID
    API-->>UI: Return created project
    UI-->>S: Show project created

    Note over P: Project Manager takes over
    P->>UI: Navigate to Projects
    UI->>API: GET /api/projects
    API->>DB: Query projects
    DB-->>API: Return project list
    API-->>UI: Return project data
    UI-->>P: Display project list

    P->>UI: Click on new project
    UI->>API: GET /api/projects/{id}
    API->>DB: Query project details
    DB-->>API: Return project data
    API-->>UI: Return project details
    UI-->>P: Show project details

    P->>UI: Set project timeline and milestones
    P->>UI: Assign team members
    P->>UI: Click "Start Project"

    UI->>API: PUT /api/projects/{id}/status
    API->>DB: Update project status to "Active"
    DB-->>API: Confirm update
    API-->>UI: Return updated project
    UI-->>P: Show project started
```

## 4. AI Matching Process

```mermaid
sequenceDiagram
    participant U as User
    participant UI as Frontend UI
    participant API as Backend API
    participant AI as AI Service
    participant DB as Database

    U->>UI: Trigger AI matching (Job→Candidates or Candidate→Jobs)
    UI->>API: POST /api/matching/find-matches

    API->>DB: Get source entity (job or candidate)
    DB-->>API: Return entity data with embeddings

    API->>AI: Send matching request with embeddings
    AI->>DB: Query target entities (candidates or jobs)
    DB-->>AI: Return entity data with embeddings

    AI->>AI: Calculate similarity scores
    AI->>AI: Apply business rules and filters
    AI->>AI: Rank results by MatchScore
    AI-->>API: Return ranked matches with scores

    API->>DB: Log matching results for analytics
    DB-->>API: Confirm logging

    API-->>UI: Return ranked matches
    UI-->>U: Display matches with MatchScore breakdown

    U->>UI: Select matches for action
    U->>UI: Click action button (Apply, Outreach, etc.)
    UI->>API: POST /api/matching/process-selection

    API->>DB: Process selected matches
    DB-->>API: Confirm processing

    API->>AI: Update learning model with user feedback
    AI-->>API: Confirm model update

    API-->>UI: Return processing results
    UI-->>U: Show action completed successfully
```
