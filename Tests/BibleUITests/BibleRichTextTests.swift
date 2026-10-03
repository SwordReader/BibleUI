import Testing
@testable import BibleUI

@MainActor
@Test func renderingPreservesParagraphsAndRemovesActiveContent() {
    let result = BibleRichTextFormatter.attributedString(text: "fallback",
        html: "<h1>Chapter</h1><p>First paragraph.</p><script>unwanted</script><p>Second paragraph.</p>")
    let text = String(result.characters)
    #expect(text.contains("Chapter"))
    #expect(text.contains("First paragraph."))
    #expect(text.contains("Second paragraph."))
    #expect(!text.contains("unwanted"))
    #expect(!text.contains("<p>"))
    #expect(result.font == nil)
}
