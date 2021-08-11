import Cocoa
import WebKit

class WelcomeViewController: NavigationViewController, WKUIDelegate {
    
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
//        present(RegistrationViewController(), animator: NavigationViewController())
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
