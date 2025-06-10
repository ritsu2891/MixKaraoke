import SwiftUI

struct ProgressGradient {
    
    /// Creates a LinearGradient based on progress and opacity
    /// - Parameters:
    ///   - progress: Progress value from 0.0 to 1.0
    ///   - opacity: Base opacity value from 0.0 to 1.0
    /// - Returns: LinearGradient with system text color that changes opacity based on progress
    /// - Author: Claude Sonnet 3.7
    static func create(progress: CGFloat, opacity: CGFloat) -> LinearGradient {
        // Clamp the values to ensure they're within valid ranges
        let clampedProgress = min(max(progress, 0.0), 1.0)
        let clampedOpacity = min(max(opacity, 0.0), 1.0)
        let switchWidth = 0.06
        
        // Get the system text color
        let textColor = Color(UIColor.label)
        
        // Define the gradient colors and stops based on the progress
        var colors: [Color] = []
        var stops: [Gradient.Stop] = []
        
        if clampedProgress <= 0.0 {
            // When progress is 0, the entire gradient is semi-transparent
            colors = [textColor.opacity(clampedOpacity), textColor.opacity(clampedOpacity)]
            stops = [Gradient.Stop(color: colors[0], location: 0.0),
                     Gradient.Stop(color: colors[1], location: 1.0)]
        } else if clampedProgress >= 1.0 {
            // When progress is 1, the entire gradient is fully opaque
            colors = [textColor, textColor]
            stops = [Gradient.Stop(color: colors[0], location: 0.0),
                     Gradient.Stop(color: colors[1], location: 1.0)]
        } else {
            // For intermediate progress values, create a gradient with a transition at the progress point
            colors = [textColor, textColor, textColor.opacity(clampedOpacity), textColor.opacity(clampedOpacity)]
            stops = [Gradient.Stop(color: colors[0], location: 0.0),
                     Gradient.Stop(color: colors[1], location: clampedProgress - switchWidth),
                     Gradient.Stop(color: colors[2], location: clampedProgress + switchWidth),
                     Gradient.Stop(color: colors[3], location: 1.0)]
        }
        
        return LinearGradient(stops: stops, startPoint: .leading, endPoint: .trailing)
    }
}
