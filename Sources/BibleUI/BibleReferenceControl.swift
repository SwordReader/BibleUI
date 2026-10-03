import SwiftUI

/// Separate book/chapter buttons with presentations anchored to each button.
/// The app supplies native navigation content and owns the selected reference.
public struct BibleReferenceControl<Books: View, Chapters: View>: View {
    private let bookTitle: String
    private let chapter: Int?
    private let books: () -> Books
    private let chapters: () -> Chapters
    @State private var showingBooks = false
    @State private var showingChapters = false
    public init(bookTitle: String, chapter: Int?, @ViewBuilder books: @escaping () -> Books,
                @ViewBuilder chapters: @escaping () -> Chapters) {
        self.bookTitle = bookTitle; self.chapter = chapter; self.books = books; self.chapters = chapters
    }
    public var body: some View {
        HStack(spacing: 8) {
            Button(bookTitle) { showingBooks = true }
                .popover(isPresented: $showingBooks) { books() }
                .accessibilityHint("Choose a Bible book")
            Button {
                showingChapters = true
            } label: {
                HStack(spacing: 4) {
                    Text(chapter.map(String.init) ?? "Chapter").monospacedDigit()
                    Image(systemName: "chevron.down").font(.caption)
                }
            }
            .disabled(chapter == nil)
            .popover(isPresented: $showingChapters) { chapters() }
            .accessibilityLabel("Choose Chapter")
        }
        .fontWeight(.semibold)
        .buttonStyle(.plain)
    }
}
