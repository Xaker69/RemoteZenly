import Cocoa

class FlatButton: NSButton {
    var backgroundColor: NSColor?
    var onClickColor: NSColor?
    var textColor: NSColor = .white
    var titleFont: NSFont = NSFont.systemFont(ofSize: 14, weight: .regular)
    var gradient: NSGradient?
    var gradientInitialColor: NSColor = .white
    var gradientFinalColor: NSColor = .black
    var text: String?
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        title = ""
        wantsLayer = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        let rectanglePath = NSBezierPath(rect: bounds)
        var fillColor: NSColor?
        var strokeColor: NSColor?
        rectanglePath.fill()
        
//        if isHighlighted {
//            strokeColor = backgroundColor
//            fillColor = onClickColor
//        } else {
            strokeColor = onClickColor
            fillColor = backgroundColor
//        }
        
//        strokeColor?.setStroke()
        rectanglePath.lineWidth = 5
        rectanglePath.stroke()
        fillColor?.setFill()
        rectanglePath.fill()
        bezelStyle = .shadowlessSquare
        
        let textRect = bounds
        let textTextContent = text ?? title
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .center
        
        let textFontAttributes : [NSAttributedString.Key : Any] = [
            .font: titleFont,
            .foregroundColor: textColor,
            .paragraphStyle: textStyle
        ]
        
        let textTextHeight: CGFloat = textTextContent.boundingRect(with: NSSize(width: textRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: textFontAttributes).height
        let textTextRect: NSRect = NSRect(x: 0, y: -3 + ((textRect.height - textTextHeight) / 2), width: textRect.width, height: textTextHeight)
        
//        NSGraphicsContext.saveGraphicsState()
//        NSGraphicsContext.restoreGraphicsState()

        gradient?.draw(in: bounds, angle: 90)
        textTextContent.draw(in: textTextRect.offsetBy(dx: 0, dy: 3), withAttributes: textFontAttributes)
    }
    
}
