I'll create a phased frontend development plan based on the components and pages we've defined. This will help prioritize development and ensure we build the most critical features first.

I'll create the frontend requirements file using the available tools.

Ran tool
Let me create the frontend requirements file by writing it directly:

# Frontend Development Requirements - Phased Approach

## Phase 1: Foundation & Core CRM (Weeks 1-4)

**Goal**: Establish basic CRM functionality with essential features

### Core Infrastructure

- [ ] **Project Setup**

  - React/Next.js application with TypeScript
  - Tailwind CSS for styling
  - React Query for data fetching
  - React Hook Form for forms
  - React Router for navigation
  - PWA setup with service workers

- [ ] **Authentication & User Management**

  - Login/Register pages
  - User profile management
  - Role-based access control (Recruiter vs Sales)
  - Password reset functionality

- [ ] **Layout & Navigation**
  - Responsive sidebar navigation
  - Header with user menu and notifications
  - Breadcrumb navigation
  - Mobile-responsive design

### Core Components (5.1)

- [ ] **ClientCard** - Basic client organization display with edit/delete actions
- [ ] **ContactCard** - Basic contact display with edit/delete actions
- [ ] **DualProfileCard** - Contact card showing both sales and candidate profiles
- [ ] **ProfileToggle** - Switch between sales and candidate views for contacts
- [ ] **VoiceInput** - Voice-to-text input component
- [ ] **MatchScore** - Basic similarity score display

### Essential Pages

- [ ] **Dashboard** - Overview with key metrics
- [ ] **Client Management**
  - Client list page (`/clients`)
  - Client detail page (`/clients/:id`)
  - Client create/edit forms
- [ ] **Contact Management**
  - Contact list page (`/contacts`)
  - Contact detail page (`/contacts/:id`)
  - Contact create/edit forms
  - Dual profile view (`/contacts/:id/profiles`)
- [ ] **Settings** - User preferences and account settings

### Data Management

- [ ] **Offline Support**
  - Basic offline data viewing
  - Sync when online
  - Local storage for critical data

---

## Phase 2: Recruiter CRM Core (Weeks 5-8)

**Goal**: Build essential recruitment functionality

### Recruiter Components (5.2)

- [ ] **JobCard** - Job posting display with basic actions
- [ ] **JobBoard** - Kanban-style job management
- [ ] **ApplicationCard** - Job application display
- [ ] **CandidatePipeline** - Basic candidate tracking

### Recruiter Pages

- [ ] **Job Management**
  - Job list page (`/jobs`)
  - Job detail page (`/jobs/:id`)
  - Job create/edit forms
  - Job board view (`/jobs/board`)
- [ ] **Candidate Management**
  - Candidate list page (`/candidates`)
  - Candidate detail page (`/candidates/:id`)
  - Candidate create/edit forms
  - Candidate pipeline view (`/candidates/pipeline`)
- [ ] **Application Management**
  - Application list page (`/applications`)
  - Application detail page (`/applications/:id`)

### Advanced Features

- [ ] **Basic Matching**
  - Simple skill-based matching
  - Match score display
  - Candidate-job matching interface

### Mobile Features

- [ ] **PWA Enhancements**
  - Offline job board access
  - Mobile candidate screening
  - Voice notes for interviews

---

## Phase 3: Sales CRM Core (Weeks 9-12)

**Goal**: Build essential sales functionality

### Sales Components (5.3)

- [ ] **DealCard** - Deal display with stage management
- [ ] **SalesBoard** - Kanban-style deal management
- [ ] **LeadCard** - Lead display with conversion actions
- [ ] **OpportunityCard** - Opportunity management
- [ ] **SalesPipeline** - Pipeline view for opportunities

### Sales Pages

- [ ] **Lead Management**
  - Lead list page (`/leads`)
  - Lead detail page (`/leads/:id`)
  - Lead create/edit forms
  - Lead conversion workflow
- [ ] **Opportunity Management**
  - Opportunity list page (`/opportunities`)
  - Opportunity detail page (`/opportunities/:id`)
  - Opportunity create/edit forms
  - Sales pipeline view (`/opportunities/pipeline`)
- [ ] **Deal Management**
  - Deal list page (`/deals`)
  - Deal detail page (`/deals/:id`)
  - Deal create/edit forms
  - Sales board view (`/deals/board`)

### Sales Features

- [ ] **Activity Management**
  - Activity timeline component
  - Activity create/edit forms
  - Activity list page (`/activities`)
- [ ] **Basic Sales Funnel**
  - Sales funnel visualization
  - Stage conversion tracking

### Mobile Features

- [ ] **Sales PWA Features**
  - Offline sales pipeline access
  - Mobile lead capture
  - Voice notes for sales calls

---

## Phase 4: Advanced Features & AI Integration (Weeks 13-16)

**Goal**: Add AI-powered features and advanced functionality

### AI-Powered Components

- [ ] **Enhanced MatchScore**
  - Detailed breakdown display
  - Metadata visualization
  - Multiple size variants
- [ ] **SourcingDashboard** - AI-powered candidate discovery
- [ ] **Advanced Matching**
  - Vector-based similarity matching
  - Multi-dimensional scoring
  - Automated candidate ranking

### Advanced Recruiter Features

- [ ] **Interview Management**
  - InterviewScheduler component
  - Interview list page (`/interviews`)
  - Interview detail page (`/interviews/:id`)
  - Calendar integration
- [ ] **Sourcing Features**
  - Sourcing dashboard page (`/sourcing`)
  - Job-specific sourcing (`/sourcing/:jobId`)
  - Outreach campaign management
  - Bulk candidate outreach

### Advanced Sales Features

- [ ] **Sales Analytics**
  - SalesAnalytics component
  - Sales analytics page (`/sales/analytics`)
  - Revenue forecasting
  - Performance dashboards
- [ ] **Advanced Pipeline Management**
  - Custom stage configuration
  - Pipeline analytics
  - Deal velocity tracking

### Analytics & Reporting

- [ ] **RecruitmentAnalytics**
  - Recruitment analytics page (`/recruitment/analytics`)
  - Performance metrics
  - Time-to-hire tracking
- [ ] **General Analytics**
  - Analytics overview page (`/analytics`)
  - Custom report generation
  - Data export functionality

---

## Phase 5: Advanced UI/UX & Optimization (Weeks 17-20)

**Goal**: Polish user experience and add advanced features

### Advanced UI Components

- [ ] **ProjectCard** - Project management display
- [ ] **SalesFunnel** - Advanced funnel visualization
- [ ] **Enhanced VoiceInput**
  - Multi-language support
  - Real-time transcription
  - Voice command integration

### Advanced Pages

- [ ] **Project Management**
  - Project list page (`/projects`)
  - Project detail page (`/projects/:id`)
  - Project create/edit forms
- [ ] **Communication Hub**
  - Communication history page (`/communications`)
  - Integrated messaging
  - Email/SMS integration
- [ ] **Advanced Reports**
  - Custom report builder
  - Scheduled reports
  - Data visualization

### Advanced PWA Features

- [ ] **Enhanced Offline Support**
  - Full offline functionality
  - Background sync
  - Conflict resolution
- [ ] **Advanced Mobile Features**
  - QR code scanning
  - Camera integration
  - Push notifications
  - Background location tracking

### Performance & Optimization

- [ ] **Performance Optimization**
  - Code splitting
  - Lazy loading
  - Image optimization
  - Bundle size optimization
- [ ] **Accessibility**
  - WCAG 2.1 compliance
  - Screen reader support
  - Keyboard navigation
  - High contrast mode

---

## Phase 6: Enterprise Features & Integration (Weeks 21-24)

**Goal**: Add enterprise-level features and third-party integrations

### Enterprise Features

- [ ] **Multi-tenancy**
  - Organization management
  - Team collaboration
  - Role-based permissions
- [ ] **Advanced Security**
  - SSO integration
  - Two-factor authentication
  - Audit logging
  - Data encryption

### Third-party Integrations

- [ ] **Calendar Integration**
  - Google Calendar
  - Outlook Calendar
  - Meeting scheduling
- [ ] **Communication Integrations**
  - Email providers (Gmail, Outlook)
  - SMS services
  - Video conferencing (Zoom, Teams)
- [ ] **Job Board Integrations**
  - LinkedIn Jobs
  - Indeed
  - Glassdoor
- [ ] **CRM Integrations**
  - Salesforce
  - HubSpot
  - Pipedrive

### Advanced Analytics

- [ ] **Predictive Analytics**
  - AI-powered insights
  - Trend analysis
  - Recommendation engine
- [ ] **Advanced Reporting**
  - Custom dashboards
  - Real-time analytics
  - Automated insights

---

## Technical Requirements by Phase

### Phase 1-2: Core Stack

- **Frontend**: React 18+, Next.js 14+, TypeScript
- **Styling**: Tailwind CSS, Headless UI
- **State Management**: React Query, Zustand
- **Forms**: React Hook Form, Zod validation
- **Testing**: Jest, React Testing Library
- **Build**: Vite or Next.js build system

### Phase 3-4: Advanced Stack

- **Charts**: Recharts or Chart.js
- **Calendar**: React Big Calendar
- **File Upload**: React Dropzone
- **Rich Text**: TipTap or Draft.js
- **Notifications**: React Hot Toast
- **Date/Time**: date-fns or Day.js

### Phase 5-6: Enterprise Stack

- **Real-time**: Socket.io or WebSockets
- **PDF Generation**: React PDF
- **Email**: Nodemailer or SendGrid
- **File Storage**: AWS S3 or similar
- **Monitoring**: Sentry, LogRocket
- **CI/CD**: GitHub Actions, Vercel

---

## Success Metrics by Phase

### Phase 1: Foundation

- [ ] User authentication working
- [ ] Basic client management functional
- [ ] Basic contact management functional
- [ ] Responsive design on mobile/desktop
- [ ] Offline viewing capability

### Phase 2: Recruiter Core

- [ ] Job posting and management working
- [ ] Candidate tracking functional
- [ ] Basic matching algorithm working
- [ ] Mobile PWA features operational

### Phase 3: Sales Core

- [ ] Lead and opportunity management working
- [ ] Sales pipeline functional
- [ ] Activity tracking operational
- [ ] Sales funnel visualization working

### Phase 4: AI Integration

- [ ] AI-powered matching working
- [ ] Sourcing dashboard functional
- [ ] Interview scheduling operational
- [ ] Basic analytics working

### Phase 5: Advanced Features

- [ ] Advanced UI components implemented
- [ ] Performance optimized
- [ ] Accessibility compliance achieved
- [ ] Advanced PWA features working

### Phase 6: Enterprise

- [ ] Multi-tenant architecture working
- [ ] Third-party integrations functional
- [ ] Advanced analytics operational
- [ ] Enterprise security implemented

---

## Risk Mitigation

### Technical Risks

- **AI Integration Complexity**: Start with simple matching, gradually add complexity
- **Performance Issues**: Implement performance monitoring from Phase 1
- **Mobile Compatibility**: Test on real devices throughout development
- **Offline Sync Complexity**: Start with simple offline viewing, add sync later

### Business Risks

- **Scope Creep**: Stick to phase requirements, defer features to later phases
- **User Adoption**: Include user feedback loops from Phase 2
- **Integration Challenges**: Start with mock data, add real integrations gradually
- **Security Concerns**: Implement security best practices from Phase 1

### Timeline Risks

- **Development Delays**: Include 20% buffer time in each phase
- **Resource Constraints**: Prioritize core features over nice-to-have features
- **Dependency Issues**: Use stable, well-maintained libraries
- **Testing Complexity**: Implement automated testing from Phase 1

I've created a comprehensive phased frontend development plan that breaks down the requirements into 6 logical phases over 24 weeks. Here's the key structure:

## **Phase Overview:**

### **Phase 1 (Weeks 1-4): Foundation**

- Basic CRM infrastructure
- Authentication and user management
- Core components (ContactCard, VoiceInput, MatchScore)
- Essential pages (Dashboard, Contacts, Settings)

### **Phase 2 (Weeks 5-8): Recruiter CRM Core**

- Job and candidate management
- Basic matching functionality
- Mobile PWA features for recruiters

### **Phase 3 (Weeks 9-12): Sales CRM Core**

- Lead and opportunity management
- Sales pipeline and funnel
- Mobile PWA features for sales

### **Phase 4 (Weeks 13-16): AI Integration**

- Advanced AI-powered matching
- Sourcing dashboard
- Interview management
- Analytics and reporting

### **Phase 5 (Weeks 17-20): Advanced Features**

- Enhanced UI/UX components
- Advanced PWA features
- Performance optimization
- Accessibility compliance

### **Phase 6 (Weeks 21-24): Enterprise**

- Multi-tenancy and security
- Third-party integrations
- Advanced analytics
- Enterprise features

## **Key Benefits of This Approach:**

1. **Incremental Value**: Each phase delivers working functionality
2. **Risk Management**: Complex features are built on solid foundations
3. **User Feedback**: Early phases allow for user input and iteration
4. **Resource Planning**: Clear milestones and deliverables
5. **Technical Debt**: Proper architecture from the start

## **Success Metrics:**

Each phase has clear success criteria and technical requirements, making it easy to track progress and ensure quality delivery.

This phased approach ensures you can start with a working CRM and gradually add sophisticated features while maintaining a stable, scalable codebase.

---

## User Sequence Flows

### 1. Recruiter User Journey

#### 1.1 Job Posting & Candidate Sourcing Flow

```
1. Login → Dashboard
2. Navigate to Jobs → Create New Job
3. Fill job details (title, requirements, salary, location)
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
1. Login → Navigate to Candidates
2. View candidate list with filters (skills, experience, availability)
3. Click on candidate → View detailed profile
4. Review candidate's client and candidate profiles
5. Check candidate's application history
6. Use AI matching to find suitable jobs
7. Create application for candidate to job
8. Track application through pipeline stages
9. Schedule and conduct interviews
10. Update candidate status and notes
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
1. Login → Navigate to Leads
2. Create new lead (manual entry or import)
3. Use VoiceInput for quick note capture
4. Assign lead to sales rep
5. Research lead (LinkedIn, company info)
6. Qualify lead with lead scoring
7. Convert qualified lead to opportunity
8. Set opportunity value and timeline
9. Move opportunity to sales pipeline
10. Track activities and communications
11. Schedule follow-up activities
12. Close won/lost with notes
```

#### 2.2 Deal Management Flow

```
1. Login → Navigate to Deals
2. View sales board with deal stages
3. Click on deal → View detailed information
4. Check client profile and history
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

### 3. Client & Contact Management Flow

#### 3.1 Client Organization Management

```
1. Login → Navigate to Clients
2. View client list with filters (industry, size, status)
3. Click on client → View detailed client information
4. Review client summary (contacts, jobs, deals, projects)
5. Add/edit client contacts and relationships
6. View client activity history
7. Manage client assignments to team members
8. Track client revenue and performance
9. Update client status and notes
10. Generate client reports
```

#### 3.2 Client-Contact Relationship Management

```
1. From Client → Click "Manage Contacts"
2. View all contacts associated with client
3. Add existing contacts to client
4. Create new contacts for client
5. Set contact roles (Primary, Decision Maker, etc.)
6. Manage contact permissions and access
7. Track contact interactions and communications
8. Update contact relationships
9. Remove contacts from client if needed
10. Generate contact relationship reports
```

### 4. Dual Profile Contact Management Flow

#### 4.1 Contact Discovery & Profile Creation

```
1. Login → Navigate to Contacts
2. Search for existing contact
3. If not found → Create new contact
4. Fill basic contact information (name, email, phone, location)
5. Determine contact profiles needed:
   a. Sales Profile (if they can buy from you)
   b. Candidate Profile (if they might work for you)
   c. Both (dual profile contact)
6. Create sales profile if applicable:
   - Budget range and decision authority
   - Preferred contact method
   - Sales stage and notes
7. Create candidate profile if applicable:
   - Skills and experience
   - Salary expectations
   - Availability status and preferences
8. Set primary profiles for each type
9. Assign contact to appropriate user
10. Add notes and source information
```

#### 3.2 Dual Contact Workflow

```
1. View contact with both sales and candidate profiles
2. Switch between sales and candidate views using ProfileToggle
3. As Sales Contact:
   - Create deals and opportunities
   - Track sales activities and communications
   - Manage client relationships
4. As Candidate:
   - Find matching jobs using AI matching
   - Track applications and interviews
   - Manage availability and preferences
5. Use unified communication history across both profiles
6. Leverage dual relationship for cross-selling opportunities
7. Track cross-references between profiles (e.g., sales lead from candidate)
8. Generate insights from dual nature (e.g., "Sarah is both a decision maker and a potential hire")
```

### 5. Dual Profile Management Flow

#### 5.1 Cross-Profile Insights

```
1. From Contact Detail → View "Dual Profile Insights"
2. See cross-references between sales and candidate profiles
3. View suggestions:
   - "Sarah is a decision maker at TechCorp - potential sales opportunity"
   - "Sarah is looking for CTO roles - match to leadership positions"
   - "Sarah's budget range ($100K) could fund a project"
4. Generate cross-selling opportunities
5. Track dual profile analytics
6. Set up alerts for profile changes
7. Create unified communication strategy
8. Monitor dual profile engagement
```

#### 5.2 Profile Switching Workflow

```
1. From Contact List → Click on dual profile contact
2. See profile indicators (Sales + Candidate badges)
3. Click ProfileToggle to switch views
4. Sales View:
   - Show sales profile details
   - Display related deals and opportunities
   - Show client relationships
5. Candidate View:
   - Show candidate profile details
   - Display job matches and applications
   - Show skills and availability
6. Unified View:
   - Show both profiles side by side
   - Display cross-profile insights
   - Show unified activity timeline
7. Quick actions based on current view
8. Seamless switching between contexts
```

### 6. AI-Powered Matching Flow

#### 6.1 Job-Candidate Matching

```
1. From Job → Click "Find Candidates"
2. AI analyzes job requirements
3. Generates vector embeddings
4. Searches candidate database
5. Returns ranked candidate list
6. Display MatchScore for each candidate
7. Show detailed breakdown of match
8. Filter by additional criteria
9. Select candidates for outreach
10. Send personalized messages
11. Track response rates
12. Learn from successful matches
```

#### 6.2 Candidate-Job Matching

```
1. From Candidate → Click "Find Jobs"
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

### 7. Mobile PWA User Flows

#### 7.1 Offline-First Workflow

```
1. Open PWA on mobile device
2. App loads cached data immediately
3. View contacts, jobs, deals offline
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

These user flows provide a comprehensive view of how different user types interact with the system, helping to ensure the frontend development aligns with real-world usage patterns and user expectations.
