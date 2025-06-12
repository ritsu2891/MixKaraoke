import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    private let lyric = [
        "人造ファイヤ",
        "ファイボワイパー",
        "タイガー",
        "タイガー",
        "タタタタタイガー",
        "チャペアぺカラキナ",
        "チャペアぺカラキナ",
        "ミョーホントスケ",
        "ワイパー",
        "ファイヤー",
        "ファイヤー",
        "虎虎カラキナ",
        "チャペアぺファーマー",
        "海人海人ジャスパー",
        "虎タイガー",
        "虎タイガー",
        "人造繊維",
        "イエッタイガー",
        
    ]
    
    var body: some View {
        ScrollView {
            FlowLayout {
                ForEach(lyric, id: \.self) { lyricWord in
                    Text(lyricWord)
                        .font(.system(size: 80, weight: .bold))
                        .foregroundStyle(
                            ProgressGradient.create(progress: 0, opacity: 0.3)
                        )
                }
            }.padding(.horizontal, 20)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
