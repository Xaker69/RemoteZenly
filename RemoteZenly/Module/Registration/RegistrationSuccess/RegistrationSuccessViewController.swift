import Cocoa

class RegistrationSuccessViewController: NavigationViewController {

    var mainView: RegistrationSuccessView {
        return view as! RegistrationSuccessView
    }
    
    override func loadView() {
        view = RegistrationSuccessView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
}
