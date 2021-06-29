import Cocoa
import Atributika

class FriendsContactCell: NSView {
    
    override var intrinsicContentSize: NSSize {
        return CGSize(width: 350.0, height: 60.0)
    }
    
    var isMouseTracking: Bool = false
    let avatarImageView = NSImageView(image: NSImage(named: "ProfileExample")!)
    
    let nameLabel: NSLabel = {
        let label = NSLabel()
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        label.textColor = .white
        label.stringValue = "Николай Борисов"
        
        return label
    }()
    
    var appName: String = "" {
        didSet {
            updateSubtitle()
        }
    }
    
    let subtitleLabel: NSLabel = {
        let label = NSLabel()
        label.font = .systemFont(ofSize: 14.0)
        label.textColor = .white
        
        return label
    }()
    
    let timeLabel: NSLabel = {
        let label = NSLabel()
        label.font = .systemFont(ofSize: 14.0)
        label.textColor = .white
        label.stringValue = "сейчас"
        
        return label
    }()
    
    let appImageView = NSImageView(image: NSImage(named: "AppExample")!)
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        addSubview(avatarImageView)
        addSubview(nameLabel)
        addSubview(subtitleLabel)
        addSubview(timeLabel)
        addSubview(appImageView)
        
        let area = NSTrackingArea(rect: bounds, options: [.mouseEnteredAndExited, .activeAlways, .inVisibleRect], owner: self, userInfo: nil)
        
        addTrackingArea(area)
        
        updateSubtitle()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)
        
        guard isMouseTracking else { return }
        
        let animate = CABasicAnimation(keyPath: "backgroundColor")
        
        animate.fromValue = NSColor.init(white: 0, alpha: 0.2).cgColor
        animate.toValue = NSColor.init(white: 0, alpha: 0.4).cgColor
        animate.duration = 0.15
        animate.fillMode = .forwards
        animate.isRemovedOnCompletion = false
        layer?.add(animate, forKey: "backgroundColor")
    }
    
    override func mouseExited(with event: NSEvent) {
        super.mouseExited(with: event)

        guard isMouseTracking else { return }
        
        let animate = CABasicAnimation(keyPath: "backgroundColor")
        
        animate.fromValue = NSColor.init(white: 0, alpha: 0.4).cgColor
        animate.toValue = NSColor.init(white: 0, alpha: 0.2).cgColor
        animate.duration = 0.15
        animate.fillMode = .forwards
        animate.isRemovedOnCompletion = false
        layer?.add(animate, forKey: "backgroundColor")
    }
    
    private func updateSubtitle() {
        let dot = Style("dot").foregroundColor(NSColor.white.withAlphaComponent(0.3))
        let secondary = Style("secondary").foregroundColor(NSColor.white.withAlphaComponent(0.5))
        
        subtitleLabel.attributedStringValue = "\(appName)  <dot>•</dot>  <secondary>5 час</secondary>".style(tags: [dot, secondary]).attributedString
    }
    
    private func setupConstraints() {
        avatarImageView.snp.makeConstraints { make in
            make.width.height.equalTo(40.0)
            make.leading.equalToSuperview().offset(20.0)
            make.centerY.equalToSuperview()
        }
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(10.0)
            make.bottom.equalTo(avatarImageView.snp.centerY).offset(-1.0)
            make.trailing.equalTo(timeLabel.snp.leading).offset(-12.0)
        }
        subtitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(10.0)
            make.top.equalTo(avatarImageView.snp.centerY).offset(2.0)
            make.trailing.equalTo(timeLabel.snp.leading).offset(-12.0)
        }
        timeLabel.setContentHuggingPriority(.defaultLow + 1.0, for: .horizontal)
        timeLabel.setContentCompressionResistancePriority(.defaultHigh + 1.0, for: .horizontal)
        timeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(appImageView)
            make.trailing.equalTo(appImageView.snp.leading).offset(-14.0)
        }
        appImageView.setContentHuggingPriority(.defaultLow + 1.0, for: .horizontal)
        appImageView.setContentCompressionResistancePriority(.defaultHigh + 1.0, for: .horizontal)
        appImageView.snp.makeConstraints { make in
            make.width.height.equalTo(32.0)
            make.trailing.equalToSuperview().offset(-24.0)
            make.centerY.equalToSuperview()
        }
    }
    
}
