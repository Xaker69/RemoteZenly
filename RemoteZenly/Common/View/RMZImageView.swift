import Cocoa

class RMZImageView: NSImageView {
    
    private let progressIndicator = NSProgressIndicator()
    
    var isLoading: Bool = false {
        didSet {
            isEnabled = !isLoading
            progressIndicator.isHidden = !isLoading
            if isLoading {
                progressIndicator.startAnimation(nil)
            } else {
                progressIndicator.stopAnimation(nil)
            }
        }
    }
    
    var imageAlpha: CGFloat = 1
    var isImageChoosed = false
    var cornerRadius: CGFloat = 0 {
        didSet {
            layer?.cornerRadius = cornerRadius
        }
    }
    
    var contentMode: CALayerContentsGravity = .resize {
        didSet {
            self.layer?.contentsGravity = contentMode
        }
    }
    
    override var alphaValue: CGFloat {
        didSet {
            if isImageChoosed {
                super.alphaValue = 1
            } else {
                super.alphaValue = alphaValue
            }
        }
    }
    
    override var image: NSImage? {
        set {
            layer = CALayer()
            layer?.contentsGravity = contentMode
            layer?.cornerRadius = cornerRadius
            layer?.contents = newValue
            wantsLayer = true
            alphaValue = imageAlpha
            
            super.image = newValue
        }
        
        get {
            return super.image
        }
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    private func commonInit() {
        addSubview(progressIndicator)
        
        progressIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
}
