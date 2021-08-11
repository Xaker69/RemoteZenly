import Cocoa

class RegistrationNameViewController: NavigationViewController {

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
    
    @objc private func nextButtonTapped() {
        present(RegistrationNicknameViewController())
    }
    
}
