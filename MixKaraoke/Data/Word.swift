import Foundation

struct Word: Identifiable, Hashable {
    let id = UUID()
    let text: String
    let startTime: Double
    let endTime: Double
    
    func calcProgress(_ currentTime: Double) -> Double {
        if startTime <= currentTime && currentTime <= endTime {
            return (currentTime - startTime) / (endTime - startTime)
        } else if endTime < currentTime {
            return 1.0
        } else {
            return 0.0
        }
    }
}
