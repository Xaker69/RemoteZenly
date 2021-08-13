import Cocoa

class WelcomeViewController: NavigationViewController {
    
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
        present(RegistrationSocialViewController())
    }
        
}
