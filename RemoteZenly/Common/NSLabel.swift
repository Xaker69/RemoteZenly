import Cocoa

class NSLabel: NSTextField {
    
    override init(frame frameRect: NSRect) {
      super.init(frame: frameRect)
      self.isBezeled = false
      self.drawsBackground = false
      self.isEditable = false
      self.isSelectable = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
