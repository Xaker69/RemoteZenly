import Cocoa

class NavigationView: NSView {

    let backView: NavigationBackView = {
        let view = NavigationBackView()
        
        return view
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
        addSubview(backView)
    }
    
//    override func layout() {
//        super.layout()
//        
//        setupConstreints()
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstreints() {
        backView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(11)
            make.height.equalTo(32)
        }
    }
  
}
