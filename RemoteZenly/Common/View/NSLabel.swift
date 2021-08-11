import Cocoa

class NSLabel: NSTextField {
    
    override init(frame frameRect: NSRect) {
      super.init(frame: frameRect)
      
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    private func commonInit() {
        self.isBezeled = false
        self.drawsBackground = false
        self.isEditable = false
        self.isSelectable = false
    }
    
}
