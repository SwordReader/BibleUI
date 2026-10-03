import Foundation
import SwiftUI

/// Native attributed rendering shared by book and devotional readers.
@MainActor
public enum BibleRichTextFormatter {
    public static func attributedString(text: String, html: String) -> AttributedString {
        let source = html.isEmpty ? text : html
        // Imported HTML is limited to reading markup; external resources and
        // executable elements are removed before Apple's HTML importer sees it.
        var sanitized = source
            .replacingOccurrences(of: "(?is)<(script|style|iframe|object|embed|svg|video|audio)\\b[^>]*>.*?</\\1\\s*>", with: "", options: .regularExpression)
            .replacingOccurrences(of: "(?is)<(?:img|link|meta|base|input|source|embed)\\b[^>]*>", with: "", options: .regularExpression)
            .replacingOccurrences(of: "(?is)\\s(?:style|on[a-z]+)\\s*=\\s*(?:\"[^\"]*\"|'[^']*'|[^\\s>]+)", with: "", options: .regularExpression)
        let allowed = Set(["p", "br", "h1", "h2", "h3", "h4", "h5", "h6", "b", "strong", "i", "em", "u", "sup", "sub", "blockquote", "ul", "ol", "li", "hr"])
        if let expression = try? NSRegularExpression(pattern: "(?is)<\\s*(/?)\\s*([a-z][a-z0-9]*)\\b[^>]*>") {
            let matches = expression.matches(in: sanitized, range: NSRange(sanitized.startIndex..., in: sanitized))
            for match in matches.reversed() {
                guard let range = Range(match.range, in: sanitized),
                      let nameRange = Range(match.range(at: 2), in: sanitized),
                      let slashRange = Range(match.range(at: 1), in: sanitized) else { continue }
                let name = String(sanitized[nameRange]).lowercased()
                let slash = String(sanitized[slashRange])
                let replacement = allowed.contains(name) ? "<\(slash)\(name)>" : ""
                sanitized.replaceSubrange(range, with: replacement)
            }
        }
        guard let data = sanitized.data(using: .utf8),
              let rendered = try? NSAttributedString(data: data,
                options: [.documentType: NSAttributedString.DocumentType.html,
                          .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil) else {
            return AttributedString(text.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression))
        }
        var result = AttributedString(rendered)
        result.font = nil
        result.foregroundColor = nil
        result.backgroundColor = nil
        return result
    }
}

/// A selectable native reading block whose typography follows its host view.
public struct BibleReaderText: View {
    private let content: AttributedString
    public init(content: AttributedString) { self.content = content }
    public var body: some View {
        Text(content)
            .textSelection(.enabled)
            .frame(maxWidth: 720, alignment: .leading)
            .padding(.horizontal, 24)
            .padding(.vertical, 20)
    }
}
