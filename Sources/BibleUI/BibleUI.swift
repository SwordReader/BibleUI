import BibleKit
import SwiftUI

/// Native SwiftUI presentation components for content supplied by BibleKit.
///
/// The initial release intentionally contains no SWORD-specific user interface.
/// BibleUI depends on a tagged BibleKit release for its content contracts.
public enum BibleUI {
    /// The package's public version marker for diagnostic displays.
    public static let version = "0.2.1"
}

/// A compact, accessible summary of provider-owned content metadata.
public struct BibleContentMetadataView: View {
    private let descriptor: BibleContentDescriptor

    public init(descriptor: BibleContentDescriptor) {
        self.descriptor = descriptor
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(descriptor.title)
                .font(.headline)

            Text([descriptor.languageCode, descriptor.kind.rawValue, descriptor.version]
                .compactMap { $0 }
                .joined(separator: " · "))
                .font(.subheadline)
                .foregroundStyle(.secondary)

            if descriptor.license.requiresAttribution {
                Text(descriptor.license.attribution)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .accessibilityElement(children: .combine)
    }
}
