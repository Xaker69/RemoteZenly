import Cocoa

class FriendsViewController: NSViewController {

    private var mainView: FriendsView {
        return view as! FriendsView
    }
    
    private var objects: [Any] = [ContactModel(), ContactModel(), ContactModel(), ContactModel(), ContactModel(), ContactModel(), ContactModel(), ContactModel(), ContactModel()]
    
    override func loadView() {
        view = FriendsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        preferredContentSize = NSSize(width: 350, height: 500)
        
        mainView.collectionView.register(FriendsContactCell.self)
        
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        if #available(OSX 10.13, *) {
            if let contentSize = mainView.collectionView.collectionViewLayout?.collectionViewContentSize {
                mainView.collectionView.setFrameSize(contentSize)
            }
        }
    }
    
//    private lazy var viewClicked: () -> () = {
//        self.dismiss(<#T##viewController: NSViewController##NSViewController#>)
//    }
    
}

// MARK: - NSCollectionViewDataSource
extension FriendsViewController: NSCollectionViewDataSource, NSCollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return objects.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        switch objects[indexPath.item] {
        case let object as ContactModel:
            let item = collectionView.make(FriendsContactCell.self, for: indexPath)
            print(object)
            
            return item
        default:
            preconditionFailure("Unknown item")
        }
    }
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        return CGSize(width: 350.0, height: 60.0)
    }
    
}

extension FriendsViewController: NSViewControllerPresentationAnimator {
    func animatePresentation(of viewController: NSViewController, from fromViewController: NSViewController) {
        NSAnimationContext.runAnimationGroup { context in
            context.duration = 0.3
            viewController.view.animator().alphaValue = 1
        } completionHandler: {
            viewController.view.isHidden = false
            viewController.view.alphaValue = 1
        }
    }

    func animateDismissal(of viewController: NSViewController, from fromViewController: NSViewController) {
        
    }
}
