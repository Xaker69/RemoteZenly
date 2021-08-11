import Cocoa
import WebKit

class RegistrationViewController: NSViewController, WKUIDelegate {

    var mainView: RegistrationView {
        return view as! RegistrationView
    }
    
    override func loadView() {
        view = RegistrationView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.webView.uiDelegate = self
        mainView.webView.navigationDelegate = self
        
        mainView.vkButton.action = registerVK
    }
    
    private func registerVK() {
        let myURL = URL(string:"https://oauth.vk.com/authorize?client_id=7898732&display=page&redirect_uri=&scope=friends&response_type=token&v=5.131&state=123456")
        let myRequest = URLRequest(url: myURL!)
        mainView.webView.load(myRequest)
        
        mainView.webView.isHidden = false
    }
    
}

extension RegistrationViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        let url = webView.url?.absoluteString.replacingOccurrences(of: "#", with: "?")
        guard let urlStr = url, let url = URLComponents(string: urlStr) else { return }
        let token = url.queryItems?.first(where: { $0.name == "access_token" })?.value
        
        if let token = token {
            print("=TOKEN=", token)
            mainView.webView.isHidden = true
            present(RegistrationNameViewController(), animator: self)
        }
    }
    
}

extension RegistrationViewController: NSViewControllerPresentationAnimator {
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

