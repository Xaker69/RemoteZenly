import Cocoa

class RegistrationImageView: NavigationView {

    let titleLabel: NSLabel = {
        let label = NSLabel()
        label.font = .systemFont(ofSize: 28, weight: .heavy)
        label.textColor = .white
        label.stringValue = "Здорово! Но что насчёт фото?"
        label.alignment = .center
        
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
        
        addSubview(titleLabel)
        addSubview(nextButton)
        
        setupConstreints()
    }

    private func setupConstreints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(35)
            make.trailing.equalToSuperview().offset(-35)
            make.top.equalToSuperview().offset(110)
        }
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
    }
    
}
