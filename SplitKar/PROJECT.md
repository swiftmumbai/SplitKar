# Bill Split App - Product Requirements Document

## Executive Summary

**Product Name:** SplitGlass  
**Platform:** iOS 17+  
**Timeline:** 2 hours (4 developers)  
**Tech Stack:** SwiftUI, SwiftData, iCloud  
**Design Language:** Liquid Glass Morphism  

**One-liner:** A gorgeous bill splitting app that makes splitting expenses with friends feel premium and effortless.

---

## Problem Statement

Splitting bills with friends is annoying:
- Mental math is tedious
- Venmo requests feel impersonal
- Tracking who owes what gets messy
- Most apps are ugly and complex

**Solution:** A beautiful, dead-simple app that calculates optimal settlements and makes the experience delightful.

---

## Target Users

- **Primary:** Young professionals (22-35) splitting dinner, trips, rent
- **Secondary:** Roommates tracking shared expenses
- **Tertiary:** Friend groups on vacation

**Key Insight:** Users want the math done for them without thinking. The UI should feel like a luxury product.

---

## Core Features (MVP)

### 1. People Management
**What:** Add/remove people in your split group

**Features:**
- ➕ Add person with name
- 🎨 Assign color to each person (6 preset options)
- 🗑️ Swipe to delete person
- 👥 View all people in group
- 📝 Edit person name/color

**Why:** Need to know who's in the group before tracking expenses

**Success Metric:** Can add 4 people in under 30 seconds

---

### 2. Expense Tracking
**What:** Log who paid for what

**Features:**
- 💰 Enter amount (USD, formatted as currency)
- 📝 Add description ("Dinner at Nobu")
- 👤 Select who paid
- 📅 Set date (defaults to today)
- ✅ Validation (amount > 0, description required)
- 🗑️ Swipe to delete expense

**User Flow:**
1. Tap floating "+" button
2. Enter amount
3. Type what it was for
4. Pick who paid
5. Tap "Save"

**Why:** Core data input - needs to be fast and obvious

**Success Metric:** Can log expense in under 15 seconds

---

### 3. Expense Dashboard
**What:** See all expenses at a glance

**Features:**
- 📊 Summary card showing:
  - Total spent
  - Amount per person
  - Number of expenses
- 📜 Scrollable feed of expense cards showing:
  - Who paid (name + color dot)
  - Amount (large, prominent)
  - Description
  - Date
- 🔄 Pull to refresh (smooth animation)
- 🚫 Empty state with call-to-action
- 🗑️ Swipe to delete

**Layout Priority:**
1. Summary (sticky at top)
2. Recent expenses (newest first)

**Why:** Quick overview of group spending before settling up

**Success Metric:** User understands total and per-person cost in 3 seconds

---

### 4. Settlement Calculator
**What:** Show who owes whom with minimum transactions

**Features:**
- 🧮 Auto-calculate net balances
- ♻️ Minimize number of transactions
- 💳 Display settlements as:
  - "{Alice} owes {Bob} $25.50"
  - Both names with color indicators
- ✅ "All settled!" state when balanced
- 🔢 Show "Settle in X payments"

**Algorithm:**
1. Calculate what each person paid
2. Calculate fair share (total ÷ people count)
3. Compute net balance per person
4. Match debtors with creditors optimally
5. Output minimum transactions

**Example:**
- Alice paid $100
- Bob paid $50  
- Charlie paid $0
- Total: $150 ÷ 3 = $50 each

**Settlements:**
- Charlie owes Alice $50
- Bob owes Alice $0 (already paid fair share)

**Why:** Users want the simplest path to settle debts

**Success Metric:** Algorithm produces minimum transactions 100% of time

---

## Design System

### Visual Language: Liquid Glass Morphism

**Aesthetic Goals:**
- Premium, modern, tactile
- Feels like holding frosted glass
- Smooth, fluid animations
- Calm but energetic color palette

### Components

#### 1. GlassCard
- Material: `.ultraThinMaterial`
- Gradient overlay: white 25% → 5% opacity
- Corner radius: 20pt
- Shadow: subtle, 10pt blur
- Padding: 20pt

#### 2. GlassButton
- Same glass effect as card
- Scale animation on press (0.95)
- Haptic feedback on tap
- Tappable area: min 44x44pt

#### 3. GlassTextField
- Transparent background with glass effect
- Custom font: SF Pro Rounded
- Padding: 16pt vertical, 20pt horizontal
- Clear button when editing

### Color Palette

**Background Gradient:**
- Start: `#667eea` (blue-purple)
- End: `#764ba2` (deep purple)
- Direction: top-leading → bottom-trailing

**Person Colors (Presets):**
1. 🟣 Purple: `#9D50BB`
2. 🔵 Blue: `#6E8EFB`
3. 🟢 Green: `#4ECDC4`
4. 🩷 Pink: `#FF6B9D`
5. 🟠 Orange: `#FFA344`
6. 🔴 Red: `#FF5370`

**Text:**
- Primary: White 100%
- Secondary: White 70%
- Disabled: White 40%

### Typography

- **Display (amounts):** SF Pro Rounded Bold, 32pt
- **Headline:** SF Pro Rounded Semibold, 20pt
- **Body:** SF Pro, 17pt
- **Caption:** SF Pro, 14pt

### Spacing Scale
- xs: 4pt
- sm: 8pt
- md: 16pt
- lg: 24pt
- xl: 32pt

### Animations

**Principles:**
- Spring physics (response: 0.3, dampingFraction: 0.7)
- Never instant - everything eases
- Haptics on state changes
- Stagger list item appearances

**Examples:**
- Button tap: scale + haptic
- Card appear: slide up + fade in
- Delete: swipe + fade out
- Sheet present: spring from bottom

---

## Technical Architecture

### Data Layer: SwiftData

**Models:**

```
Person
├── id: UUID
├── name: String
├── colorHex: String
└── expenses: [Expense] (relationship)

Expense
├── id: UUID
├── amount: Double
├── desc: String
├── date: Date
└── payer: Person (relationship)
```

**Container Configuration:**
- Enable iCloud sync via CloudKit
- Automatic saves enabled
- ModelContext injected via environment

**Data Operations:**
- Use `@Query` for reactive UI updates
- `modelContext.insert()` for creates
- `modelContext.delete()` for deletes
- Direct property edits for updates

### View Architecture

**Structure:**
```
App
├── TabView
    ├── ExpenseListView (primary tab)
    ├── SettlementView (secondary tab)
    └── PersonListView (tertiary tab)
```

**State Management:**
- SwiftData `@Query` for data-driven UI
- `@State` for local view state
- `@Environment(\.modelContext)` for mutations
- No external state management needed

### iCloud Sync

**Setup:**
1. Enable iCloud capability
2. Add CloudKit container identifier
3. Configure ModelContainer with cloud option
4. SwiftData handles sync automatically

**Conflict Resolution:**
- Last write wins (SwiftData default)
- No manual merge needed for MVP

---

## User Flows

### Flow 1: First Time User
1. Opens app → sees empty state
2. Taps "Add People" → adds Alice, Bob, Charlie
3. Taps "+" → adds first expense
4. Views dashboard → sees summary
5. Taps "Settle" tab → sees who owes whom

**Time:** ~90 seconds

### Flow 2: Add Expense (Returning User)
1. Opens app → sees existing expenses
2. Taps floating "+" button
3. Enters: $45.00, "Pizza", Alice paid
4. Taps Save
5. Returns to list → sees new expense at top
6. Settlements auto-update

**Time:** ~15 seconds

### Flow 3: Settle Debts
1. Opens "Settle" tab
2. Views: "Bob owes Alice $23.00"
3. Sends Venmo/pays in person
4. (Future: tap checkmark to mark settled)

**Time:** ~5 seconds to view

---

## Out of Scope (v1)

❌ **Not Building:**
- User accounts / authentication
- Multi-group support (only one group per device)
- Payment integration (Venmo, PayPal)
- Receipt scanning / OCR
- Tax/tip calculators
- Currency conversion
- Expense categories
- Recurring expenses
- Export to CSV
- Push notifications
- Shared group links

**Why:** 2-hour constraint requires ruthless prioritization. These are v2 features.

---

## Success Criteria

### Functional Requirements
✅ Add/delete people  
✅ Add/delete expenses with validation  
✅ View expense list with summary  
✅ Calculate settlements with minimum transactions  
✅ Data persists across app restarts  
✅ iCloud sync works (if testable)  

### Non-Functional Requirements
✅ UI feels premium and polished  
✅ Animations are smooth (60fps)  
✅ No crashes or major bugs  
✅ Responds instantly to user input  
✅ Works on iPhone 15 Pro (primary test device)  

### Quality Bar
- **Code quality:** Clean, readable, follows SwiftUI best practices
- **Design quality:** Every screen uses glass components consistently
- **UX quality:** No confusion - user understands app in 30 seconds

---

## Development Constraints

**Time:** 2 hours total  
**Team:** 4 developers working in parallel  
**Stack:** SwiftUI + SwiftData only (no external dependencies)  
**Target:** iOS 17+ (iPhone only, no iPad optimization)

**Risk Mitigation:**
- Developer 1 (Design System) finishes first - others depend on it
- Developer 1 acts as merge master for git conflicts
- Test incrementally - don't wait until the end
- Cut features if behind schedule, not quality

---

## Team Task Distribution

### Developer 1: Design System & Foundation (30 min, then support)
**Priority:** HIGHEST - Others are blocked without this

**Deliverables:**
1. **Design System Components** (20 min)
   - `GlassCard.swift` - Reusable glass card component
   - `GlassButton.swift` - Glass effect button with haptics
   - `GlassTextField.swift` - Custom text input with glass styling
   - `ColorPalette.swift` - App color constants
   - `Typography.swift` - Font styles and modifiers
   - `Spacing.swift` - Spacing constants

2. **SwiftData Models** (10 min)
   - `Person.swift` - Person model with SwiftData
   - `Expense.swift` - Expense model with relationships
   - Configure ModelContainer in App file

3. **Post-completion tasks:**
   - Act as git merge master
   - Help debug integration issues
   - Test final build

**Dependencies:** None  
**Blockers for:** Everyone

---

### Developer 2: People Management & Core UI (60 min)
**Priority:** HIGH - Required for expense tracking

**Deliverables:**
1. **PersonListView** (25 min)
   - Display list of all people with colors
   - Glass card design for each person
   - Swipe to delete functionality
   - Empty state UI

2. **AddPersonSheet** (20 min)
   - Sheet presentation for adding person
   - Name text field with validation
   - Color picker (6 preset colors)
   - Save/Cancel buttons
   - Form validation

3. **Person Color Picker Component** (15 min)
   - Custom color selection UI
   - Show 6 preset colors in grid
   - Highlight selected color
   - Glass styling

**Dependencies:** Developer 1 (Design System, Person model)  
**Estimated Start:** After 30 minutes

---

### Developer 3: Expense Tracking & Dashboard (60 min)
**Priority:** HIGH - Core feature

**Deliverables:**
1. **ExpenseListView** (25 min)
   - Main dashboard view
   - Summary card at top (total, per person, count)
   - Scrollable expense feed
   - Empty state with CTA
   - Pull to refresh

2. **AddExpenseSheet** (25 min)
   - Amount input (currency formatted)
   - Description text field
   - Date picker (default: today)
   - Person picker dropdown
   - Validation (amount > 0, description required)
   - Save/Cancel buttons

3. **ExpenseCardView** (10 min)
   - Display single expense
   - Show payer name with color dot
   - Format amount prominently
   - Show description and date
   - Swipe to delete

**Dependencies:** Developer 1 (Design System, Expense/Person models)  
**Estimated Start:** After 30 minutes

---

### Developer 4: Settlement Calculator & App Shell (60 min)
**Priority:** MEDIUM - Can be completed last

**Deliverables:**
1. **Settlement Calculator Logic** (20 min)
   - `SettlementCalculator.swift` utility class
   - Algorithm to compute net balances
   - Minimize transactions using greedy algorithm
   - Return array of Settlement structs
   - Unit tests for algorithm

2. **SettlementView** (30 min)
   - Tab view showing settlements
   - Display "X owes Y $Z.ZZ" cards
   - Show payer/payee with color indicators
   - "All settled!" state when balanced
   - Glass card styling

3. **App Navigation Shell** (10 min)
   - TabView with 3 tabs
   - Tab icons and labels
   - Wire up all views
   - Configure tab styling

**Dependencies:** Developer 1 (Design System, models)  
**Can start:** After 30 minutes (calculator logic), after 60 min (UI)

---

## Timeline Overview

### Minutes 0-30: Foundation Phase
- ✅ Developer 1: Design system + models
- ⏸️ Developers 2, 3, 4: Review design specs, plan implementation

### Minutes 30-60: Parallel Feature Development
- ✅ Developer 1: Code review, merge support
- ✅ Developer 2: People management
- ✅ Developer 3: Expense tracking
- ✅ Developer 4: Settlement calculator

### Minutes 60-90: Integration & Polish
- ✅ Developer 1: Integration testing
- ✅ Developer 2: Polish animations, handle edge cases
- ✅ Developer 3: Polish dashboard UI
- ✅ Developer 4: Complete settlements UI

### Minutes 90-120: Testing & Bug Fixes
- ✅ All: Run acceptance tests
- ✅ All: Fix critical bugs
- ✅ All: Final polish and animations
- ✅ Developer 1: Final build and demo prep

---

## Git Workflow

### Branch Strategy
- `main` - Production releases
- `develop` - Integration branch
- `feature/design-system` - Developer 1
- `feature/people-management` - Developer 2
- `feature/expense-tracking` - Developer 3
- `feature/settlements` - Developer 4

### Merge Order
1. **First:** `feature/design-system` → `develop` (min 30)
2. **Then:** All others create PRs against `develop`
3. **Developer 1** reviews and merges all PRs
4. **Final:** `develop` → `main` when complete

### Commit Guidelines
- Commit frequently (every 15 min)
- Use descriptive messages
- Push to remote regularly
- Don't force push to shared branches

---

## Acceptance Test Plan

### Test Scenario 1: Basic Flow
1. Launch app
2. Add 3 people with different colors
3. Add 5 expenses with different payers
4. Verify summary shows correct totals
5. Check settlements tab calculates correctly
6. Delete an expense
7. Verify settlements update

**Pass Criteria:** All steps work without crashes

### Test Scenario 2: Edge Cases
1. Try to save expense with $0 amount → blocked
2. Try to save expense with empty description → blocked
3. Delete all people → appropriate empty state
4. Add expense when no people exist → gracefully handled
5. View settlements with no expenses → shows "All settled"

**Pass Criteria:** Validation works, no crashes

### Test Scenario 3: Data Persistence
1. Add people and expenses
2. Force quit app
3. Relaunch