import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    @State private var currentTime: Double = 0
    @State private var timer: Timer?
    @State private var isPlaying = false
    
    private let lyric = [
        Word(text: "人造ファイヤ", startTime: 0.0, endTime: 1.2),
        Word(text: "ファイボワイパー", startTime: 1.2, endTime: 2.8),
        Word(text: "タイガー", startTime: 2.8, endTime: 3.6),
        Word(text: "タイガー", startTime: 3.6, endTime: 4.6),
        Word(text: "タタタタタイガー", startTime: 4.6, endTime: 6.8),
        Word(text: "チャペアぺカラキナ", startTime: 6.8, endTime: 8.8),
        Word(text: "チャペアぺカラキナ", startTime: 8.8, endTime: 10.8),
        Word(text: "ミョーホントスケ", startTime: 10.8, endTime: 12.2),
        Word(text: "ワイパー", startTime: 12.5, endTime: 13.7)
        
    ]
    
    var body: some View {
        VStack {
            ScrollView {
                FlowLayout {
                    ForEach(lyric, id: \.id) { w in
                        Text(w.text)
                            .font(.system(size: 80, weight: .bold))
                            .foregroundStyle(
                                ProgressGradient.create(progress: w.calcProgress(currentTime), opacity: 0.3)
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
