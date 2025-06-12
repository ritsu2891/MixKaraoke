import SwiftUI

struct FlowLayout: Layout {
    let spacing: CGFloat
    let alignment: VerticalAlignment

    init(spacing: CGFloat = 8, alignment: VerticalAlignment = .center) {
        self.spacing = spacing
        self.alignment = alignment
    }

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        var width: CGFloat = 0
        var height: CGFloat = 0
        var rowHeight: CGFloat = 0
        let maxWidth = proposal.width ?? .infinity
        var currentRowWidth: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if currentRowWidth + size.width > maxWidth {
                height += rowHeight + spacing
                currentRowWidth = 0
                rowHeight = 0
            }
            currentRowWidth += size.width + spacing
            rowHeight = max(rowHeight, size.height)
        }
        height += rowHeight
        width = maxWidth
        return CGSize(width: width, height: height)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var x: CGFloat = bounds.minX
        var y: CGFloat = bounds.minY
        var rowHeight: CGFloat = 0
        // let maxWidth = bounds.width

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if x + size.width > bounds.maxX {
                x = bounds.minX
                y += rowHeight + spacing
                rowHeight = 0
            }
            subview.place(at: CGPoint(x: x, y: y), proposal: ProposedViewSize(width: size.width, height: size.height))
            x += size.width + spacing
            rowHeight = max(rowHeight, size.height)
        }
    }
}
