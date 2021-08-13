import Cocoa
import WebKit

class RegistrationSocialView: NavigationView {
    
    let emojiLabel: NSLabel = {
        let label = NSLabel()
        label.font = .systemFont(ofSize: 44, weight: .regular)
        label.alignment = .center
        label.stringValue = "😌 ⏳"
        
        return label
    }()
    
    let titleLabel: NSLabel = {
        let label = NSLabel()
        label.font = .systemFont(ofSize: 28, weight: .heavy)
        label.textColor = .white
        label.stringValue = "Регистрация"
        label.alignment = .center
        
        return label
    }()
    
    let subtitleLabel: NSLabel = {
        let label = NSLabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.stringValue = "Привяжи аккаунты, чтобы зарезервировать никнейм и встать в очередь. Друзья смогут впустить тебя, если они уже здесь"
        label.textColor = .white
        label.alignment = .center
        
        return label
    }()
    
    let vkButton: ButtonView = {
        let button = ButtonView()
        button.title = "Привязать VK"
        button.titleFont = NSFont.systemFont(ofSize: 18, weight: .heavy)
        button.image = NSImage(named: "fb-icon")
        button.layer?.backgroundColor = NSColor.black.withAlphaComponent(0.2).cgColor
        button.layer?.cornerRadius = 10
        
        return button
    }()
    
    override func initialization() {
        super.initialization()
        
        addSubview(emojiLabel)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(vkButton)
        
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
        vkButton.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(26)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        
    }
    
}
