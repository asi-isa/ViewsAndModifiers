import SwiftUI
import Playgrounds

struct Watermark: ViewModifier {
    let text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            
            Text(text)
                .font(.caption)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let cols: Int
    @ViewBuilder let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<cols, id: \.self) { col in
                        content(row, col)
                    }
                }
            }
        }
    }
}

struct LargeFont: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.blue)
    }
}

extension View {
    func largeFont() -> some View {
        modifier(LargeFont())
    }
}

struct ContentView: View {
    var body: some View {
        GridStack(rows: 2, cols: 2) { row, col in
            Text("Row: \(row) Col: \(col)")
                .largeFont()
        }
    }
}

#Preview {
    ContentView()
}

#Playground {
    _ = 1 + 2
}
