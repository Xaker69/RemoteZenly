import Cocoa

class NavigationBackView: NSView {

    var action: (() -> ())?
    
    let arrow: NSImageView = {
        let view = NSImageView()
        view.image = NSImage(named: "shadowArrow")
        
        return view
    }()
    
    let titleLabel: NSLabel = {
        let label = NSLabel()
        label.stringValue = "Назад"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
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
    
    private func commonInit() {
        wantsLayer = true
        layer?.cornerRadius = 10
        
        let area = NSTrackingArea(rect: bounds, options: [.mouseEnteredAndExited, .activeAlways, .inVisibleRect], owner: self, userInfo: nil)
        addTrackingArea(area)
        
        addSubview(arrow)
        addSubview(titleLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        arrow.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview().offset(1.5)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(arrow.snp.centerY).offset(-2)
            make.left.equalTo(arrow.snp.right).offset(8)
            make.right.equalToSuperview().offset(-12)
        }
    }
    
}
