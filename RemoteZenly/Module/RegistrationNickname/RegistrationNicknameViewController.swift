import Cocoa

class RegistrationNicknameViewController: NavigationViewController {
    
    var mainView: RegistrationNicknameView {
        return view as! RegistrationNicknameView
    }
    
    override func loadView() {
        view = RegistrationNicknameView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
