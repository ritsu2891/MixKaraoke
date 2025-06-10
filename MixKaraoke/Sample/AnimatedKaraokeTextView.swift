import SwiftUI
import Foundation

struct AnimatedKaraokeTextView: View {
    let text: String
    let timings: [Double]
    
    @State private var currentTime: Double = 0
    @State private var timer: Timer?
    @State private var isPlaying = false
    
    var body: some View {
        VStack(spacing: 20) {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    animatedText
                        .font(.system(size: 24, weight: .medium))
                        .lineSpacing(8)
                        .padding()
                }
            }
            .frame(height: 200)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.purple.opacity(0.8), Color.blue.opacity(0.8)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(15)
            
            HStack(spacing: 20) {
                Button(action: playPause) {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .background(Color.orange)
                        .clipShape(Circle())
                        .scaleEffect(isPlaying ? 1.1 : 1.0)
                        .animation(.easeInOut(duration: 0.2), value: isPlaying)
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
                .progressViewStyle(LinearProgressViewStyle(tint: .orange))
                .frame(height: 8)
        }
        .padding()
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    private var animatedText: some View {
        let characters = Array(text)
        
        return characters.enumerated().map { index, character in
            let characterTime = index < timings.count ? timings[index] : Double.greatestFiniteMagnitude
            
            if currentTime >= characterTime {
                return Text(String(character))
                    .foregroundColor(.yellow)
                    .fontWeight(.bold)
//                    .shadow(color: .orange, radius: 2, x: 0, y: 0)
            } else {
                return Text(String(character))
                    .foregroundColor(.white.opacity(0.7))
            }
        }.reduce(Text(""), +)
        .animation(.easeInOut(duration: 0.3), value: currentTime)
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
            
            if let lastTiming = timings.last, currentTime >= lastTiming {
                timer?.invalidate()
                isPlaying = false
            }
        }
    }
}
