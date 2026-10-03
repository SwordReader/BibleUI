# BibleUI Agent Instructions

BibleUI owns reusable native SwiftUI presentation for BibleKit contracts. It
must not import SwordKit or contain application navigation, storage, branding,
publisher credentials, or release policy.

## Workflow

Work on one roadmap milestone at a time. Inspect existing components, add Swift
Testing coverage first where practical, implement the smallest complete change,
run `swift test`, review the diff, and commit only when tests pass. Stop after
the milestone commit unless explicitly asked to continue. Keep `ROADMAP.md`
aligned with committed work and distinguish component implementation from
running-app/device acceptance. Prefer local validation over repeated GitHub CI.

## Presentation and dependencies

- Depend on tagged BibleKit releases. Request contract changes upstream rather
  than embedding engine-specific behavior here.
- Use native platform navigation, popovers, sheets, selection, menus, keyboard,
  accessibility, and Dynamic Type. Unsupported actions must not be simulated.
- Preserve rich content and attribution, sanitize untrusted markup, and do not
  silently enable external resource loading or content export.
- Validate affected platform consumers and compact/large-screen layouts before
  declaring an extraction complete. `Package.swift` defines platform support.
- Respect active changes in other chats and preserve app-owned behavior during
  incremental extraction.

Use `import Testing`, not XCTest, for new Swift tests.
