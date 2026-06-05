# Frontend Design-System Guidance

Use this reference for UI tasks, design reviews, component creation, and visual consistency checks.

## First inspect existing patterns

Before creating UI, look for:

- existing design tokens
- component library or shared primitives
- similar screens and layouts
- utility classes and spacing conventions
- form, table, modal, toast, nav, card, and button patterns
- existing loading, empty, error, and permission states

Do not invent a new style if the repo already has a pattern.

## If no design system exists

Suggest or create a minimal `design-system.md` with:

```markdown
# Design System

## Tokens
- spacing scale: 4, 8, 12, 16, 24, 32
- radius scale: small, medium, large
- typography roles: page title, section title, body, caption, label
- color roles: background, surface, border, text, muted, primary, danger, success, warning

## Components
- button: variants, sizes, disabled/loading states
- input: label, help text, error text, disabled state
- card: padding, title, body, actions
- table/list: empty, loading, pagination, actions
- modal/drawer: title, body, footer, close behavior

## States
Every screen should intentionally handle loading, empty, error, success, disabled, and permission-denied states when relevant.

## Responsive
Define breakpoints and stacking behavior for mobile, tablet, and desktop.
```

## UI review checklist

### Visual consistency

- spacing uses the project scale
- typography follows existing hierarchy
- colors use tokens or theme variables
- border radius and shadows match existing components
- icon style is consistent

### Interaction design

- primary action is visually clear
- destructive actions have confirmation or undo when appropriate
- disabled states explain why when useful
- loading states prevent duplicate submissions
- errors are recoverable and specific

### Information architecture

- page title and section hierarchy are clear
- important data is scannable
- empty states teach the next action
- table columns and filters match user tasks
- copy uses user language, not implementation language

### Responsive behavior

- layout works on mobile and desktop
- controls do not overflow
- tables have mobile strategy
- modals and drawers remain usable on small screens

### Accessibility

- form controls have accessible labels
- keyboard navigation works
- focus order follows visual order
- focus ring is visible
- semantic elements are used before custom roles
- contrast is adequate
- icon-only buttons have accessible names

## Frontend implementation rules

- Prefer existing components over new custom markup.
- Put reusable stateful logic in hooks or services when consistent with the repo.
- Keep API calls, data transforms, and business rules out of presentational components when practical.
- Avoid hard-coded strings that should be localized in projects with i18n.
- Avoid hard-coded colors and pixel values unless the codebase already uses them.
- Keep component props small and intention-revealing.
