import Cocoa

class ButtonView: NSView {

    lazy var titleLabel: NSLabel = {
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
    
    var titleFont: NSFont = NSFont.systemFont(ofSize: 13) {
        didSet {
            titleLabel.font = titleFont
        }
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        wantsLayer = true
        
        addSubview(titleLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
}
