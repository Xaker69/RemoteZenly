import Cocoa

class RegistrationNicknameView: NavigationView {
    
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
    
    let nameFieldView: TextFieldView = {
        let view = TextFieldView()
        view.layer?.backgroundColor = NSColor.white.withAlphaComponent(0.08).cgColor
        view.layer?.cornerRadius = 10
        view.highlightedBackgroundColor = NSColor.white.withAlphaComponent(0.14).cgColor
        view.textField.placeholderString = "Имя"
        
        return view
    }()
    
    let lastNameFieldView: TextFieldView = {
        let view = TextFieldView()
        view.layer?.backgroundColor = NSColor.white.withAlphaComponent(0.08).cgColor
        view.layer?.cornerRadius = 10
        view.highlightedBackgroundColor = NSColor.white.withAlphaComponent(0.14).cgColor
        view.textField.placeholderString = "Фамилия"
        
        return view
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
    
    override func initialization() {
        super.initialization()
        
        addSubview(emojiLabel)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(nameFieldView)
        addSubview(lastNameFieldView)
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
        nameFieldView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(30)
            make.height.equalTo(50)
        }
        lastNameFieldView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(nameFieldView.snp.bottom).offset(10)
            make.height.equalTo(50)
        }
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
    }
    
}
