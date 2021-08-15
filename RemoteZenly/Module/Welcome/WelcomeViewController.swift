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
        
        mainView.queryButton.target = self
        mainView.queryButton.action = #selector(test)
    }
    
    @objc func test() {
        present(RegistrationSocialViewController())
    }
        
}
