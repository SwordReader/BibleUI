# BibleUI

BibleUI is a native SwiftUI component library for BibleKit-powered reading and
study applications. It presents content from SWORD, licensed providers, and
custom feeds through BibleKit without tying its API to any one content source.

BibleUI depends on a tagged [BibleKit](https://github.com/SwordReader/BibleKit)
release and never imports SwordKit directly.

## Components

- `BibleContentMetadataView`: content identity and required attribution.
- `BibleCatalogView`: installed/available sections, search, and language filtering.
- `BibleReaderText`: sanitized rich text inheriting the host's font and appearance.
- `BibleReferenceControl`: independent anchored book/chapter controls on Mac,
  iPhone/iPad, and Vision; native navigation links on Watch and TV.
- `BibleEntryReader`: ordered provider entries, previous/next navigation,
  attribution, cancellation, and stale-load protection.

Apps supply navigation destinations, reader preferences, installation state,
and storage. Catalog selection does not implicitly download content. The rich
text formatter removes active markup, external resources, and links rather
than allowing untrusted content to load or navigate. The advanced Scripture
study renderer and selected-passage actions remain separate roadmap work.
Watch and TV intentionally omit unsupported text-selection interactions;
Watch reading blocks use compact margins.

Add the `BibleUI` product and `import BibleUI` in the host SwiftUI app. Use
`BibleReaderText(content:)` with content from
`BibleRichTextFormatter.attributedString(text:html:)` and apply the preferred
font to it. `BibleReferenceControl(bookTitle:chapter:books:chapters:)` takes host-owned
book/chapter picker views; the app controls the resulting reading location.

Run `swift test` for component/formatter coverage. Consumer builds have been
verified on macOS, iOS, and watchOS; builds do not substitute for physical-device,
Dynamic Type, keyboard, or VoiceOver acceptance. Before version 1.0, minor
releases may change API; compatible patch releases stay within the minor series.
