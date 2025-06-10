import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    var body: some View {
        HStack {
            Text("タイガー")
                .font(.system(size: 80, weight: .bold))
                .foregroundStyle(
                    ProgressGradient.create(progress: 1, opacity: 0.3)
                )
            Text("ファイヤー")
                .font(.system(size: 80, weight: .bold))
                .foregroundStyle(
                    ProgressGradient.create(progress: 0.3, opacity: 0.3)
                )
            Text("サイバー")
                .font(.system(size: 80, weight: .bold))
                .foregroundStyle(
                    ProgressGradient.create(progress: 0, opacity: 0.3)
                )
        }
        
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
