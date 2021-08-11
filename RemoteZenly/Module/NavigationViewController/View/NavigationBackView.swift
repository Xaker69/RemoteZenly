import Cocoa

class NavigationBackView: NSView {

    let arrow: NSImageView = {
        let view = NSImageView()
        view.image = NSImage(named: "shadowArrow")
        
        return view
    }()
    
    let titleLabel: NSLabel = {
        let label = NSLabel()
        label.stringValue = "Назад"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        addSubview(arrow)
        addSubview(titleLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        arrow.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(arrow.snp.centerY).offset(-1.5)
            make.left.equalTo(arrow.snp.right).offset(8)
            make.right.equalToSuperview().offset(-12)
        }
    }
    
}
