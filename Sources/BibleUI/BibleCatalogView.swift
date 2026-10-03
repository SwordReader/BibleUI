import BibleKit
import SwiftUI

/// An adaptive catalog with installed content and language-filtered discovery.
/// The host supplies selection and management actions through `onSelect`.
public struct BibleCatalogView: View {
    private let contents: [BibleContentDescriptor]
    private let installedIDs: Set<String>
    private let onSelect: (BibleContentDescriptor) -> Void
    @State private var language = ""
    @State private var query = ""
    public init(contents: [BibleContentDescriptor], installedIDs: Set<String> = [],
                onSelect: @escaping (BibleContentDescriptor) -> Void) {
        self.contents = contents; self.installedIDs = installedIDs; self.onSelect = onSelect
    }
    private var filtered: [BibleContentDescriptor] {
        contents.filter {
            (language.isEmpty || $0.languageCode == language) &&
            (query.isEmpty || $0.title.localizedStandardContains(query) || $0.contentID.rawValue.localizedStandardContains(query))
        }
    }
    public var body: some View {
        List {
            Section {
                Picker("Language", selection: $language) {
                    Text("All Languages").tag("")
                    ForEach(Array(Set(contents.map(\.languageCode))).sorted(), id: \.self) { code in
                        Text(Locale.current.localizedString(forLanguageCode: code) ?? code).tag(code)
                    }
                }
            }
            Section("Installed Modules") { rows(filtered.filter { installedIDs.contains($0.id) }) }
            Section("Available Modules") { rows(filtered.filter { !installedIDs.contains($0.id) }) }
        }
        .searchable(text: $query, prompt: "Name or abbreviation")
    }
    @ViewBuilder private func rows(_ items: [BibleContentDescriptor]) -> some View {
        if items.isEmpty { Text("No Modules").foregroundStyle(.secondary) }
        ForEach(items) { item in
            Button { onSelect(item) } label: { BibleContentMetadataView(descriptor: item) }
                .buttonStyle(.plain)
        }
    }
}
