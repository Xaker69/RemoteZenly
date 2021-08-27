import Cocoa

class RegistrationSuccessView: NavigationView {

    let emptyView: NSView = {
        let view = NSView()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.clear.cgColor
        
        return view
    }()
    
    let emojiLabel: NSLabel = {
        let label = NSLabel()
        label.font = .systemFont(ofSize: 44, weight: .regular)
        label.stringValue = "🎉"
        label.alignment = .center
        
        return label
    }()
    
    let titleLabel: NSLabel = {
        let label = NSLabel()
        label.font = .systemFont(ofSize: 28, weight: .heavy)
        label.stringValue = "Отправим письмо, когда регистрация будет открыта"
        label.alignment = .center
        
        return label
    }()
    
    override func initialization() {
        super.initialization()
        
        addSubview(emptyView)
        addSubview(emojiLabel)
        addSubview(titleLabel)
        
        setupConstratints()
    }
    
    private func setupConstratints() {
        emojiLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(155)
            make.centerX.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(emojiLabel.snp.bottom).offset(3)
            make.left.equalToSuperview().offset(35)
            make.right.equalToSuperview().offset(-35)
        }
        emptyView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.width.equalTo(350)
        }
    }
    
}
