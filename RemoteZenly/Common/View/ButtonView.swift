import Cocoa

class ButtonView: NSView {

    private lazy var imageView: NSImageView = {
        let view = NSImageView()
        
        return view
    }()
    
    private lazy var titleLabel: NSLabel = {
        let label = NSLabel()
        label.alignment = .center
        label.stringValue = title
        label.font = titleFont
        
        return label
    }()
    
    var title: String = "Button" {
        didSet {
            titleLabel.stringValue = title
        }
    }
    
    var titleColor: NSColor = .white {
        didSet {
            titleLabel.textColor = titleColor
        }
    }
    
    var titleFont: NSFont = NSFont.systemFont(ofSize: 13) {
        didSet {
            titleLabel.font = titleFont
        }
    }
    
    var image: NSImage? = nil {
        didSet {
            imageView.image = image
        }
    }
    
    var action: (() -> ())?
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    override func mouseUp(with event: NSEvent) {
        super.mouseUp(with: event)
        
        action?()
    }
    
    private func commonInit() {
        let area = NSTrackingArea(rect: bounds, options: [.mouseEnteredAndExited, .activeAlways, .inVisibleRect], owner: self, userInfo: nil)
        
        addTrackingArea(area)
        
        wantsLayer = true
        
        addSubview(titleLabel)
        addSubview(imageView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        imageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
        }
    }
    
}
