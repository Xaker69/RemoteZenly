import Cocoa

class RegistrationNameViewController: NSViewController {

    var mainView: RegistrationNameView {
        return view as! RegistrationNameView
    }
    
    override func loadView() {
        view = RegistrationNameView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
