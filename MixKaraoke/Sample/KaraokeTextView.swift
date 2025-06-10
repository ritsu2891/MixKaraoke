import SwiftUI
import Foundation

struct KaraokeTextView: View {
    let text: String
    let timings: [Double]
    
    @State private var currentTime: Double = 0
    @State private var timer: Timer?
    @State private var isPlaying = false
    
    var body: some View {
        VStack(spacing: 20) {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    highlightedText
                        .font(.system(size: 24, weight: .medium))
                        .lineSpacing(8)
                        .padding()
                }
            }
            .frame(height: 200)
            .background(Color.black.opacity(0.8))
            .cornerRadius(10)

            HStack(spacing: 20) {
                Button(action: playPause) {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .background(Color.blue)
                        .clipShape(Circle())
                }
                
                Button(action: reset) {
                    Image(systemName: "stop.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .background(Color.red)
                        .clipShape(Circle())
                }
            }

            ProgressView(value: currentTime, total: timings.last ?? 1.0)
                .progressViewStyle(LinearProgressViewStyle())
                .frame(height: 8)
        }
        .padding()
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    private var highlightedText: some View {
        let characters = Array(text)
        
        let text = characters.enumerated().map { index, character in
            let characterTime = index < timings.count ? timings[index] : Double.greatestFiniteMagnitude
            
            if currentTime >= characterTime {
                return Text(String(character))
                    .foregroundColor(.yellow)
                    .fontWeight(.bold)
            } else {
                return Text(String(character))
                    .foregroundColor(.white)
            }
        }.reduce(Text(""), +)
        
        return text
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
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            currentTime += 0.1
            
            // 最後まで再生完了した場合
            if let lastTiming = timings.last, currentTime >= lastTiming {
                timer?.invalidate()
                isPlaying = false
            }
        }
    }
}
