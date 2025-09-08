---
description: Generate production-ready React components with TypeScript, testing, and documentation
argument-hint: [ComponentName and requirements]
---
version: "1.0.0"
re4c_version: "1.0.0"
category: "development"
last_updated: "2025-09-08"

Generate a React component for: $ARGUMENTS

Requirements:
- TypeScript with proper type definitions and interfaces
- Functional component with hooks (useState, useEffect as needed)
- CSS Modules or Tailwind CSS styling (detect project preference)
- Props validation with TypeScript interfaces
- Default props where appropriate
- Accessibility attributes (ARIA labels, roles, keyboard navigation)
- Responsive design considerations
- Error boundaries where appropriate

Include:
1. Component implementation in TypeScript
2. Comprehensive unit tests using React Testing Library
3. Storybook story for component documentation
4. CSS/styling file with mobile-first responsive design
5. Usage examples and documentation

Follow modern React best practices:
- Use composition over inheritance
- Implement proper error handling
- Optimize for performance (memo, useMemo, useCallback where appropriate)
- Ensure accessibility compliance
