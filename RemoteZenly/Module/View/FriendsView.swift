import Cocoa
import SnapKit

class FriendsView: NSView {
    
    @objc dynamic var test: NSRunningApplication? = NSWorkspace.shared.runningApplications.first(where: { $0.isActive })
    var observation1: NSKeyValueObservation?
    var observation: NSKeyValueObservation?
    
    let collectionView: NSCollectionView = {
        let view = NSCollectionView()
        view.backgroundColors = [.clear]
        view.collectionViewLayout = NSCollectionViewFlowLayout()
        
        return view
    }()
    
    private let scrollView = NSScrollView()
    
    let userView: FriendsContactCell = {
        let view = FriendsContactCell()
        view.isMouseTracking = true
        return view
    }()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        observation1 = observe(\.test, options: .new, changeHandler: { object, change in
            if let change = change.newValue, let newApp = change {
                self.updateUserView(with: newApp)
            }
            self.addObserv()
        })
        
        let visualEffectView = NSVisualEffectView(frame: bounds)
        visualEffectView.autoresizingMask = [.width, .height]
        visualEffectView.material = .appearanceBased
        visualEffectView.blendingMode = .behindWindow
        visualEffectView.state = .active
        
        translatesAutoresizingMaskIntoConstraints = true
        
        scrollView.documentView = collectionView
        
        userView.wantsLayer = true
        userView.layer?.backgroundColor = NSColor.black.withAlphaComponent(0.2).cgColor
        userView.appImageView.image = NSWorkspace.shared.runningApplications.first(where: { $0.isActive })?.icon
        
        addSubview(visualEffectView)
        addSubview(scrollView)
        addSubview(userView)
        
        addObserv()
        setupConstraints()
    }
    
    private func addObserv() {
        observation?.invalidate()
        observation = NSWorkspace.shared.runningApplications.first(where: { $0.isActive })?.observe(\.isActive, options: .new, changeHandler: { object, change in
            self.test = NSWorkspace.shared.runningApplications.first(where: { $0.isActive })
        })
    }
    
    private func updateUserView(with newApplication: NSRunningApplication) {
        userView.appImageView.image = newApplication.icon
        userView.appName = newApplication.localizedName ?? "appName"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        userView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
}
