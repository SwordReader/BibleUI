import BibleKit
import SwiftUI

/// A provider-independent reader for an explicit ordered set of locations.
public struct BibleEntryReader: View {
    private let provider: any BibleReadingProvider
    private let descriptor: BibleContentDescriptor
    private let locations: [BibleReadingLocation]
    @State private var index = 0
    @State private var content: BibleReadingContent?
    @State private var errorMessage: String?
    public init(provider: any BibleReadingProvider, descriptor: BibleContentDescriptor,
                locations: [BibleReadingLocation]) {
        self.provider = provider; self.descriptor = descriptor; self.locations = locations
    }
    public var body: some View {
        ScrollView {
            if let content {
                VStack(alignment: .leading) {
                    BibleReaderText(content: BibleRichTextFormatter.attributedString(text: content.text, html: content.html))
                    if content.license.requiresAttribution {
                        Text(content.license.attribution).font(.caption).foregroundStyle(.secondary).padding()
                    }
                }
            } else if let errorMessage {
                ContentUnavailableView("Unable to Read Content", systemImage: "exclamationmark.triangle",
                                       description: Text(errorMessage))
            } else if locations.isEmpty {
                ContentUnavailableView("No Readable Entries", systemImage: "book.closed")
            } else { ProgressView().padding() }
        }
        .navigationTitle(descriptor.title)
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Button("Previous Entry", systemImage: "chevron.left") { index -= 1 }
                    .disabled(index == 0).labelStyle(.iconOnly)
                Button("Next Entry", systemImage: "chevron.right") { index += 1 }
                    .disabled(index + 1 >= locations.count).labelStyle(.iconOnly)
            }
        }
        .task(id: index) {
            guard locations.indices.contains(index) else { return }
            let requestedIndex = index
            content = nil; errorMessage = nil
            do {
                let result = try await provider.read(contentID: descriptor.contentID, at: locations[requestedIndex])
                guard !Task.isCancelled, index == requestedIndex else { return }
                content = result
            } catch is CancellationError {
            } catch {
                guard !Task.isCancelled, index == requestedIndex else { return }
                errorMessage = error.localizedDescription
            }
        }
    }
}
