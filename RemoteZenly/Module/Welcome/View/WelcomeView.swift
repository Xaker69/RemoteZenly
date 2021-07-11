import Cocoa

class WelcomeView: NSView {
    
    let emojiLabel: NSLabel = {
        let label = NSLabel()
        label.font = .systemFont(ofSize: 44, weight: .regular)
        label.alignment = .center
        label.stringValue = "👨‍💻 👀 ⚡️"
        
        return label
    }()
    
    let titleLabel: NSLabel = {
        let label = NSLabel()
        label.font = .systemFont(ofSize: 28, weight: .heavy)
        label.textColor = .white
        label.stringValue = "Повысь свою и командную продуктивность"
        label.alignment = .center
        
        return label
    }()
    
    let subtitleLabel: NSLabel = {
        let label = NSLabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.stringValue = "Узнай, в каких программах твои коллеги и друзья наиболее активны, и как давно они не были за компьютером"
        label.textColor = .white
        label.alignment = .center
        
        return label
    }()
    
    let queryButton: FlatButton = {
        let button = FlatButton()
        let gradient = NSGradient(colors: [
            NSColor.fromHex(hex: 0x00FFE9), NSColor.fromHex(hex: 0x0096FF)
        ])
        
        button.gradient = gradient
        button.text = "Встать в очередь"
        button.titleFont = NSFont.systemFont(ofSize: 18, weight: .heavy)
        button.textColor = .black
        button.layer?.cornerRadius = 10
        
        return button
    }()
    
    let buttonSubtitleLabel: NSLabel = {
        let label = NSLabel()
        label.textColor = NSColor.white.withAlphaComponent(0.5)
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.stringValue = "Пока что по приглашениям"
        label.alignment = .center
        
        return label
    }()
    
    let loginButton: ButtonView = {
//        let button = FlatButton()
//        button.text = "Есть приглашение?  Войти"
//        button.titleFont = NSFont.systemFont(ofSize: 14, weight: .bold)
//        button.textColor = .white
//        button.backgroundColor = NSColor.black.withAlphaComponent(0.2)
//        button.layer?.cornerRadius = 10
        
        let button = ButtonView()
        button.title = "Есть приглашение?  Войти"
        button.titleFont = NSFont.systemFont(ofSize: 14, weight: .bold)
        button.layer?.backgroundColor = NSColor.black.withAlphaComponent(0.2).cgColor
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
        addSubview(queryButton)
        addSubview(buttonSubtitleLabel)
        addSubview(loginButton)
        
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
        queryButton.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        buttonSubtitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(35)
            make.trailing.equalToSuperview().offset(-35)
            make.top.equalTo(queryButton.snp.bottom).offset(10)
        }
        loginButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
    }
    
}
