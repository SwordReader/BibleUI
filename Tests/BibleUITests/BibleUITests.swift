import Testing
@testable import BibleUI
import BibleKit

@Test func example() async throws {
    #expect(BibleUI.version == "0.2.0")
}

@MainActor
@Test func acceptsBibleKitContentDescriptors() {
    let descriptor = BibleContentDescriptor(
        providerID: BibleContentProviderID(rawValue: "feed"),
        contentID: BibleContentID(rawValue: "daily-reading"),
        title: "Daily Reading",
        languageCode: "en",
        kind: .devotional,
        license: BibleContentLicense(attribution: "Example Publisher"),
        capabilities: [.read]
    )

    _ = BibleContentMetadataView(descriptor: descriptor)
}
