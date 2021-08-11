import Cocoa

class NavigationViewController: NSViewController {

    var previousViewController: NSViewController?
    
    var navView: NavigationView {
        return view as! NavigationView
    }
    
    override func loadView() {
        view = NavigationView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        preferredContentSize = NSSize(width: 350, height: 500)
        
        
        navView.backView.isHidden = previousViewController == nil
    }
    
    func present(_ viewController: NSViewController) {
        if let viewController = viewController as? NavigationViewController {
            viewController.previousViewController = self
        }
        
        present(viewController, animator: self)
    }
    
}

extension NavigationViewController: NSViewControllerPresentationAnimator {
    func animatePresentation(of viewController: NSViewController, from fromViewController: NSViewController) {
        if let window = fromViewController.view.window {
            viewController.view.wantsLayer = true
            viewController.view.layerContentsRedrawPolicy = .onSetNeedsDisplay
            viewController.view.alphaValue = 0
            fromViewController.view.addSubview(viewController.view)
            viewController.view.frame = fromViewController.view.frame
            
            NSAnimationContext.runAnimationGroup { context in
                context.duration = 0.3
                viewController.view.animator().alphaValue = 1.0
            } completionHandler: {
                window.contentViewController = viewController
            }
        }
    }
    
    func animateDismissal(of viewController: NSViewController, from fromViewController: NSViewController) {

        if let window = fromViewController.view.window {
            viewController.view.wantsLayer = true
            viewController.view.layerContentsRedrawPolicy = .onSetNeedsDisplay
            viewController.view.alphaValue = 0
            fromViewController.view.addSubview(viewController.view)
            viewController.view.frame = fromViewController.view.frame
            
            NSAnimationContext.runAnimationGroup { context in
                context.duration = 0.3
                viewController.view.animator().alphaValue = 1.0
            } completionHandler: {
                window.contentViewController = viewController
            }
        }
    }
}
