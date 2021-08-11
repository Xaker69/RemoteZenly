import Cocoa

class RegistrationNameView: NSView {
    
    let emojiLabel: NSLabel = {
        let label = NSLabel()
        label.font = .systemFont(ofSize: 44, weight: .regular)
        label.alignment = .center
        label.stringValue = "📇"
        
        return label
    }()
    
    let titleLabel: NSLabel = {
        let label = NSLabel()
        label.font = .systemFont(ofSize: 28, weight: .heavy)
        label.textColor = .white
        label.stringValue = "Имя и фамилия"
        label.alignment = .center
        
        return label
    }()
    
    let subtitleLabel: NSLabel = {
        let label = NSLabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.stringValue = "Всем будет проще пользоваться с реальными данными. Спасибо!"
        label.textColor = .white
        label.alignment = .center
        
        return label
    }()
    
    let nameContainer: NSView = {
        let view = NSView()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.white.withAlphaComponent(0.14).cgColor
        view.layer?.cornerRadius = 10
        
        return view
    }()
    
    let lastNameContainer: NSView = {
        let view = NSView()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.white.withAlphaComponent(0.14).cgColor
        view.layer?.cornerRadius = 10
        
        return view
    }()
    
    let nameField: NSTextField = {
        let field = NSTextField()
        field.placeholderString = "Имя"
        field.font = .systemFont(ofSize: 18, weight: .bold)
        field.isBezeled = false
        field.backgroundColor = .clear
        field.isBordered = false
        field.focusRingType = .none
        
        return field
    }()
    
    let lastNameField: NSTextField = {
        let field = NSTextField()
        field.placeholderString = "Фамилия"
        field.font = .systemFont(ofSize: 18, weight: .bold)
        field.isBezeled = false
        field.backgroundColor = .clear
        field.focusRingType = .none
        
        return field
    }()
    
    let nextButton: FlatButton = {
        let button = FlatButton()
        let gradient = NSGradient(colors: [
            NSColor.fromHex(hex: 0x00FFE9), NSColor.fromHex(hex: 0x0096FF)
        ])
        
        button.gradient = gradient
        button.text = "Продолжить"
        button.titleFont = NSFont.systemFont(ofSize: 18, weight: .heavy)
        button.textColor = .black
        button.layer?.cornerRadius = 10
        
        return button
    }()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        let visualEffectView = NSVisualEffectView(frame: bounds)
        visualEffectView.autoresizingMask = [.width, .height]
        visualEffectView.material = .appearanceBased
        visualEffectView.blendingMode = .behindWindow
        visualEffectView.state = .active
        
        translatesAutoresizingMaskIntoConstraints = true
        
        addSubview(visualEffectView)
        addSubview(emojiLabel)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(nameContainer)
        addSubview(lastNameContainer)
        addSubview(nextButton)
        
        nameContainer.addSubview(nameField)
        lastNameContainer.addSubview(lastNameField)
        
        setupConstreints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstreints() {
        emojiLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(61)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        titleLabel.setContentCompressionResistancePriority(.init(499), for: .horizontal)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(35)
            make.trailing.equalToSuperview().offset(-35)
            make.top.equalTo(emojiLabel.snp.bottom).offset(5)
        }
        subtitleLabel.setContentCompressionResistancePriority(.init(499), for: .horizontal)
        subtitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(35)
            make.trailing.equalToSuperview().offset(-35)
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
        }
        nameContainer.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(30)
            make.height.equalTo(50)
        }
        lastNameContainer.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(nameContainer.snp.bottom).offset(10)
            make.height.equalTo(50)
        }
        nameField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
        }
        lastNameField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
        }
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
    }
    
}
