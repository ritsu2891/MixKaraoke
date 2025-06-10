import SwiftUI
import Foundation

struct SampleKaraokePage: View {
    private let sampleLyrics = [
        LyricLine(
            text: "きらきら光る",
            timings: [0.0, 1.5, 1.0, 1.5, 2.0, 2.5, 3.0]
        ),
        LyricLine(
            text: "お空の星よ",
            timings: [4.0, 4.5, 5.0, 5.5, 6.0, 6.5, 7.0]
        ),
        LyricLine(
            text: "まばたきしては",
            timings: [8.0, 8.5, 9.0, 9.5, 10.0, 10.5, 11.0, 11.5]
        ),
        LyricLine(
            text: "みんなを見てる",
            timings: [12.0, 12.5, 13.0, 13.5, 14.0, 14.5, 15.0, 15.5]
        )
    ]
    
    @State private var currentLineIndex = 0
    
    var body: some View {
        VStack {
            // 現在の歌詞行
            if currentLineIndex < sampleLyrics.count {
                AnimatedKaraokeTextView(
                    text: sampleLyrics[currentLineIndex].text,
                    timings: sampleLyrics[currentLineIndex].timings
                )
            }
            
            // 行切り替えボタン
            HStack {
                Button("前の行") {
                    if currentLineIndex > 0 {
                        currentLineIndex -= 1
                    }
                }
                .disabled(currentLineIndex == 0)
                
                Spacer()
                
                Text("行 \(currentLineIndex + 1) / \(sampleLyrics.count)")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Spacer()
                
                Button("次の行") {
                    if currentLineIndex < sampleLyrics.count - 1 {
                        currentLineIndex += 1
                    }
                }
                .disabled(currentLineIndex == sampleLyrics.count - 1)
            }
            .padding()
            
            Spacer()
        }
    }
}
