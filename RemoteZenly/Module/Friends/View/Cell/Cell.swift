import Cocoa

class Cell<T: NSView>: NSCollectionViewItem {
    
    override func loadView() {
        view = T.init()
    }
    
}

extension Cell {
    
    static var reuseIdentifier: NSUserInterfaceItemIdentifier {
        return NSUserInterfaceItemIdentifier(String(describing: T.self))
    }
    
}
