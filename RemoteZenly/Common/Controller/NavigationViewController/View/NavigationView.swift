import Cocoa

class NavigationView: NSView {

    let backView: HighlightedView = {
        let view = HighlightedView(with: NSImage(named: "shadowArrow"))
        view.titleLabel.stringValue = "Назад"
        
        return view
    }()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        initialization()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initialization()
    }
    
    func initialization() {
        let visualEffectView = NSVisualEffectView(frame: bounds)
        visualEffectView.autoresizingMask = [.width, .height]
        visualEffectView.material = .appearanceBased
        visualEffectView.blendingMode = .behindWindow
        visualEffectView.state = .active
        
        translatesAutoresizingMaskIntoConstraints = true
        
        addSubview(visualEffectView)
        addSubview(backView)
        
        backView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(11)
            make.height.equalTo(32)
        }
    }
  
}
