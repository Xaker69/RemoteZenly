import AppKit

class TranslucentWin: NSWindow, NSApplicationDelegate, NSWindowDelegate {
    
    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: style, backing: backingStoreType, defer: flag)
        
        self.contentView!.wantsLayer = true
        self.backgroundColor = NSColor.fromHex(hex: 0x2E2E2E, alpha: 1.0).withAlphaComponent(0.7)
        self.isOpaque = false
        self.titlebarAppearsTransparent = true
    }
    
}
