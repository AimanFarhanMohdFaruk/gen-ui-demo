**Application Purpose:** Unified CRM system bridging recruitment and software development services. Users can manage contacts as both clients (for sales) and candidates (for recruitment) with AI-powered job matching.

## Core MVP Screens & Components

### Design System Foundation

**Primary Colors:**

- Primary: #2563eb (Blue)
- Secondary: #64748b (Slate)
- Success: #10b981 (Green)
- Warning: #f59e0b (Amber)
- Error: #ef4444 (Red)
- Background: #f8fafc (Light gray)

**Typography:**

- Headings: Inter, bold
- Body: Inter, regular
- Monospace: JetBrains Mono (for code/technical content)

**Layout:**

- Mobile-first responsive design
- Sidebar navigation (collapsible on mobile)
- Card-based layouts
- Consistent spacing (8px grid system)

---

## 1. Authentication Screens

### 1.1 Login Page (`/login`)

**Purpose:** User authentication entry point

**Key Elements:**

- [ ] Clean, minimal login form
- [ ] Email and password fields
- [ ] "Remember me" checkbox
- [ ] "Forgot password?" link
- [ ] "Sign up" link for new users
- [ ] Brand logo and tagline
- [ ] Error message display area
- [ ] Loading state for form submission

**Mobile Considerations:**

- Full-screen form on mobile
- Large touch targets (44px minimum)
- Keyboard-friendly input fields

### 1.2 Register Page (`/register`)

**Purpose:** New user account creation

**Key Elements:**

- [ ] Registration form with validation
- [ ] Fields: First name, last name, email, password, confirm password
- [ ] Role selection (admin, recruiter, sales)
- [ ] Terms and conditions checkbox
- [ ] "Already have account?" login link
- [ ] Real-time validation feedback
- [ ] Password strength indicator

### 1.3 Password Reset (`/reset-password`)

**Purpose:** Password recovery flow

**Key Elements:**

- [ ] Email input for reset link
- [ ] Confirmation message
- [ ] New password form (if direct reset)
- [ ] Success/error states

---

## 2. Dashboard (`/dashboard`)

### 2.1 Main Dashboard

**Purpose:** Overview of key metrics and quick actions

**Key Elements:**

- [ ] **Header Section:**

  - Welcome message with user name
  - Quick stats cards (total contacts, active jobs, recent matches)
  - Date/time display

- [ ] **Metrics Cards:**

  - Total Contacts (with growth indicator)
  - Active Jobs (with status breakdown)
  - Recent Matches (with success rate)
  - Pending Actions (tasks requiring attention)

- [ ] **Quick Actions:**

  - "Add New Contact" button
  - "Create Job Posting" button
  - "View Recent Matches" button
  - "Search Contacts" button

- [ ] **Recent Activity Feed:**

  - Latest contacts added
  - Recent job postings
  - Recent matches made
  - User activity timeline

- [ ] **Navigation Sidebar:**
  - Dashboard (active)
  - Contacts
  - Jobs
  - Matches
  - Settings
  - User profile menu

**Mobile Layout:**

- Stacked cards layout
- Bottom navigation bar
- Collapsible sidebar

---

## 3. Contact Management

### 3.1 Contact List (`/contacts`)

**Purpose:** Browse and search all contacts

**Key Elements:**

- [ ] **Header:**

  - "Contacts" title
  - Search bar with filters
  - "Add Contact" button
  - View toggle (list/grid)

- [ ] **Search & Filters:**

  - Search by name, email, skills
  - Filter by: role (client/candidate), location, skills
  - Sort by: name, date added, last activity
  - Clear filters button

- [ ] **Contact Cards:**

  - Profile picture (initials if no photo)
  - Name and title/role
  - Email and phone
  - Location
  - Key skills (tags)
  - Profile type indicator (client/candidate)
  - Last activity date
  - Quick actions (edit, view, message)

- [ ] **Empty State:**
  - Illustration
  - "No contacts yet" message
  - "Add your first contact" CTA

**Mobile Layout:**

- Full-width cards
- Swipe actions
- Bottom sheet for filters

### 3.2 Contact Detail (`/contacts/:id`)

**Purpose:** View and edit individual contact information

**Key Elements:**

- [ ] **Header:**

  - Contact name and photo
  - Profile type toggle (client/candidate)
  - Edit and delete buttons
  - Share/export options

- [ ] **Profile Toggle:**

  - Toggle switch between "Client Profile" and "Candidate Profile"
  - Visual indicator of current mode
  - Context-aware information display

- [ ] **Basic Information:**

  - Name, email, phone
  - Location and timezone
  - Social media links
  - Notes section

- [ ] **Client Profile Section** (when in client mode):

  - Company association
  - Role in company
  - Budget range
  - Decision authority level
  - Preferred contact method
  - Client-specific notes

- [ ] **Candidate Profile Section** (when in candidate mode):

  - Skills and experience
  - Years of experience
  - Availability status
  - Salary expectations
  - Preferred job types
  - Candidate-specific notes

- [ ] **Related Items:**

  - Associated jobs (if candidate)
  - Associated projects (if client)
  - Recent communications
  - Documents and files

- [ ] **Quick Actions:**
  - Send message
  - Schedule meeting
  - Add to job (if candidate)
  - Create project (if client)

**Mobile Layout:**

- Tabbed interface for different sections
- Bottom action bar
- Swipe navigation between profiles

### 3.3 Add/Edit Contact (`/contacts/new` or `/contacts/:id/edit`)

**Purpose:** Create or modify contact information

**Key Elements:**

- [ ] **Form Sections:**

  - Basic Information (name, email, phone, location)
  - Profile Type Selection (client/candidate)
  - Client-specific fields (company, role, budget)
  - Candidate-specific fields (skills, experience, availability)
  - Notes and additional information

- [ ] **Form Features:**

  - Real-time validation
  - Auto-save functionality
  - Progress indicator
  - Cancel and save buttons
  - Form field help text

- [ ] **Smart Features:**
  - Auto-complete for company names
  - Skill tag input with suggestions
  - Location autocomplete
  - Email validation

**Mobile Layout:**

- Step-by-step form
- Large input fields
- Keyboard-optimized inputs

---

## 4. Job Management

### 4.1 Job List (`/jobs`)

**Purpose:** Browse and manage all job postings

**Key Elements:**

- [ ] **Header:**

  - "Jobs" title
  - Search and filters
  - "Create Job" button
  - View toggle (list/board)

- [ ] **Search & Filters:**

  - Search by title, company, location
  - Filter by: status (open, closed, draft), location, salary range
  - Sort by: date posted, title, company
  - Status filter chips

- [ ] **Job Cards:**

  - Job title and company
  - Location and salary range
  - Key requirements (tags)
  - Status indicator (open/closed/draft)
  - Posted date
  - Number of applicants
  - Quick actions (edit, view, close)

- [ ] **Board View Option:**
  - Kanban-style layout
  - Columns: Draft, Open, In Review, Closed
  - Drag-and-drop job cards

**Mobile Layout:**

- Full-width cards
- Status-based color coding
- Swipe actions

### 4.2 Job Detail (`/jobs/:id`)

**Purpose:** View and manage individual job posting

**Key Elements:**

- [ ] **Header:**

  - Job title and company
  - Status badge (open/closed/draft)
  - Edit and delete buttons
  - Share/export options

- [ ] **Job Information:**

  - Title and company
  - Location and salary range
  - Job description
  - Requirements list
  - Benefits and perks
  - Application instructions

- [ ] **Matching Candidates Section:**

  - "Top Matches" heading
  - Candidate cards with match percentage
  - Skills alignment indicators
  - Quick actions (view profile, tag candidate)
  - "View All Matches" button

- [ ] **Applications Section:**

  - List of candidates who applied
  - Application status tracking
  - Application date
  - Quick actions (review, schedule interview)

- [ ] **Job Actions:**
  - Edit job posting
  - Close/open job
  - Duplicate job
  - Share job posting

**Mobile Layout:**

- Tabbed interface
- Collapsible sections
- Bottom action bar

### 4.3 Create/Edit Job (`/jobs/new` or `/jobs/:id/edit`)

**Purpose:** Create or modify job postings

**Key Elements:**

- [ ] **Form Sections:**

  - Basic Information (title, company, location)
  - Job Details (description, requirements)
  - Compensation (salary range, benefits)
  - Application Settings (deadline, instructions)
  - Status and visibility

- [ ] **Form Features:**

  - Rich text editor for description
  - Tag input for requirements
  - Auto-save functionality
  - Preview mode
  - Form validation

- [ ] **Smart Features:**
  - Company autocomplete
  - Requirement suggestions
  - Salary range validation
  - Template selection

**Mobile Layout:**

- Step-by-step form
- Simplified rich text editor
- Auto-save indicators

---

## 5. Matching Interface

### 5.1 Job-Candidate Matching (`/matches`)

**Purpose:** View and manage job-candidate matches

**Key Elements:**

- [ ] **Header:**

  - "Job Matches" title
  - Filter options (by job, by candidate)
  - Match quality filter
  - Sort options

- [ ] **Match Cards:**

  - Job title and candidate name
  - Match percentage (0-100%)
  - Skills alignment visualization
  - Location compatibility
  - Salary range alignment
  - Quick actions (view details, tag candidate, schedule interview)

- [ ] **Match Details:**

  - Skills breakdown
  - Experience alignment
  - Location match
  - Salary compatibility
  - Why this match works

- [ ] **Actions:**
  - Tag candidate to job
  - Schedule interview
  - Send message
  - View full profiles

**Mobile Layout:**

- Full-width match cards
- Swipe to reveal actions
- Bottom sheet for match details

---

## 6. Settings & Profile

### 6.1 User Settings (`/settings`)

**Purpose:** Manage user account and preferences

**Key Elements:**

- [ ] **Profile Section:**

  - Profile picture upload
  - Name and email
  - Role and permissions
  - Timezone and language

- [ ] **Account Settings:**

  - Password change
  - Email preferences
  - Notification settings
  - Privacy settings

- [ ] **App Preferences:**

  - Default view settings
  - Search preferences
  - Display options
  - Keyboard shortcuts

- [ ] **Team Settings** (admin only):
  - User management
  - Role assignments
  - System settings

**Mobile Layout:**

- Tabbed interface
- Full-width form sections
- Large touch targets

---

## 7. Navigation & Layout

### 7.1 Main Layout

**Purpose:** Consistent navigation and structure

**Key Elements:**

- [ ] **Sidebar Navigation:**

  - Logo and brand
  - Main navigation items
  - Collapsible sections
  - User profile section
  - Logout option

- [ ] **Top Header:**

  - Breadcrumb navigation
  - Search bar (global)
  - Notifications bell
  - User menu
  - Mobile menu toggle

- [ ] **Mobile Navigation:**
  - Bottom navigation bar
  - Floating action button
  - Swipe gestures
  - Pull-to-refresh

### 7.2 Responsive Breakpoints

- **Mobile**: 320px - 768px
- **Tablet**: 768px - 1024px
- **Desktop**: 1024px+

---

## 8. Component Library

### 8.1 Reusable Components

- [ ] **Buttons**: Primary, secondary, ghost, danger variants
- [ ] **Cards**: Contact, job, match, metric cards
- [ ] **Forms**: Input fields, textareas, selects, checkboxes
- [ ] **Navigation**: Sidebar, breadcrumbs, tabs
- [ ] **Feedback**: Loading states, error messages, success notifications
- [ ] **Data Display**: Tables, lists, tags, badges
- [ ] **Modals**: Confirmation dialogs, forms, details
- [ ] **Search**: Search bars, filters, autocomplete

### 8.2 Interactive Elements

- [ ] **Profile Toggle**: Switch between client/candidate views
- [ ] **Match Score**: Visual percentage indicator
- [ ] **Skill Tags**: Editable skill chips
- [ ] **Status Badges**: Job and application status indicators
- [ ] **Quick Actions**: Context-sensitive action buttons

---

## 9. User Experience Guidelines

### 9.1 Mobile-First Design

- Touch-friendly interface (44px minimum touch targets)
- Gesture-based interactions
- Optimized for one-handed use
- Fast loading and smooth animations

### 9.2 Accessibility

- WCAG 2.1 AA compliance
- Keyboard navigation support
- Screen reader compatibility
- High contrast mode support
- Focus indicators

### 9.3 Performance

- Fast page loads (< 2 seconds)
- Smooth animations (60fps)
- Optimized images and assets
- Progressive loading

### 9.4 Error Handling

- Clear error messages
- Helpful recovery suggestions
- Graceful degradation
- Offline state handling

---

## 10. Design Deliverables

### 10.1 For UX Pilot

- [ ] High-fidelity mockups for all core screens
- [ ] Mobile and desktop versions
- [ ] Component library and design system
- [ ] User flow diagrams
- [ ] Interactive prototypes

### 10.2 For Development Handoff

- [ ] Design specifications
- [ ] Component documentation
- [ ] Asset exports (icons, images)
- [ ] CSS variables and tokens
- [ ] Responsive breakpoints

This UI development plan provides a comprehensive foundation for designing the core MVP screens with UX Pilot, ensuring a consistent and user-friendly experience across all devices.

---

## 📋 Quick Summary (UX Pilot Brief)

**Core Screens (6 categories):**

1. Auth (login/register)
2. Dashboard (metrics/actions)
3. Contacts (list/detail/add)
4. Jobs (list/detail/create)
5. Matches (job-candidate)
6. Settings (user preferences)

**Key Features:**

- Mobile-first responsive design
- Dual-profile toggle (client/candidate)
- Match scoring (0-100%)
- Blue color scheme (#2563eb)
- Inter font family
- Card-based layouts

**Deliverables:** High-fidelity mockups, component library, mobile/desktop versions, interactive prototypes.
