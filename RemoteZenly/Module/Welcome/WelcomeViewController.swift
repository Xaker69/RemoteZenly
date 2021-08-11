import Cocoa

class WelcomeViewController: NSViewController {
    
    var mainView: WelcomeView {
        return view as! WelcomeView
    }
    
    override func loadView() {
        let view = WelcomeView()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.translatesAutoresizingMaskIntoConstraints = true
        preferredContentSize = NSSize(width: 350, height: 500)
        
        mainView.queryButton.target = self
        mainView.queryButton.action = #selector(test)
    }
    
    @objc func test() {
        present(RegistrationViewController(), animator: self)
    }
        
}

extension WelcomeViewController: NSViewControllerPresentationAnimator {
    func animatePresentation(of viewController: NSViewController, from fromViewController: NSViewController) {
        if let window = fromViewController.view.window {
            
            let tmpView = WelcomeView()
            tmpView.layerContentsRedrawPolicy = .onSetNeedsDisplay
            tmpView.wantsLayer = true
            tmpView.layoutSubtreeIfNeeded()
            fromViewController.view.addSubview(tmpView)
            tmpView.frame = fromViewController.view.frame
            
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
                tmpView.animator().frame.origin.x = -tmpView.frame.maxX
            } completionHandler: {
                window.contentViewController = viewController
            }
        }
    }
    
    func animateDismissal(of viewController: NSViewController, from fromViewController: NSViewController) {
        if let window = viewController.view.window {
            NSAnimationContext.runAnimationGroup({ (context) -> Void in
                viewController.view.animator().alphaValue = 0
            }, completionHandler: { () -> Void in
                fromViewController.view.alphaValue = 0
                window.contentViewController = fromViewController
                fromViewController.view.animator().alphaValue = 1.0
            })
        }
    }
}
