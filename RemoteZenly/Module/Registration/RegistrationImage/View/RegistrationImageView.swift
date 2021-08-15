import Cocoa

class RegistrationImageView: NavigationView {

    weak var delegate: RegistrationImageDelegate?

    let clearView: NSView = {
        let view = NSView()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.clear.cgColor
        
        return view
    }()
    
    let skipView: HighlightedView = {
        let view = HighlightedView()
        view.titleLabel.stringValue = "Пропустить"
        
        return view
    }()
    
    let titleLabel: NSLabel = {
        let label = NSLabel()
        label.font = .systemFont(ofSize: 28, weight: .heavy)
        label.textColor = .white
        label.stringValue = "Здорово! Но что насчёт фото?"
        label.alignment = .center
        
        return label
    }()
    
    let imageView: RMZImageView = {
        let view = RMZImageView()
        view.imageAlpha = 0.2
        view.wantsLayer = true
        view.contentMode = .resizeAspect
        view.image = NSImage(named: "image-plug")
        view.cornerRadius = 60
        view.layer?.masksToBounds = true
        
        return view
    }()
    
    let changeView: HighlightedView = {
        let view = HighlightedView()
        view.titleLabel.stringValue = "Изменить"
        view.isHidden = true
        
        return view
    }()
    
    let nextButton: FlatButton = {
        let button = FlatButton()
        let gradient = NSGradient(colors: [
            NSColor.fromHex(hex: 0x00FFE9), NSColor.fromHex(hex: 0x0096FF)
        ])
        
        button.gradient = gradient
        button.text = "Продолжить"
        button.titleFont = .systemFont(ofSize: 18, weight: .heavy)
        button.textColor = .black
        button.layer?.cornerRadius = 10
        
        return button
    }()

    override func initialization() {
        super.initialization()
        
        addSubview(skipView)
        addSubview(titleLabel)
        addSubview(imageView)
        addSubview(changeView)
        addSubview(nextButton)
        addSubview(clearView)
        
        setupConstreints()
    }

    private func setupConstreints() {
        skipView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(11)
            make.centerX.equalToSuperview()
            make.height.equalTo(32)
        }
        clearView.snp.makeConstraints { make in
            make.right.left.equalToSuperview()
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
            make.width.equalTo(350)
        }
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(35)
            make.right.equalToSuperview().offset(-35)
            make.top.equalToSuperview().offset(122)
        }
        imageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.height.width.equalTo(120)
            make.left.lessThanOrEqualToSuperview().offset(115)
            make.right.lessThanOrEqualToSuperview().offset(-115)
        }
        changeView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(18)
            make.centerX.equalToSuperview()
            make.height.equalTo(32)
        }
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
    }
    
}

// MARK: - NSDraggingSource

extension RegistrationImageView: NSDraggingSource {
    func draggingSession(_ session: NSDraggingSession, sourceOperationMaskFor context: NSDraggingContext) -> NSDragOperation {
        return context == .outsideApplication ? [.copy] : []
    }
    
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        var result: NSDragOperation = []
        if let delegate = delegate {
            result = delegate.draggingEntered(sender)
        }
        return result
    }
    
    override func draggingExited(_ sender: NSDraggingInfo?) {
        delegate?.draggingExited(sender)
    }
    
    override func draggingEnded(_ sender: NSDraggingInfo) {
        delegate?.draggingEnded(sender)
    }
    
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        return delegate?.performDragOperation(sender) ?? true
    }
}
