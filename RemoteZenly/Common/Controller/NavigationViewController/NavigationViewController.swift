import Cocoa

class NavigationViewController: NSViewController {

    weak var previousViewController: NSViewController?
    var shouldHideBackView = false {
        didSet {
            if shouldHideBackView {
                navView?.backView.isHidden = true
            } else {
                navView?.backView.isHidden = previousViewController != nil
            }
        }
    }
    
    var navView: NavigationView? {
        return view as? NavigationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        preferredContentSize = NSSize(width: 350, height: 500)
        
        navView?.backView.action = dismiss
        
        if shouldHideBackView {
            navView?.backView.isHidden = true
        } else {
            navView?.backView.isHidden = previousViewController == nil
        }
    }
    
    func present(_ viewController: NSViewController) {
        if let viewController = viewController as? NavigationViewController {
            viewController.previousViewController = self
        }
        
        present(viewController, animator: self)
    }
    
    func dismiss() {
        guard let toViewController = previousViewController else { return }
        animateDismissal(of: toViewController, from: self)
    }
    
}

extension NavigationViewController: NSViewControllerPresentationAnimator {
    func animatePresentation(of viewController: NSViewController, from fromViewController: NSViewController) {
        if let window = fromViewController.view.window {
            
            let archivedFromView = NSKeyedArchiver.archivedData(withRootObject: fromViewController.view)
            guard let fromView = NSKeyedUnarchiver.unarchiveObject(with: archivedFromView) as? NSView else { return }
            
            if let fromVC = fromViewController as? NavigationViewController, let view = fromView as? NavigationView {
                if fromVC.shouldHideBackView {
                    view.backView.isHidden = true
                } else {
                    view.backView.isHidden = fromVC.previousViewController == nil
                }
            }
            
            fromView.layerContentsRedrawPolicy = .onSetNeedsDisplay
            fromView.wantsLayer = true
            fromView.layoutSubtreeIfNeeded()
            fromViewController.view.addSubview(fromView)
            fromView.frame = fromViewController.view.frame
            
            viewController.view.wantsLayer = true
            viewController.view.layerContentsRedrawPolicy = .onSetNeedsDisplay
            viewController.view.alphaValue = 1
            fromViewController.view.addSubview(viewController.view)
            viewController.view.frame = fromViewController.view.frame
            viewController.view.frame.origin.x = fromViewController.view.frame.maxX
            
            NSAnimationContext.runAnimationGroup { context in
                context.duration = 0.3
                context.timingFunction = .init(name: .easeInEaseOut)
                viewController.view.animator().frame.origin.x = fromViewController.view.frame.minX
                fromView.animator().frame.origin.x = -fromView.frame.maxX
            } completionHandler: {
                window.contentViewController = viewController
            }
        }
    }
    
    func animateDismissal(of viewController: NSViewController, from fromViewController: NSViewController) {
        if let window = fromViewController.view.window {
            
            let archivedFromView = NSKeyedArchiver.archivedData(withRootObject: fromViewController.view)
            let archivedToView = NSKeyedArchiver.archivedData(withRootObject: viewController.view)
            guard
                let fromView = NSKeyedUnarchiver.unarchiveObject(with: archivedFromView) as? NSView,
                let toView = NSKeyedUnarchiver.unarchiveObject(with: archivedToView) as? NSView
            else { return }
            
            if let toVC = viewController as? NavigationViewController, let view = toView as? NavigationView {
                if toVC.shouldHideBackView {
                    view.backView.isHidden = true
                } else {
                    view.backView.isHidden = toVC.previousViewController == nil
                }
            }
            
            fromView.layerContentsRedrawPolicy = .onSetNeedsDisplay
            fromView.wantsLayer = true
            fromView.layoutSubtreeIfNeeded()
            fromViewController.view.addSubview(fromView)
            fromView.frame = fromViewController.view.frame
            
            toView.wantsLayer = true
            toView.layerContentsRedrawPolicy = .onSetNeedsDisplay
            fromViewController.view.addSubview(toView)
            toView.frame = fromViewController.view.frame
            toView.frame.origin.x = -fromViewController.view.frame.maxX
            
            NSAnimationContext.runAnimationGroup { context in
                context.duration = 0.3
                context.timingFunction = .init(name: .easeInEaseOut)
                toView.animator().frame.origin.x = fromViewController.view.frame.minX
                fromView.animator().frame.origin.x = fromView.frame.maxX
            } completionHandler: {
                window.contentViewController = viewController
            }
        }
    }
}
