# Task List: Perspective Shift Web Application

**Generated from:** `prd-perspective-shift.md` + `drd-perspective-shift.md` + `trd-perspective-shift.md`  
**Date:** 2025-09-08  
**Complexity Budget:** 32 points  
**Estimated Complexity:** 30 points  
**Slices:** 6 vertical slices

## Requirements Integration

### Business Requirements (from PRD)
- **Core user value:** Help users reframe personal struggles through AI-generated inspirational quotes and actionable insights
- **Key features:** Single-page app, OpenAI o1-mini integration, 3 quotes + reframed perspective, copy-to-markdown, shareable links
- **Success metrics:** Sharing frequency of generated responses
- **Privacy-first:** No user tracking, anonymous usage, minimal data collection

### Design Requirements (from DRD)
- **Component architecture:** Input Phase → Results Phase with gradient background, glass morphism cards
- **User experience patterns:** Replace input form entirely with results, skeleton loading, individual copy buttons per quote
- **Visual complexity:** Warm pink to purple gradient, Inter typography, touch-first mobile optimization with 48px touch targets
- **Responsive requirements:** Mobile-first design optimized for one-handed usage

### Technical Requirements (from TRD)
- **System architecture:** Next.js 15 + Vercel + Supabase + OpenAI o1-mini, serverless edge functions
- **Data requirements:** SharedPerspective + PerspectiveQuote tables with RLS policies, UUID-based sharing
- **Integration requirements:** OpenAI o1-mini API with moderation, cost optimization, retry logic, rate limiting
- **Performance constraints:** Core Web Vitals targets (LCP < 2.5s, FID < 100ms, CLS < 0.1), <$25/month operational costs

### 🧪 Testing Requirements (Mandatory)
- **TDD approach:** All slices follow Red-Green-Refactor cycle with tests written first
- **Test pyramid:** Unit tests → Integration tests → E2E Playwright testing required
- **Playwright testing:** Mandatory for web UI with screenshots of all states and responsive breakpoints
- **Validation framework:** Multi-agent validation for each slice completion (Architecture + TDD + UI Testing + Cleanup)

### 🔍 Validation Requirements (Mandatory)
- **Architecture validation:** Technical implementation review against TRD specifications
- **TDD validation:** Test-first development compliance verification
- **UI testing validation:** Playwright test execution with screenshots matching DRD design specifications
- **Cleanup validation:** Repository integrity and workspace cleanliness verification
- **Retrospective requirement:** Learning capture and documentation after each slice completion

## Integrated Complexity Assessment

### Combined Requirements Analysis
- **Business Complexity (PRD):** 8 points for core AI-driven functionality
- **Design Complexity (DRD):** 6 points for gradient UI, responsive design, phase transitions
- **Technical Complexity (TRD):** 8 points for Next.js + Supabase + OpenAI architecture
- **🧪 Testing Complexity:** 6 points for TDD, Playwright, integration test pyramid
- **🔍 Validation Complexity:** 2 points for multi-agent validation overhead
- **Total Estimated:** 30 points
- **Available Budget:** 32 points ✅ **Within Budget** (2 points buffer)

### Layer-by-Layer Breakdown
- **Layer 0 (Static):** ✅ Included - DRD gradient background, glass morphism, typography system
- **Layer 1 (Interactive):** ✅ Included - DRD form interactions, state transitions, validation patterns
- **Layer 2 (Persistent):** ✅ Included - TRD database schema, RLS policies, UUID sharing
- **Layer 3 (Integrated):** ✅ Included - TRD OpenAI integration, moderation, retry logic
- **Layer 4 (Orchestrated):** ✅ Included - Performance optimization, monitoring, production deployment

### Simplification Strategy (Circuit Breakers Available)
- **Design Fallbacks:** Solid background if gradient performance issues, system fonts if Inter fails to load
- **Technical Fallbacks:** Mock AI responses if OpenAI fails, localStorage if Supabase unavailable
- **Scope Reductions:** All core features included within budget, advanced monitoring simplified

## Relevant Files by Slice

### Slice 0: Static UI (Complexity: 1, Total: 1)
- `package.json` - Next.js 15 + dependencies
- `tailwind.config.js` - DRD color system and design tokens
- `app/layout.tsx` - Root layout with Inter font and gradient background
- `app/page.tsx` - Home page with static mockup of both phases
- `app/globals.css` - Tailwind base styles and DRD design system
- `components/ui/Button.tsx` - Reusable button component
- `components/ui/Card.tsx` - Glass morphism card component
- `components/forms/PerspectiveForm.tsx` - Static form mockup
- `components/display/QuoteCard.tsx` - Static quote card mockup
- `components/display/PerspectiveCard.tsx` - Static perspective display mockup

### Slice 1: Interactive State (Complexity: 2, Total: 3)
- `hooks/usePerspectiveForm.ts` - Form state management
- `components/forms/PerspectiveForm.tsx` - Interactive form with validation
- `components/ui/LoadingSkeleton.tsx` - DRD skeleton loading components
- `lib/validation.ts` - Zod schemas for input validation
- `components/ui/Toast.tsx` - Success/error feedback component

### Slice 2: Persistent Storage (Complexity: 4, Total: 7)
- `lib/database.ts` - Supabase client configuration
- `lib/supabase.ts` - Database helper functions
- `app/api/perspectives/route.ts` - Create perspective API endpoint
- `app/api/perspectives/[id]/route.ts` - Get perspective API endpoint
- `app/share/[id]/page.tsx` - Shared perspective view page
- `types/perspective.ts` - TypeScript types for data models

### Slice 3: AI Integration (Complexity: 8, Total: 15)
- `lib/ai-service.ts` - OpenAI o1-mini integration with retry logic
- `lib/moderation.ts` - Content moderation service
- `app/api/perspectives/route.ts` - Updated with AI generation
- `lib/utils.ts` - Helper functions for prompt optimization
- `types/ai.ts` - AI service TypeScript types

### Slice 4: Copy & Share Features (Complexity: 8, Total: 23)
- `hooks/useClipboard.ts` - Copy-to-clipboard functionality
- `components/display/QuoteCard.tsx` - Updated with copy buttons
- `components/display/ShareButton.tsx` - Share link generation
- `lib/markdown.ts` - Markdown formatting utilities
- `components/ui/Toast.tsx` - Updated with copy feedback

### Slice 5: Performance & Monitoring (Complexity: 9, Total: 32)
- `app/api/health/route.ts` - Health check endpoint
- `lib/metrics.ts` - Performance tracking utilities
- `lib/error-tracking.ts` - Error logging service
- `middleware.ts` - Rate limiting and security headers
- `vercel.json` - Deployment configuration
- `.env.example` - Environment variables template

## Vertical Slices

### ✓ Slice 0: "See It" - Static Perspective Shift UI (Complexity: 1, Running Total: 1)

**Goal:** Deploy working URL with complete UI following DRD design specifications  
**Demo:** User can navigate to URL and see both Input Phase and Results Phase mockups with DRD gradient background and glass morphism  
**🧪 TDD Requirements:** Component tests written first, Playwright screenshots taken of all UI states and responsive breakpoints  
**🔍 Validation Requirements:** Architecture + TDD + UI Testing + Cleanup validation required  
**Definition of Done:** Deployed to Vercel, all DRD UI elements visible with proper responsive behavior, all tests pass, validation agents approve  
**Driven by:** DRD component architecture, visual design system, and responsive specifications

#### Implementation Tasks:
- [ ] 0.1 🧪 **TDD RED:** Write failing component tests for layout, button, and card components
- [ ] 0.2 **TDD GREEN:** Initialize Next.js 15 project with App Router and TypeScript configuration
- [ ] 0.3 **TDD GREEN:** Configure Tailwind CSS with DRD color system (#FF8FB1 to #C8A8E9 gradient, Inter font)
- [ ] 0.4 **TDD GREEN:** Create root layout with DRD gradient background and Inter font loading
- [ ] 0.5 **TDD GREEN:** Build Button component with DRD specifications (primary/copy variants, 48px touch targets)
- [ ] 0.6 **TDD GREEN:** Build Card component with DRD glass morphism styling (backdrop-blur, rgba backgrounds)
- [ ] 0.7 **TDD GREEN:** Create static PerspectiveForm component matching DRD Input Phase design
- [ ] 0.8 **TDD GREEN:** Create static QuoteCard and PerspectiveCard components matching DRD Results Phase design
- [ ] 0.9 **TDD GREEN:** Implement DRD responsive breakpoints (320px-479px, 480px-767px, 768px-1023px, 1024px+)
- [ ] 0.10 **TDD GREEN:** Add mock data showing 3 quotes with author bios and reframed perspective
- [ ] 0.11 🎭 **Playwright:** Take screenshots of Input Phase, Results Phase, and all responsive breakpoints
- [ ] 0.12 **Deploy:** Deploy to Vercel and verify production URL works correctly
- [ ] 0.13 🔧 **TDD REFACTOR:** Optimize component structure and CSS for performance while keeping tests green
- [ ] 0.14 🔍 **Validation:** Run multi-agent validation (Architecture + TDD + UI Testing + Cleanup)

**Circuit Breaker:** If DRD gradient causes performance issues → Use solid background color from DRD palette  
**Circuit Breaker:** If Inter font fails to load → Use system font stack as DRD specifies

---

### ✓ Slice 1: "Use It" - Interactive Form Experience (Complexity: 2, Running Total: 3)

**Goal:** Make UI functional following DRD user flow specifications with client-side state management  
**Demo:** User can complete DRD Input Phase → Results Phase transition with form validation and loading states  
**🧪 TDD Requirements:** Interaction tests written first, Playwright user flow testing covering form submission and transitions  
**🔍 Validation Requirements:** Architecture + TDD + UI Testing + UX Evaluation + Cleanup validation required  
**Definition of Done:** All DRD interaction patterns work (form validation, phase transitions, loading states), tests pass, validation approved  
**Driven by:** DRD user flows, state diagrams, and interaction patterns

#### Implementation Tasks:
- [ ] 1.1 🧪 **TDD RED:** Write failing tests for form validation, state transitions, and loading states
- [ ] 1.2 **TDD GREEN:** Create Zod validation schemas (10-2000 characters, content moderation checks)
- [ ] 1.3 **TDD GREEN:** Implement usePerspectiveForm hook with DRD state management (InputReady → Validating → Loading → ResultsReady)
- [ ] 1.4 **TDD GREEN:** Add real-time character counting and validation per DRD form specifications
- [ ] 1.5 **TDD GREEN:** Create LoadingSkeleton component matching DRD loading patterns (skeleton cards for quotes and perspective)
- [ ] 1.6 **TDD GREEN:** Implement DRD phase transition (Input Phase completely replaced by Results Phase)
- [ ] 1.7 **TDD GREEN:** Add error handling with DRD error state designs (inline validation messages, retry patterns)
- [ ] 1.8 **TDD GREEN:** Create Toast component for DRD micro-interaction feedback
- [ ] 1.9 **TDD GREEN:** Implement "New Perspective" button to return to Input Phase per DRD navigation patterns
- [ ] 1.10 🎭 **Playwright:** Test complete user flow from input through results and back to input
- [ ] 1.11 🔧 **TDD REFACTOR:** Optimize state management and transitions for smooth 60fps animations
- [ ] 1.12 🔍 **Validation:** Run multi-agent validation (Architecture + TDD + UI Testing + UX Evaluation + Cleanup)

**Circuit Breaker:** If DRD transitions too complex → Use instant state changes instead of smooth animations  
**Circuit Breaker:** If form validation complex → Simplify to basic required field checking

---

### ✓ Slice 2: "Store It" - Persistent Shareable Links (Complexity: 4, Running Total: 7)

**Goal:** Data persists following TRD data architecture with permanent shareable links  
**Demo:** Generated perspectives save to database and can be accessed via shareable URLs by others  
**🧪 TDD Requirements:** Database and API tests written first, integration testing between frontend and backend  
**🔍 Validation Requirements:** Architecture + TDD + UI Testing + Cleanup validation required  
**Definition of Done:** TRD database schema implemented, RLS policies active, shareable links work permanently  
**Driven by:** TRD data models, API design, and security specifications

#### Implementation Tasks:
- [ ] 2.1 🧪 **TDD RED:** Write failing API tests for perspective creation and retrieval endpoints
- [ ] 2.2 **TDD GREEN:** Set up Supabase project and configure environment variables per TRD specifications
- [ ] 2.3 **TDD GREEN:** Implement TRD database schema (shared_perspectives + perspective_quotes tables with UUID PKs)
- [ ] 2.4 **TDD GREEN:** Configure TRD RLS policies (public read for active perspectives, anonymous insert)
- [ ] 2.5 **TDD GREEN:** Create database helper functions with proper error handling
- [ ] 2.6 **TDD GREEN:** Build POST /api/perspectives endpoint for creating perspectives (returns perspective ID)
- [ ] 2.7 **TDD GREEN:** Build GET /api/perspectives/[id] endpoint for retrieving shared perspectives
- [ ] 2.8 **TDD GREEN:** Create /share/[id] page for public access to shared perspectives
- [ ] 2.9 **TDD GREEN:** Update form to save data to database instead of local state
- [ ] 2.10 **TDD GREEN:** Implement shareable URL generation and display
- [ ] 2.11 **TDD GREEN:** Add database indexes per TRD performance specifications
- [ ] 2.12 🎭 **Playwright:** Test end-to-end sharing flow (create → share → access shared link)
- [ ] 2.13 🔧 **TDD REFACTOR:** Optimize database queries and API response structure
- [ ] 2.14 🔍 **Validation:** Run multi-agent validation (Architecture + TDD + UI Testing + Cleanup)

**Circuit Breaker:** If Supabase setup complex → Use localStorage with URL encoding for sharing  
**Circuit Breaker:** If RLS policies cause issues → Simplify to basic public access model

---

### ✓ Slice 3: "Generate It" - AI Perspective & Quote Generation (Complexity: 8, Running Total: 15)

**Goal:** Core AI functionality using OpenAI o1-mini to generate quotes and reframed perspectives  
**Demo:** Real AI-generated content with content moderation, retry logic, and cost optimization  
**🧪 TDD Requirements:** AI service tests with mocked responses, error handling tests, integration tests  
**🔍 Validation Requirements:** Architecture + TDD + UI Testing + Cleanup validation required  
**Definition of Done:** OpenAI o1-mini integration working with TRD specifications (cost optimization, retry logic, moderation)  
**Driven by:** TRD AI service architecture, security requirements, and cost optimization strategies

#### Implementation Tasks:
- [ ] 3.1 🧪 **TDD RED:** Write failing tests for AI service, moderation service, and error handling
- [ ] 3.2 **TDD GREEN:** Set up OpenAI API configuration with o1-mini model per TRD specifications
- [ ] 3.3 **TDD GREEN:** Implement TRD AI service class with cost optimization (1500 token limit, prompt optimization)
- [ ] 3.4 **TDD GREEN:** Create TRD system prompt for generating exactly 3 quotes with author bios and reframed perspective
- [ ] 3.5 **TDD GREEN:** Implement OpenAI Moderation API integration per TRD content security requirements
- [ ] 3.6 **TDD GREEN:** Add TRD retry logic with exponential backoff for API failures
- [ ] 3.7 **TDD GREEN:** Create TRD error handling with user-friendly messages and circuit breakers
- [ ] 3.8 **TDD GREEN:** Implement TRD rate limiting (10 requests/minute, 100/day per IP)
- [ ] 3.9 **TDD GREEN:** Update perspective creation API to use real AI generation instead of mock data
- [ ] 3.10 **TDD GREEN:** Add request/response logging for debugging (without storing user input per privacy requirements)
- [ ] 3.11 **TDD GREEN:** Implement TRD cost monitoring and daily usage limits
- [ ] 3.12 🎭 **Playwright:** Test complete AI generation flow with various input types
- [ ] 3.13 🔧 **TDD REFACTOR:** Optimize prompts and token usage for cost efficiency
- [ ] 3.14 🔍 **Validation:** Run multi-agent validation (Architecture + TDD + UI Testing + Cleanup)

**Circuit Breaker:** If OpenAI costs too high → Use curated quote database with simple matching  
**Circuit Breaker:** If API unreliable → Implement fallback to static inspirational quotes

---

### ✓ Slice 4: "Share It" - Copy & Export Features (Complexity: 8, Running Total: 23)

**Goal:** Users can copy individual quotes to markdown and generate shareable links per DRD specifications  
**Demo:** Individual copy buttons per quote, toast feedback, markdown formatting, shareable URL generation  
**🧪 TDD Requirements:** Copy functionality tests, markdown generation tests, UI interaction tests  
**🔍 Validation Requirements:** Architecture + TDD + UI Testing + UX Evaluation + Cleanup validation required  
**Definition of Done:** DRD copy button specifications implemented, markdown export working, sharing flow complete  
**Driven by:** DRD individual copy buttons design, TRD sharing architecture, privacy-first principles

#### Implementation Tasks:
- [ ] 4.1 🧪 **TDD RED:** Write failing tests for clipboard functionality, markdown generation, and sharing features
- [ ] 4.2 **TDD GREEN:** Implement useClipboard hook with error handling and permission checks
- [ ] 4.3 **TDD GREEN:** Create markdown formatting utilities for quotes (proper quote attribution format)
- [ ] 4.4 **TDD GREEN:** Update QuoteCard component with DRD copy button specifications (green accent, success states)
- [ ] 4.5 **TDD GREEN:** Add individual copy functionality for each quote with toast feedback
- [ ] 4.6 **TDD GREEN:** Implement copy button success states per DRD (checkmark icon, "Copied!" text, 2-second revert)
- [ ] 4.7 **TDD GREEN:** Create ShareButton component for generating shareable links
- [ ] 4.8 **TDD GREEN:** Add share link copy functionality with different toast message
- [ ] 4.9 **TDD GREEN:** Implement proper markdown formatting for complete perspective export
- [ ] 4.10 **TDD GREEN:** Add error handling for clipboard permission failures with fallback text selection
- [ ] 4.11 **TDD GREEN:** Ensure sharing preserves DRD formatting and design when viewed by recipients
- [ ] 4.12 🎭 **Playwright:** Test all copy and share functionality across different browsers and devices
- [ ] 4.13 🔧 **TDD REFACTOR:** Optimize clipboard operations and markdown generation performance
- [ ] 4.14 🔍 **Validation:** Run multi-agent validation (Architecture + TDD + UI Testing + UX Evaluation + Cleanup)

**Circuit Breaker:** If Clipboard API unavailable → Fall back to text selection as specified in TRD  
**Circuit Breaker:** If markdown complex → Use plain text copying with quote attribution

---

### ✓ Slice 5: "Polish It" - Performance & Monitoring (Complexity: 9, Running Total: 32)

**Goal:** Production-ready performance optimization meeting TRD Core Web Vitals and monitoring requirements  
**Demo:** Health monitoring, error tracking, performance metrics, rate limiting, security headers  
**🧪 TDD Requirements:** Health endpoint tests, performance monitoring tests, security configuration tests  
**🔍 Validation Requirements:** Architecture + TDD + UI Testing + Cleanup validation required  
**Definition of Done:** TRD performance targets met (LCP < 2.5s, FID < 100ms, CLS < 0.1), monitoring active, under $25/month budget  
**Driven by:** TRD performance architecture, monitoring specifications, and cost optimization requirements

#### Implementation Tasks:
- [ ] 5.1 🧪 **TDD RED:** Write failing tests for health endpoint, metrics collection, and error tracking
- [ ] 5.2 **TDD GREEN:** Create health check API endpoint with database and OpenAI service status checks
- [ ] 5.3 **TDD GREEN:** Implement TRD privacy-first metrics collection (no user identification)
- [ ] 5.4 **TDD GREEN:** Add TRD error tracking with simple in-memory logging (no external services)
- [ ] 5.5 **TDD GREEN:** Configure Vercel deployment with TRD specifications (edge functions, timeouts, regions)
- [ ] 5.6 **TDD GREEN:** Implement TRD security headers (CSP, frame options, XSS protection)
- [ ] 5.7 **TDD GREEN:** Add TRD rate limiting using Vercel KV (10 requests/minute per IP)
- [ ] 5.8 **TDD GREEN:** Optimize DRD font loading with display:swap and preload strategies
- [ ] 5.9 **TDD GREEN:** Implement TRD bundle optimization (code splitting, tree shaking)
- [ ] 5.10 **TDD GREEN:** Add Web Vitals tracking (development-only logging per privacy requirements)
- [ ] 5.11 **TDD GREEN:** Configure proper caching headers per TRD caching strategy
- [ ] 5.12 🎭 **Playwright:** Performance testing to verify Core Web Vitals targets are met
- [ ] 5.13 🔧 **TDD REFACTOR:** Final performance optimizations and code cleanup
- [ ] 5.14 🔍 **Validation:** Run multi-agent validation (Architecture + TDD + UI Testing + Cleanup)

**Circuit Breaker:** If performance targets not met → Implement TRD fallback strategies (remove animations, simplify interactions)  
**Circuit Breaker:** If costs exceed budget → Reduce AI usage limits and implement more aggressive caching

## Implementation Notes

### 🧪 Testing Strategy
- **Slice 0:** Component smoke tests, Playwright visual regression tests
- **Slice 1:** Interaction tests, user flow tests, state management tests  
- **Slice 2:** API integration tests, database tests, E2E sharing tests
- **Slice 3:** AI service tests with mocks, error handling tests, rate limiting tests
- **Slice 4:** Clipboard tests, markdown generation tests, UI interaction tests
- **Slice 5:** Health endpoint tests, performance tests, security configuration tests

### 🚀 Deployment Checkpoints
- **After Slice 0:** Static UI deployed to Vercel with DRD design system
- **After Slice 1:** Interactive form with DRD transitions working
- **After Slice 2:** Database integration and shareable links functional
- **After Slice 3:** AI generation producing real quotes and perspectives
- **After Slice 4:** Complete copy and sharing functionality
- **After Slice 5:** Production-ready with monitoring and optimization

### ⚡ Complexity Escape Hatches
- **Slice 5 too complex?** → Use basic logging instead of comprehensive monitoring
- **Slice 3 AI integration issues?** → Mock the OpenAI service with curated quotes
- **Slice 2 database problems?** → Use localStorage with URL encoding for sharing
- **Slice 1 transitions complex?** → Use instant state changes instead of animations
- **Slice 0 design issues?** → Use DRD circuit breakers (solid colors, system fonts)

### 👨‍💻 For Junior Developers
- Start with Slice 0 - get the beautiful UI deployed first following DRD specifications
- Each slice builds on the previous - complete validation before moving forward
- If stuck, implement the circuit breaker (simpler alternative) from TRD/DRD
- Tests can start simple - just verify the happy path works as intended
- Ask for help before spending >30 minutes on any single sub-task
- Reference TRD and DRD documents for detailed implementation guidance

### 🔍 Validation Framework
- **Architecture Validation:** Technical implementation matches TRD specifications
- **TDD Validation:** All tests written before implementation (Red-Green-Refactor)
- **UI Testing Validation:** Playwright tests cover all DRD user flows with screenshots
- **UX Evaluation:** User experience meets DRD interaction and accessibility requirements
- **Cleanup Validation:** Repository is clean, documentation updated, no temporary code

## Progress Tracking
- [ ] **Slice 0 Complete** - Static UI with DRD design system (Complexity: 1/32)
- [ ] **Slice 1 Complete** - Interactive form with DRD transitions (Complexity: 3/32)
- [ ] **Slice 2 Complete** - Database persistence with TRD data models (Complexity: 7/32)
- [ ] **Slice 3 Complete** - AI integration with OpenAI o1-mini (Complexity: 15/32)
- [ ] **Slice 4 Complete** - Copy and sharing features per DRD (Complexity: 23/32)
- [ ] **Slice 5 Complete** - Performance optimization per TRD (Complexity: 32/32)

## Next Steps
Run `/process-slices 0` to begin implementation with Slice 0 following the TDD approach and multi-agent validation framework.