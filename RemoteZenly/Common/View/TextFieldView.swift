import Cocoa

class TextFieldView: NSView {
    
    let textField: TextField = {
        let field = TextField()
        field.font = .systemFont(ofSize: 18, weight: .bold)
        field.isBezeled = false
        field.backgroundColor = .clear
        field.isBordered = false
        field.focusRingType = .none
        
        return field
    }()
    
    var highlightedBackgroundColor: CGColor?
    private var identityBackgroundColor: CGColor?
    
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
        
        textField.becomeFirstResponder()
    }
    
    private func commonInit() {
        wantsLayer = true
        
        let area = NSTrackingArea(rect: bounds, options: [.mouseEnteredAndExited, .activeAlways, .inVisibleRect], owner: self, userInfo: nil)
        addTrackingArea(area)
        
        textField.delegate = self
        textField.fieldDelegate = self
        
        addSubview(textField)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        textField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
        }
    }
    
}

extension TextFieldView: TextFieldDelegate {
    func textViewWillBecomeHighlited() {
        if let color = highlightedBackgroundColor {
            let animate = CABasicAnimation(keyPath: "backgroundColor")
            
            identityBackgroundColor = layer?.backgroundColor
            animate.fromValue = identityBackgroundColor
            animate.toValue = color
            animate.duration = 0.15
            animate.fillMode = .forwards
            animate.isRemovedOnCompletion = false
            layer?.add(animate, forKey: "backgroundColor")
        }
    }
    
    func controlTextDidEndEditing(_ obj: Notification) {
        if let color = identityBackgroundColor {
            let animate = CABasicAnimation(keyPath: "backgroundColor")
            
            identityBackgroundColor = nil
            animate.fromValue = highlightedBackgroundColor
            animate.toValue = color
            animate.duration = 0.15
            animate.fillMode = .forwards
            layer?.add(animate, forKey: "backgroundColor")
        }
    }
}
