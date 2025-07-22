## User Sequence Flows

## On First Sign Up & Empty Dashboard

### 0.1 New User Onboarding Flow

```
1. User completes sign up → Redirected to empty dashboard
2. Dashboard displays welcome message and setup options
3. User sees 4 main setup options:
   a. Create Companies
   b. Create Contacts
   c. Create Jobs
   d. Create Deals
4. Each option shows:
   - Quick action button
   - Import data option
   - Sample data preview
5. User can choose to:
   - Fill form manually
   - Import from CSV/Excel
   - Import from LinkedIn/other platforms
   - Skip for now
   - any import will include a import preview.
6. After each creation, dashboard updates with new data
7. User can continue setup or start using the system
```

### 0.2 Company Creation Modal Flow

```
1. Click "Create Companies" → Open modal
2. Modal shows two tabs:
   a. Manual Entry
   b. Import Data
3. Manual Entry tab:
   - Company name
   - Industry
   - Size (employees)
   - Location
   - Website
   - Description
   - Contact person (optional)
4. Import Data tab:
   - Upload CSV/Excel file
   - Preview imported data
   - Map columns to fields
   - Validate data
   - Confirm import
5. Save → Company created and appears in dashboard
```

### 0.3 Contact Creation Modal Flow

```
1. Click "Create Contacts" → Open modal
2. Modal shows two tabs:
   a. Manual Entry
   b. Import Data
3. Manual Entry tab:
   - Personal details (name, email, phone, location)
   - Skills and experience
   - Availability status
   - Source information
   - Optional: Create client profile for company
4. Import Data tab:
   - Upload CSV/Excel file
   - Preview imported data
   - Map columns to fields
   - Validate data
   - Confirm import
5. Save → Contact created and appears in dashboard
```

### 0.4 Job Creation Modal Flow

```
1. Click "Create Jobs" → Open modal
2. Modal shows two tabs:
   a. Manual Entry
   b. Import Data
3. Manual Entry tab:
   - Job title
   - Company (dropdown from existing companies)
   - Requirements and description
   - Salary range
   - Location
   - Job type (full-time, contract, etc.)
   - Urgency level
4. Import Data tab:
   - Upload CSV/Excel file
   - Preview imported data
   - Map columns to fields
   - Validate data
   - Confirm import
5. Save → Job created and appears in dashboard
```

### 0.5 Deal Creation Modal Flow

```
1. Click "Create Deals" → Open modal
2. Modal shows two tabs:
   a. Manual Entry
   b. Import Data
3. Manual Entry tab:
   - Deal name/title
   - Company (dropdown from existing companies)
   - Deal value
   - Timeline
   - Description
   - Deal stage (Lead, Qualified, etc.)
   - Probability
4. Import Data tab:
   - Upload CSV/Excel file
   - Preview imported data
   - Map columns to fields
   - Validate data
   - Confirm import
5. Save → Deal created and appears in dashboard
```

### 0.6 Dashboard Evolution Flow

```
1. Empty Dashboard:
   - Welcome message
   - Setup options with empty state indicators
   - Quick start guide
   - Sample data previews
2. After first creation:
   - Dashboard shows created data
   - Remaining setup options highlighted
   - Progress indicator
   - Suggested next steps
3. After multiple creations:
   - Full dashboard with data
   - Analytics and insights
   - Quick actions
   - Recent activity feed
```

### 1. Recruiter User Journey

#### 1.1 Job Posting & Candidate Sourcing Flow

```
1. Login → Dashboard
2. Navigate to Jobs → Create New Job
3. Fill job details (title, requirements, salary, location, company)
4. Save job → Job appears in Job Board
5. Navigate to Sourcing Dashboard
6. AI suggests candidates based on job requirements
7. Review candidate matches with MatchScore
8. Select candidates → Send outreach messages
9. Track responses in Application Pipeline
10. Schedule interviews for interested candidates
11. Move candidates through interview stages
12. Make offer → Track acceptance/rejection
```

#### 1.2 Candidate Management Flow

```
1. Login → Navigate to Contacts (Candidates)
2. View contact list with filters (skills, experience, availability)
3. Click on contact → View detailed profile
4. Review contact's personal details and skills
5. Check contact's application history
6. Use AI matching to find suitable jobs
7. Create application for contact to job
8. Track application through pipeline stages
9. Schedule and conduct interviews
10. Update contact status and notes
11. Generate offer letter if approved
12. Track onboarding process
```

#### 1.3 Interview Management Flow

```
1. From Application → Schedule Interview
2. Select interview type (phone, video, onsite)
3. Choose interviewer and time slot
4. Send calendar invitation
5. Receive confirmation from candidate
6. Conduct interview (with VoiceInput for notes)
7. Complete interview → Rate candidate
8. Update application status
9. Schedule next round if needed
10. Generate feedback report
11. Move to offer stage or reject
```

### 2. Sales User Journey

#### 2.1 Lead Capture & Qualification Flow

```
1. Login → Navigate to Deals
2. Create new deal (manual entry or import)
3. Select company for the deal
4. Use VoiceInput for quick note capture
5. Assign deal to sales rep
6. Research company (LinkedIn, company info)
7. Qualify deal with lead scoring
8. Set deal value and timeline
9. Move deal to sales pipeline
10. Track activities and communications
11. Schedule follow-up activities
12. Close won/lost with notes
```

#### 2.2 Deal Management Flow

```
1. Login → Navigate to Deals
2. View sales board with deal stages
3. Click on deal → View detailed information
4. Check company profile and history
5. Review deal activities and communications
6. Update deal stage and probability
7. Schedule next activity (call, meeting, demo)
8. Use VoiceInput for activity notes
9. Track deal progress through pipeline
10. Generate proposals and contracts
11. Negotiate terms and conditions
12. Close deal → Create project
```

#### 2.3 Sales Activity Management Flow

```
1. From Deal → Schedule Activity
2. Select activity type (call, meeting, demo, proposal)
3. Set activity details and duration
4. Choose participants and location
5. Send calendar invitations
6. Receive confirmations
7. Conduct activity (with VoiceInput for notes)
8. Complete activity → Rate outcome
9. Set next action and follow-up date
10. Update deal status based on outcome
11. Log communication in history
12. Schedule next activity if needed
```

### 3. Company & Contact Management Flow

#### 3.1 Company Management

```
1. Login → Navigate to Companies
2. View company list with filters (industry, size, status)
3. Click on company → View detailed company information
4. Review company summary (contacts, deals, projects)
5. Add/edit company contacts and relationships
6. View company activity history
7. Manage company assignments to team members
8. Track company revenue and performance
9. Update company status and notes
10. Generate company reports
```

#### 3.2 Contact Management

```
1. Login → Navigate to Contacts
2. View contact list with filters (skills, experience, availability)
3. Click on contact → View detailed contact information
4. Review contact's personal details and skills
5. Check if contact has client profiles (sales relationships)
6. View contact's application history (if candidate)
7. Manage contact assignments to team members
8. Track contact interactions and communications
9. Update contact status and notes
10. Generate contact reports
```

#### 3.3 Client Profile Management

```
1. From Contact → Click "Manage Client Profiles"
2. View all client profiles for the contact
3. Create new client profile for a company
4. Set contact role at company (Primary, Decision Maker, etc.)
5. Add budget range and decision authority
6. Set preferred contact method
7. Track client profile interactions and communications
8. Update client profile relationships
9. Remove client profiles if needed
10. Generate client profile reports
```

### 4. Contact Discovery & Profile Creation Flow

```
1. Login → Navigate to Contacts
2. Search for existing contact
3. If not found → Create new contact
4. Fill basic contact information (name, email, phone, location)
5. Add personal details (skills, experience, availability)
6. Optionally create client profile:
   a. Select company for client relationship
   b. Set role and decision authority
   c. Add budget range and preferences
7. Assign contact to appropriate user
8. Add notes and source information
9. Set contact status (Active, Inactive, etc.)
10. Generate contact summary
```

### 5. AI-Powered Matching Flow

#### 5.1 Job-Candidate Matching

```
1. From Job → Click "Find Candidates"
2. AI analyzes job requirements
3. Generates vector embeddings
4. Searches contact database (candidates)
5. Returns ranked candidate list
6. Display MatchScore for each candidate
7. Show detailed breakdown of match
8. Filter by additional criteria
9. Select candidates for outreach
10. Send personalized messages
11. Track response rates
12. Learn from successful matches
```

#### 5.2 Candidate-Job Matching

```
1. From Contact (Candidate) → Click "Find Jobs"
2. AI analyzes candidate profile
3. Generates vector embeddings
4. Searches job database
5. Returns ranked job list
6. Display MatchScore for each job
7. Show detailed breakdown of match
8. Filter by preferences (location, salary, etc.)
9. Apply to selected jobs
10. Track application status
11. Receive notifications for matches
12. Update preferences based on feedback
```

### 6. Project Management Flow

#### 6.1 Project Creation from Deal

```
1. From Won Deal → Click "Create Project"
2. Select project type and scope
3. Set project timeline and milestones
4. Assign project team members
5. Define project deliverables
6. Set project budget and resources
7. Create project plan
8. Schedule kickoff meeting
9. Set up project tracking
10. Begin project execution
```

#### 6.2 Project Execution Flow

```
1. Login → Navigate to Projects
2. View project dashboard and status
3. Update project milestones and progress
4. Track project activities and communications
5. Manage project resources and assignments
6. Update project timeline and budget
7. Generate project reports
8. Handle project issues and changes
9. Complete project deliverables
10. Close project and archive
```

### 7. Mobile PWA User Flows

#### 7.1 Offline-First Workflow

```
1. Open PWA on mobile device
2. App loads cached data immediately
3. View contacts, jobs, deals, projects offline
4. Use VoiceInput for quick notes
5. Create new records (stored locally)
6. Sync when connection restored
7. Resolve conflicts if any
8. Continue working seamlessly
9. Receive push notifications
10. Access camera for document scanning
11. Use GPS for location-based features
12. Share data via QR codes
```

#### 7.2 Mobile-Specific Features

```
1. Voice-to-text for all input fields
2. Camera integration for business cards
3. QR code scanning for quick access
4. GPS for location-based searches
5. Push notifications for updates
6. Offline data access
7. Touch-optimized interfaces
8. Swipe gestures for actions
9. Mobile-optimized forms
10. Quick action buttons
11. Simplified navigation
12. Battery-optimized performance
```

### 8. Analytics & Reporting Flow

#### 8.1 Dashboard Analytics

```
1. Login → View personalized dashboard
2. See key metrics for role (recruiter/sales)
3. View recent activities and updates
4. Check performance indicators
5. Navigate to detailed analytics
6. Filter data by date range
7. Export reports as needed
8. Set up automated reports
9. Share insights with team
10. Track goal progress
11. Identify trends and patterns
12. Make data-driven decisions
```

#### 8.2 Custom Report Generation

```
1. Navigate to Analytics → Custom Reports
2. Select report type and template
3. Choose data sources and filters
4. Set date ranges and groupings
5. Configure visualization options
6. Preview report layout
7. Save report configuration
8. Schedule automated generation
9. Set up email distribution
10. Track report usage
11. Modify reports as needed
12. Archive old reports
```

### 9. Communication Hub Flow

#### 9.1 Multi-Channel Communication

```
1. From Contact → Click "Send Message"
2. Choose communication channel (email, SMS, LinkedIn)
3. Select message template
4. Personalize content with contact data
5. Schedule send time if needed
6. Send message
7. Track delivery status
8. Monitor response
9. Log communication in history
10. Set follow-up reminders
11. Analyze response rates
12. Optimize templates based on performance
```

#### 9.2 Communication History

```
1. Navigate to Communications
2. View all communication history
3. Filter by contact, type, date
4. Search through message content
5. View response patterns
6. Track engagement metrics
7. Export communication logs
8. Set up communication rules
9. Monitor compliance
10. Generate communication reports
11. Identify best practices
12. Optimize communication strategy
```
