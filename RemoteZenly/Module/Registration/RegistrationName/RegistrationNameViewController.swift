import Cocoa

class RegistrationNameViewController: NavigationViewController {

    var model: RegistrationModel?
    
    var mainView: RegistrationNameView {
        return view as! RegistrationNameView
    }
    
    override func loadView() {
        view = RegistrationNameView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shouldHideBackView = true
        
        mainView.nextButton.target = self
        mainView.nextButton.action = #selector(nextButtonTapped)
    }
    
    func fillFields(with firstName: String?, _ lastName: String?) {
        mainView.nameFieldView.textField.stringValue = firstName ?? ""
        mainView.lastNameFieldView.textField.stringValue = lastName ?? ""
    }
    
    @objc private func nextButtonTapped() {        
        model?.firstName = mainView.nameFieldView.textField.stringValue
        model?.secondName = mainView.lastNameFieldView.textField.stringValue
        
        let vc = RegistrationNicknameViewController()
        vc.model = model
        
        present(vc)
    }
    
}
