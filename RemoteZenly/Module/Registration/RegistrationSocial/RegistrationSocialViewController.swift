import Cocoa
import WebKit
import Alamofire

class RegistrationSocialViewController: NavigationViewController {

    var mainView: RegistrationSocialView {
        return view as! RegistrationSocialView
    }
    
    override func loadView() {
        view = RegistrationSocialView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.vkButton.action = registerVK
    }
    
    private func registerVK() {
        present(RegistrationVKController())
    }
    
}
