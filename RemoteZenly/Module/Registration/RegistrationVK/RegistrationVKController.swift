import Cocoa
import WebKit
import Alamofire

class RegistrationVKController: NavigationViewController {

    typealias VKCompletion = (Bool, _ firstName: String?, _ lastName: String?) -> ()
    
    override func loadView() {
        view = NavigationView()
    }
    
    let webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let view = WKWebView(frame: .zero, configuration: webConfiguration)
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        let myURL = URL(string:"https://oauth.vk.com/authorize?client_id=7898732&display=page&redirect_uri=&scope=friends&response_type=token&v=5.131&state=123456")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)

        view.addSubview(webView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        webView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(61)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func vkNameRequest(id: String?, token: String, completion: @escaping VKCompletion) {
        guard let id = id else {
            return completion(false, nil, nil)
        }
        
        AF.request("https://api.vk.com/method/users.get?user_ids=\(id)&access_token=\(token)&v=5.131").response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else { return }
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                    guard let response = json?["response"] as? [[String: Any]], let firstName = response[0]["first_name"] as? String, let lastName = response[0]["last_name"] as? String else {
                        return completion(false, nil, nil)
                    }
                    completion(true, firstName, lastName)
                } catch {
                    print(error)
                    completion(false, nil, nil)
                }
            case .failure(let error):
                print(error)
                completion(false, nil, nil)
            }
        }
    }
    
}

extension RegistrationVKController: WKNavigationDelegate, WKUIDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        let url = webView.url?.absoluteString.replacingOccurrences(of: "#", with: "?")
        guard let urlStr = url, let url = URLComponents(string: urlStr) else { return }
        let token = url.queryItems?.first(where: { $0.name == "access_token" })?.value
        let id = url.queryItems?.first(where: { $0.name == "user_id" })?.value
        
        if let token = token {
            webView.isHidden = true
            vkNameRequest(id: id, token: token) { [weak self] isCompleted, firstName, lastName in
                let vc = RegistrationNameViewController()
                vc.fillFields(with: firstName, lastName)
                vc.model = RegistrationModel(type: .vk, token: token, nickname: nil, firstName: nil, secondName: nil)
                self?.present(vc)
            }
        }
    }
    
}
