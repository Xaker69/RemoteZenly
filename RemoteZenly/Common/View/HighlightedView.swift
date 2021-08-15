import Cocoa

class HighlightedView: NSView {

    var action: (() -> ())?
    
    let imageView: NSImageView = {
        let view = NSImageView()
        
        return view
    }()
    
    let titleLabel: NSLabel = {
        let label = NSLabel()
        label.stringValue = "Кнопка"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    init(with image: NSImage?) {
        super.init(frame: .zero)
        
        imageView.image = image
        
        commonInit(showImage: true)
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        commonInit(showImage: false)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit(showImage: false)
    }
    
    override func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)
        
        let animate = CABasicAnimation(keyPath: "backgroundColor")
        
        animate.fromValue = NSColor.init(white: 0, alpha: 0).cgColor
        animate.toValue = NSColor.init(white: 0, alpha: 0.3).cgColor
        animate.duration = 0.15
        animate.fillMode = .forwards
        animate.isRemovedOnCompletion = false
        layer?.add(animate, forKey: "backgroundColor")
    }
    
    override func mouseExited(with event: NSEvent) {
        super.mouseExited(with: event)
        
        let animate = CABasicAnimation(keyPath: "backgroundColor")
        
        animate.fromValue = NSColor.init(white: 0, alpha: 0.3).cgColor
        animate.toValue = NSColor.init(white: 0, alpha: 0).cgColor
        animate.duration = 0.15
        animate.fillMode = .forwards
        animate.isRemovedOnCompletion = false
        layer?.add(animate, forKey: "backgroundColor")
    }
    
    override func mouseUp(with event: NSEvent) {
        super.mouseUp(with: event)
        
        action?()
    }
    
    private func commonInit(showImage: Bool) {
        wantsLayer = true
        layer?.cornerRadius = 10
        
        let area = NSTrackingArea(rect: bounds, options: [.mouseEnteredAndExited, .activeAlways, .inVisibleRect], owner: self, userInfo: nil)
        addTrackingArea(area)
        
        if showImage {
            addSubview(imageView)
        }
        
        addSubview(titleLabel)
        
        setupConstraints(showImage: showImage)
    }
    
    private func setupConstraints(showImage: Bool) {
        if showImage {
            imageView.snp.makeConstraints { make in
                make.width.height.equalTo(24)
                make.left.equalToSuperview().offset(10)
                make.centerY.equalToSuperview().offset(1.5)
            }
        }
        titleLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-12)
            if showImage {
                make.centerY.equalTo(imageView.snp.centerY).offset(-2)
                make.left.equalTo(imageView.snp.right).offset(8)
            } else {
                make.centerY.equalToSuperview()
                make.left.equalToSuperview().offset(12)
            }
        }
    }
    
}
