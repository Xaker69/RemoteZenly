import Cocoa

extension NSCollectionView {
    
    func make<T: NSView>(_ class: T.Type, for indexPath: IndexPath) -> Cell<T> {
        return makeItem(withIdentifier: Cell<T>.reuseIdentifier, for: indexPath) as! Cell<T>
    }
    
    func register<T: NSView>(_ class: T.Type) {
        register(Cell<T>.self, forItemWithIdentifier: Cell<T>.reuseIdentifier)
    }
    
}
