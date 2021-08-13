import Cocoa

protocol TextFieldViewDelegate: AnyObject {
    func textField(didBeginEditing textField: TextField)
    func textField(didEndEditing textField: TextField)
    func textField(didChange textField: TextField)
}

extension TextFieldViewDelegate {
    func textField(didBeginEditing textField: TextField) { }
    func textField(didEndEditing textField: TextField) { }
    func textField(didChange textField: TextField) {}
}

class TextFieldView: NSView {
    
    weak var delegate: TextFieldViewDelegate?
    
    let prefixLabel: NSLabel = {
        let label = NSLabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
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
    
    init(label: String) {
        super.init(frame: .zero)
        
        prefixLabel.stringValue = label
        
        commonInit(showLabel: true)
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        commonInit(showLabel: false)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit(showLabel: false)
    }
    
    override func mouseUp(with event: NSEvent) {
        super.mouseUp(with: event)
        
        textField.becomeFirstResponder()
    }
    
    private func commonInit(showLabel: Bool) {
        wantsLayer = true
        
        let area = NSTrackingArea(rect: bounds, options: [.mouseEnteredAndExited, .activeAlways, .inVisibleRect], owner: self, userInfo: nil)
        addTrackingArea(area)
        
        textField.delegate = self
        textField.fieldDelegate = self
        
        addSubview(textField)
        if showLabel {
            addSubview(prefixLabel)
        }
        
        setupConstraints(showLabel: showLabel)
    }
    
    private func setupConstraints(showLabel: Bool) {
        textField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            
            if showLabel {
                textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
                prefixLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
                
                make.left.equalTo(prefixLabel.snp.right).offset(10)
            } else {
                make.left.equalToSuperview().offset(20)
            }
        }
        
        if showLabel {
            prefixLabel.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(20)
                make.centerY.equalToSuperview()
            }
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
        if let textField = obj.object as? TextField {
            delegate?.textField(didEndEditing: textField)
        }
        
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
    
    func controlTextDidBeginEditing(_ obj: Notification) {
        if let textField = obj.object as? TextField {
            delegate?.textField(didBeginEditing: textField)
        }
    }
    
    func controlTextDidChange(_ obj: Notification) {
        if let textField = obj.object as? TextField {
            delegate?.textField(didChange: textField)
        }
    }
}
