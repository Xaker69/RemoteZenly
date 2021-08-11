import Cocoa
import WebKit

class RegistrationViewController: NavigationViewController, WKUIDelegate {

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
//        let myURL = URL(string:"https://oauth.vk.com/authorize?client_id=7898732&display=page&redirect_uri=&scope=friends&response_type=token&v=5.131&state=123456")
//        let myRequest = URLRequest(url: myURL!)
//        mainView.webView.load(myRequest)
//
//        mainView.webView.isHidden = false
        
        present(RegistrationNameViewController())
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
            present(RegistrationNameViewController())
        }
    }
    
}
