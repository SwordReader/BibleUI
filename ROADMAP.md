# BibleUI Roadmap

BibleUI is a SwiftUI component library for presenting BibleKit content with
native Apple conventions. It intentionally does not know about SWORD directly.

Reviewed October 3, 2026; the package allows
compatible BibleKit `0.3.x` releases starting at `0.3.2`; app integration is
underway separately.

## Principles

- Use native navigation, sheets, popovers, menus, context menus, Dynamic Type,
  accessibility, keyboard, and platform-specific behavior.
- Components are capability-driven: unavailable provider actions are absent or
  clearly explained rather than simulated.
- Apps own product navigation, persistence, branding, and release policy.

## Ordered milestones

1. BibleKit integration baseline
   - [x] Depend on a tagged BibleKit release.
   - [x] Content metadata and required-license-attribution presentation.
   - [ ] General provider availability/action presentation beyond catalog metadata.

2. Reader primitives
   - [x] Sanitized rich-text formatting and selectable native reading blocks
     inheriting host typography.
   - [x] Anchored book/chapter reference controls.
   - [x] Provider-independent ordered-entry reader with cancellation/stale-load guards.
   - [x] Compile-verified Watch/TV fallbacks: native reference navigation,
     no unsupported text selection, and compact Watch reading margins.
   - [ ] Full Scripture/keyed reader acceptance across compact layouts, Dynamic
     Type, keyboard/VoiceOver, internal links, and rich study metadata.

3. Library and module management
   - [x] Installed/available catalog sections, language filtering, search, and attribution.
   - [ ] Provider-capability-driven download/removal actions, progress, errors,
     persistent filtering, and live installation state.

4. Study interactions
   - [ ] Native selected-passage context actions for bookmarking, highlighting, and
     notes without cluttering every verse.

5. SwordReader extraction
   - [x] Establish reusable reader, catalog, reference, and entry components.
   - [x] SwordReader integration merged in PR #16 with macOS tests and generic
     iOS/watchOS builds passing locally and on GitHub. Product navigation,
     app state, and the advanced study renderer remain app-owned.
   - [ ] Complete running-app/device acceptance of the adopted components and
     further extraction without losing selection, links, or study behavior.
