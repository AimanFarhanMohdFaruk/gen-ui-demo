# Frontend Components & Pages

## 5.1 Core Components

### ContactCard

```typescript
interface ContactCardProps {
  contact: Contact;
  onEdit: (contact: Contact) => void;
  onDelete: (contactId: string) => void;
  onViewMatches?: (contactId: string) => void;
  showActions?: boolean;
}
```

### JobCard

```typescript
interface JobCardProps {
  job: Job;
  onEdit: (job: Job) => void;
  onDelete: (jobId: string) => void;
  onViewMatches?: (jobId: string) => void;
  showActions?: boolean;
}
```

### DealCard

```typescript
interface DealCardProps {
  deal: Deal;
  onEdit: (deal: Deal) => void;
  onDelete: (dealId: string) => void;
  onMoveStage: (dealId: string, stage: string) => void;
  showActions?: boolean;
}
```

### ProjectCard

```typescript
interface ProjectCardProps {
  project: Project;
  onEdit: (project: Project) => void;
  onDelete: (projectId: string) => void;
  onUpdateStatus: (projectId: string, status: string) => void;
  showActions?: boolean;
}
```

### VoiceInput

```typescript
interface VoiceInputProps {
  onTranscript: (text: string) => void;
  onProcessing: (processing: boolean) => void;
  placeholder?: string;
  disabled?: boolean;
}
```

### MatchScore

```typescript
interface MatchScoreProps {
  similarityScore: number; // 0-1 (cosine similarity)
  breakdown?: {
    skillsSimilarity: number;
    experienceSimilarity: number;
    profileSimilarity: number;
  };
  metadata?: {
    matchedSkills: string[];
    experienceGap: number;
    salaryAlignment: number;
    locationMatch: boolean;
    remoteCompatibility: boolean;
  };
  showBreakdown?: boolean;
  showMetadata?: boolean;
  size?: "small" | "medium" | "large";
  variant?: "default" | "detailed" | "compact";
}
```

## 5.2 Recruiter CRM Components

### JobBoard

```typescript
interface JobBoardProps {
  jobs: Job[];
  stages: JobStage[];
  onMoveJob: (jobId: string, stageId: string) => void;
  onEditJob: (job: Job) => void;
  onAddJob: () => void;
  onViewApplications: (jobId: string) => void;
  onViewMatches: (jobId: string) => void;
}

interface JobStage {
  id: string;
  name: string;
  color: string;
  order: number;
  jobCount: number;
  applicationCount: number;
}
```

### CandidatePipeline

```typescript
interface CandidatePipelineProps {
  candidates: CandidateProfile[];
  stages: CandidateStage[];
  onMoveCandidate: (candidateId: string, stageId: string) => void;
  onEditCandidate: (candidate: CandidateProfile) => void;
  onAddCandidate: () => void;
  onViewApplications: (candidateId: string) => void;
  onViewMatches: (candidateId: string) => void;
  onScheduleInterview: (candidateId: string, jobId: string) => void;
}

interface CandidateStage {
  id: string;
  name: string;
  color: string;
  order: number;
  candidateCount: number;
  averageMatchScore: number;
}
```

### ApplicationCard

```typescript
interface ApplicationCardProps {
  application: JobApplication;
  onUpdateStatus: (applicationId: string, status: string) => void;
  onScheduleInterview: (applicationId: string) => void;
  onAddNotes: (applicationId: string, notes: string) => void;
  onViewTimeline: (applicationId: string) => void;
  showActions?: boolean;
}
```

### InterviewScheduler

```typescript
interface InterviewSchedulerProps {
  applicationId: string;
  candidate: CandidateProfile;
  job: Job;
  onSchedule: (interview: InterviewRequest) => void;
  onCancel: () => void;
}

interface InterviewRequest {
  applicationId: string;
  type: "PHONE" | "VIDEO" | "ONSITE" | "TECHNICAL" | "FINAL";
  interviewer: string;
  scheduledAt: Date;
  duration: number;
  location?: string;
  videoUrl?: string;
  notes?: string;
  questions?: string[];
}
```

### SourcingDashboard

```typescript
interface SourcingDashboardProps {
  jobId: string;
  candidates: VectorMatchResult[];
  onOutreach: (candidateId: string, type: string) => void;
  onAddToPipeline: (candidateId: string) => void;
  onViewProfile: (candidateId: string) => void;
  filters: SourcingFilters;
  onUpdateFilters: (filters: SourcingFilters) => void;
}

interface SourcingFilters {
  similarityThreshold: number;
  experienceRange: [number, number];
  salaryRange: [number, number];
  location: string[];
  availability: string[];
  workType: string[];
  remoteAllowed: boolean;
}
```

### RecruitmentAnalytics

```typescript
interface RecruitmentAnalyticsProps {
  data: RecruitmentAnalyticsData;
  dateRange: [Date, Date];
  onDateRangeChange: (range: [Date, Date]) => void;
  onExport: (format: string) => void;
}

interface RecruitmentAnalyticsData {
  overview: {
    totalJobs: number;
    totalCandidates: number;
    totalApplications: number;
    totalPlacements: number;
    averageTimeToFill: number;
    averageTimeToHire: number;
  };
  pipelineMetrics: {
    applicationsByStage: { [stage: string]: number };
    conversionRates: { [stage: string]: number };
    timeInStage: { [stage: string]: number };
  };
  recruiterPerformance: RecruiterPerformance[];
  jobPerformance: JobPerformance[];
  candidateQuality: CandidateQualityMetrics;
}
```

## 5.3 Sales CRM Components

### SalesBoard

```typescript
interface SalesBoardProps {
  deals: Deal[];
  stages: SalesPipelineStage[];
  onMoveDeal: (dealId: string, stageId: string) => void;
  onEditDeal: (deal: Deal) => void;
  onAddDeal: () => void;
}
```

### SalesFunnel

```typescript
interface SalesFunnelProps {
  data: {
    stage: string;
    count: number;
    value: number;
    conversionRate: number;
  }[];
  onStageClick: (stage: string) => void;
}
```

### LeadCard

```typescript
interface LeadCardProps {
  lead: Lead;
  onConvert: (leadId: string) => void;
  onEdit: (lead: Lead) => void;
  onDelete: (leadId: string) => void;
  onAssign: (leadId: string, userId: string) => void;
  showActions?: boolean;
}
```

### OpportunityCard

```typescript
interface OpportunityCardProps {
  opportunity: Opportunity;
  onEdit: (opportunity: Opportunity) => void;
  onDelete: (opportunityId: string) => void;
  onUpdateStage: (opportunityId: string, stage: string) => void;
  onAddActivity: (opportunityId: string, activity: Activity) => void;
  showActions?: boolean;
}
```

### SalesPipeline

```typescript
interface SalesPipelineProps {
  opportunities: Opportunity[];
  stages: SalesStage[];
  onMoveOpportunity: (opportunityId: string, stageId: string) => void;
  onEditOpportunity: (opportunity: Opportunity) => void;
  onAddOpportunity: () => void;
  onViewDetails: (opportunityId: string) => void;
}

interface SalesStage {
  id: string;
  name: string;
  color: string;
  order: number;
  opportunityCount: number;
  totalValue: number;
  conversionRate: number;
}
```

### ActivityTimeline

```typescript
interface ActivityTimelineProps {
  activities: Activity[];
  onAddActivity: (activity: ActivityRequest) => void;
  onEditActivity: (activityId: string, activity: ActivityRequest) => void;
  onDeleteActivity: (activityId: string) => void;
}

interface ActivityRequest {
  type: "CALL" | "EMAIL" | "MEETING" | "TASK" | "NOTE";
  subject: string;
  description?: string;
  scheduledAt?: Date;
  duration?: number;
  contactId?: string;
  dealId?: string;
  outcome?: string;
}
```

### SalesAnalytics

```typescript
interface SalesAnalyticsProps {
  data: SalesAnalyticsData;
  dateRange: [Date, Date];
  onDateRangeChange: (range: [Date, Date]) => void;
  onExport: (format: string) => void;
}

interface SalesAnalyticsData {
  overview: {
    totalLeads: number;
    totalOpportunities: number;
    totalDeals: number;
    totalRevenue: number;
    averageDealSize: number;
    winRate: number;
  };
  pipelineMetrics: {
    opportunitiesByStage: { [stage: string]: number };
    conversionRates: { [stage: string]: number };
    timeInStage: { [stage: string]: number };
  };
  salesPerformance: SalesPerformance[];
  leadSources: LeadSourceMetrics[];
  revenueForecast: RevenueForecast;
}
```

## 5.4 Page Structure

### General Pages

```
/                    # Dashboard
/contacts           # Contact list
/contacts/new       # Create contact
/contacts/:id       # Contact detail
/contacts/:id/edit  # Edit contact
```

### Recruiter CRM Pages

```
/jobs               # Job list
/jobs/new           # Create job
/jobs/:id           # Job detail
/jobs/:id/matches   # Job matches
/jobs/:id/applications # Job applications
/jobs/board         # Job board (Kanban)

/candidates         # Candidate list
/candidates/new     # Create candidate
/candidates/:id     # Candidate detail
/candidates/:id/applications # Candidate applications
/candidates/pipeline # Candidate pipeline

/applications       # Application list
/applications/:id   # Application detail
/applications/:id/timeline # Application timeline

/interviews         # Interview list
/interviews/new     # Schedule interview
/interviews/:id     # Interview detail

/sourcing           # Sourcing dashboard
/sourcing/:jobId    # Job-specific sourcing

/recruitment/analytics # Recruitment analytics
/recruitment/reports   # Recruitment reports

/clients            # Client list (recruiter view)
/clients/:id        # Client detail
/clients/:id/jobs   # Client jobs
```

### Sales CRM Pages

```
/leads              # Lead list
/leads/new          # Create lead
/leads/:id          # Lead detail
/leads/:id/convert  # Convert lead to opportunity

/opportunities      # Opportunity list
/opportunities/new  # Create opportunity
/opportunities/:id  # Opportunity detail
/opportunities/pipeline # Sales pipeline (Kanban)

/deals              # Sales deals list
/deals/new          # Create deal
/deals/:id          # Deal detail
/deals/board        # Sales board (Kanban)
/deals/funnel       # Sales funnel view

/activities         # Activity list
/activities/new     # Create activity
/activities/:id     # Activity detail

/sales/analytics    # Sales analytics
/sales/reports      # Sales reports
/sales/forecast     # Revenue forecast

/projects           # Projects list
/projects/new       # Create project
/projects/:id       # Project detail
```

### Shared Pages

```
/communications     # Communication history
/analytics          # Reports & insights
/settings           # User settings
```

## 5.5 Page Mockups

### Job Board (Kanban View)

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ Job Board - Software Development                    [Add Job] [Filter] [Export] │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│ ┌─ Open Jobs (12) ───────────────────────────────────────────────────────┐ │
│ │                                                                         │ │
│ │ ┌─ Senior React Developer ───────────────────────────────────────────┐ │ │
│ │ │ 🏢 TechCorp Inc. | 📍 San Francisco | 💰 $120K-$150K              │ │ │
│ │ │ 📅 Posted: 3 days ago | 📊 8 applications | ⭐ 4.2 avg match       │ │ │
│ │ │ [View] [Applications] [Matches] [Edit] [Close]                    │ │ │
│ │ └─────────────────────────────────────────────────────────────────────┘ │ │
│ │                                                                         │ │
│ │ ┌─ Full Stack Engineer ─────────────────────────────────────────────┐ │ │
│ │ │ 🏢 StartupXYZ | 📍 Remote | 💰 $90K-$120K                        │ │ │
│ │ │ 📅 Posted: 1 week ago | 📊 15 applications | ⭐ 3.8 avg match     │ │ │
│ │ │ [View] [Applications] [Matches] [Edit] [Close]                    │ │ │
│ │ └─────────────────────────────────────────────────────────────────────┘ │ │
│ └─────────────────────────────────────────────────────────────────────────┘ │
│                                                                             │
│ ┌─ In Progress (5) ─────────────────────────────────────────────────────┐ │
│ │                                                                         │ │
│ │ ┌─ DevOps Engineer ─────────────────────────────────────────────────┐ │ │
│ │ │ 🏢 Enterprise Corp | 📍 New York | 💰 $130K-$160K                │ │ │
│ │ │ 📅 Posted: 2 weeks ago | 📊 12 applications | ⭐ 4.1 avg match   │ │ │
│ │ │ [View] [Applications] [Matches] [Edit] [Close]                    │ │ │
│ │ └─────────────────────────────────────────────────────────────────────┘ │ │
│ └─────────────────────────────────────────────────────────────────────────┘ │
│                                                                             │
│ ┌─ Filled (8) ─────────────────────────────────────────────────────────┐ │
│ │                                                                         │ │
│ │ ┌─ Frontend Developer ──────────────────────────────────────────────┐ │ │
│ │ │ 🏢 Digital Agency | 📍 Austin | 💰 $100K-$130K                   │ │ │
│ │ │ ✅ Hired: Mike Chen | 📅 Filled: 2 weeks ago                     │ │ │
│ │ │ [View] [Archive]                                                  │ │ │
│ │ └─────────────────────────────────────────────────────────────────────┘ │ │
│ └─────────────────────────────────────────────────────────────────────────┘ │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Sales Pipeline (Kanban View)

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ Sales Pipeline - Active Opportunities            [Add Opportunity] [Filter] │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│ ┌─ Prospecting (15) ───────────────────────────────────────────────────┐ │
│ │                                                                         │ │
│ │ ┌─ TechCorp Enterprise Deal ───────────────────────────────────────┐ │ │
│ │ │ 🏢 TechCorp Inc. | 💰 $500K | 📅 Created: 1 week ago            │ │ │
│ │ │ 👤 Contact: John Smith | 📞 Last activity: 2 days ago           │ │ │
│ │ │ [View] [Activities] [Convert] [Edit] [Delete]                    │ │ │
│ │ └─────────────────────────────────────────────────────────────────────┘ │ │
│ │                                                                         │ │
│ │ ┌─ StartupXYZ Partnership ────────────────────────────────────────┐ │ │
│ │ │ 🏢 StartupXYZ | 💰 $200K | 📅 Created: 3 days ago               │ │ │
│ │ │ 👤 Contact: Sarah Johnson | 📞 Last activity: Today             │ │ │
│ │ │ [View] [Activities] [Convert] [Edit] [Delete]                    │ │ │
│ │ └─────────────────────────────────────────────────────────────────────┘ │ │
│ └─────────────────────────────────────────────────────────────────────────┘ │
│                                                                             │
│ ┌─ Qualification (8) ──────────────────────────────────────────────────┐ │
│ │                                                                         │ │
│ │ ┌─ Enterprise Corp Solution ──────────────────────────────────────┐ │ │
│ │ │ 🏢 Enterprise Corp | 💰 $750K | 📅 Qualified: 1 week ago       │ │ │
│ │ │ 👤 Contact: Mike Chen | 📞 Next meeting: Tomorrow              │ │ │
│ │ │ [View] [Activities] [Move to Proposal] [Edit] [Delete]          │ │ │
│ │ └─────────────────────────────────────────────────────────────────────┘ │ │
│ └─────────────────────────────────────────────────────────────────────────┘ │
│                                                                             │
│ ┌─ Proposal (5) ─────────────────────────────────────────────────────┐ │
│ │                                                                         │ │
│ │ ┌─ Digital Agency Project ───────────────────────────────────────┐ │ │
│ │ │ 🏢 Digital Agency | 💰 $300K | 📅 Proposal sent: 2 days ago   │ │ │
│ │ │ 👤 Contact: Lisa Wang | 📞 Follow-up: Next week               │ │ │
│ │ │ [View] [Activities] [Move to Negotiation] [Edit] [Delete]      │ │ │
│ │ └─────────────────────────────────────────────────────────────────────┘ │ │
│ └─────────────────────────────────────────────────────────────────────────┘ │
│                                                                             │
│ ┌─ Negotiation (3) ──────────────────────────────────────────────────┐ │
│ │                                                                         │ │
│ │ ┌─ Financial Services Deal ──────────────────────────────────────┐ │ │
│ │ │ 🏢 Financial Services Co | 💰 $1M | 📅 Negotiating: 1 week ago │ │ │
│ │ │ 👤 Contact: Alex Rodriguez | 📞 Contract review: Today         │ │ │
│ │ │ [View] [Activities] [Move to Closed Won] [Edit] [Delete]       │ │ │
│ │ └─────────────────────────────────────────────────────────────────────┘ │ │
│ └─────────────────────────────────────────────────────────────────────────┘ │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Sourcing Dashboard

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ Sourcing Dashboard - Senior React Developer        [Filters] [Export] [Settings] │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│ ┌─ Search Results (127 candidates) ─────────────────────────────────────┐ │
│ │                                                                         │ │
│ │ ┌─ John Smith ─────────────────────────────────────────────────────┐ │ │
│ │ │ 💻 React, TypeScript, Node.js | 📍 San Francisco                │ │ │
│ │ │ ⏰ 6 years exp | 💰 $130K | ⭐ 4.7 match score                   │ │ │
│ │ │ 📊 Skills: 95% match | 📍 Location: Perfect | 💰 Salary: Aligned │ │ │
│ │ │ [View Profile] [Send Outreach] [Add to Pipeline] [Skip]          │ │ │
│ │ └─────────────────────────────────────────────────────────────────────┘ │ │
│ │                                                                         │ │
│ │ ┌─ Emily Davis ───────────────────────────────────────────────────┐ │ │
│ │ │ 💻 React, Redux, GraphQL | 📍 Remote                            │ │ │
│ │ │ ⏰ 5 years exp | 💰 $120K | ⭐ 4.3 match score                   │ │ │
│ │ │ 📊 Skills: 88% match | 📍 Location: Good | 💰 Salary: Aligned   │ │ │
│ │ │ [View Profile] [Send Outreach] [Add to Pipeline] [Skip]          │ │ │
│ │ └─────────────────────────────────────────────────────────────────────┘ │ │
│ └─────────────────────────────────────────────────────────────────────────┘ │
│                                                                             │
│ ┌─ Outreach Campaign ──────────────────────────────────────────────────┐ │
│ │                                                                         │ │
│ │ 📧 Email Template: "Senior React Developer Opportunity"              │ │ │
│ │ 📱 LinkedIn Template: "Exciting React role at TechCorp"              │ │ │
│ │ 📊 Sent: 23 | 📨 Responses: 8 | ✅ Positive: 5 | 📝 Applications: 3  │ │ │
│ │                                                                         │ │
│ │ [View Campaign] [Edit Templates] [Send Bulk Outreach] [View Responses] │ │
│ └─────────────────────────────────────────────────────────────────────────┘ │
│                                                                             │
│ ┌─ Quick Actions ─────────────────────────────────────────────────────┐ │
│ │                                                                         │ │
│ │ [📧 Send Email Outreach] [💼 LinkedIn Message] [📱 WhatsApp]        │ │ │
│ │ [➕ Add to Pipeline] [📊 View Analytics] [📋 Export List]            │ │ │
│ └─────────────────────────────────────────────────────────────────────────┘ │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

## 5.6 PWA Features

### General PWA Features

- Offline contact viewing
- Offline data entry with sync when online
- Push notifications for new matches and deal updates
- Voice input for mobile data entry
- Camera integration for business card scanning

### Recruiter CRM PWA Features

- Offline job board access
- Mobile candidate screening
- Voice notes for interviews
- QR code scanning for candidate check-ins
- Offline application tracking

### Sales CRM PWA Features

- Offline sales pipeline access
- Mobile lead capture
- Voice notes for sales calls
- QR code scanning for business cards
- Offline opportunity tracking
- Mobile proposal viewing
- Offline activity logging
