import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    @State private var currentTime: Double = 0
    @State private var timer: Timer?
    @State private var isPlaying = false
    
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
        VStack {
            ScrollView {
                FlowLayout {
                    ForEach(lyric, id: \.self) { lyricWord in
                        
                        let progress = currentTime / 3.0
                        
                        Text(lyricWord)
                            .font(.system(size: 80, weight: .bold))
                            .foregroundStyle(
                                ProgressGradient.create(progress: progress, opacity: 0.3)
                            )
                    }
                }.padding(.horizontal, 20)
            }
        }
        HStack {
            Button {playPause()} label: {
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    .font(.title)
                    .foregroundColor(.white)
                    .frame(width: 80, height: 80)
                    .background(Color.accentColor)
                    .clipShape(Circle())
                    .scaleEffect(isPlaying ? 1.1 : 1.0)
                    .animation(.easeInOut(duration: 0.2), value: isPlaying)
            }
            Button {reset()} label: {
                Image(systemName: "stop.fill")
                    .font(.title)
                    .foregroundColor(.white)
                    .frame(width: 80, height: 80)
                    .background(Color.red)
                    .clipShape(Circle())
            }
        }.padding(.top, 5)
    }
    
    private func playPause() {
        if isPlaying {
            timer?.invalidate()
            isPlaying = false
        } else {
            startTimer()
            isPlaying = true
        }
    }
    
    private func reset() {
        timer?.invalidate()
        currentTime = 0
        isPlaying = false
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            currentTime += 0.01
            
//            if let lastTiming = timings.last, currentTime >= lastTiming {
//                timer?.invalidate()
//                isPlaying = false
//            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
