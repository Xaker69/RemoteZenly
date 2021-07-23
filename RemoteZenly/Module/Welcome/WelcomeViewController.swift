import Cocoa
import WebKit

class WelcomeViewController: NSViewController, WKUIDelegate {
    
    var mainView: WelcomeView {
        return view as! WelcomeView
    }
    
//    var webView: WKWebView!
    
    override func loadView() {
        let view = WelcomeView()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.translatesAutoresizingMaskIntoConstraints = true
        preferredContentSize = NSSize(width: 350, height: 500)
//
//        let webConfiguration = WKWebViewConfiguration()
//        webView = WKWebView(frame: .zero, configuration: webConfiguration)
//        webView.uiDelegate = self
//        webView.navigationDelegate = self
//        let myURL = URL(string:"https://oauth.vk.com/authorize?client_id=7898732&display=page&redirect_uri=&scope=friends&response_type=token&v=5.131&state=123456")
//        let myRequest = URLRequest(url: myURL!)
//        webView.load(myRequest)
//
//        view.addSubview(webView)
//
//        webView.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
//            make.leading.equalToSuperview()
//            make.trailing.equalToSuperview()
//            make.bottom.equalToSuperview()
//        }
        
        mainView.queryButton.target = self
        mainView.queryButton.action = #selector(test)
    }
    
    @objc func test() {
        present(FriendsViewController(), animator: self)
    }
        
}

extension WelcomeViewController: NSViewControllerPresentationAnimator {
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

//extension WelcomeViewController: WKNavigationDelegate {
//    
//    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//        let url = webView.url?.absoluteString.replacingOccurrences(of: "#", with: "?")
//        guard let urlStr = url, let url = URLComponents(string: urlStr) else { return }
//        let token = url.queryItems?.first(where: { $0.name == "access_token" })?.value
//        
//        if let token = token {
//            print(token)
//        }
//    }
//    
//}
