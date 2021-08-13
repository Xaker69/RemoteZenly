import Cocoa

class RegistrationNicknameView: NavigationView {
    
    let emojiLabel: NSLabel = {
        let label = NSLabel()
        label.font = .systemFont(ofSize: 44, weight: .regular)
        label.alignment = .center
        label.stringValue = "🙌"
        
        return label
    }()
    
    let titleLabel: NSLabel = {
        let label = NSLabel()
        label.font = .systemFont(ofSize: 28, weight: .heavy)
        label.textColor = .white
        label.stringValue = "Выбери никнейм"
        label.alignment = .center
        
        return label
    }()
    
    let subtitleLabel: NSLabel = {
        let label = NSLabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.stringValue = "С никнеймом коллегам и друзьям будет проще тебя здесь отыскать"
        label.textColor = .white
        label.alignment = .center
        
        return label
    }()
    
    let nicknameFieldView: TextFieldView = {
        let view = TextFieldView(label: "@")
        view.layer?.backgroundColor = NSColor.white.withAlphaComponent(0.08).cgColor
        view.layer?.cornerRadius = 10
        view.highlightedBackgroundColor = NSColor.white.withAlphaComponent(0.14).cgColor
        view.textField.placeholderString = "Никнейм"
        
        return view
    }()
    
    let validLabel: NSLabel = {
        let label = NSLabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .fromHex(hex: 0xFF6969)
        label.stringValue = "4 и более символа!"
        
        return label
    }()
    
    let nextButton: FlatButton = {
        let button = FlatButton()
        let gradient = NSGradient(colors: [
            NSColor.fromHex(hex: 0x00FFE9), NSColor.fromHex(hex: 0x0096FF)
        ])
        
        button.isEnabled = false
        button.gradient = gradient
        button.text = "Продолжить"
        button.titleFont = .systemFont(ofSize: 18, weight: .heavy)
        button.textColor = .black
        button.layer?.cornerRadius = 10
        
        return button
    }()
    
    override func initialization() {
        super.initialization()
        
        addSubview(emojiLabel)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(nicknameFieldView)
        addSubview(validLabel)
        addSubview(nextButton)
        
        setupConstreints()
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
        nicknameFieldView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(30)
            make.height.equalTo(50)
        }
        validLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(66)
            make.top.equalTo(nicknameFieldView.snp.bottom).offset(10)
        }
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
    }
    
}
