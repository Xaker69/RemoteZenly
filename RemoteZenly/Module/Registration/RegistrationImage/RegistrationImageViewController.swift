import Cocoa

class RegistrationImageViewController: NavigationViewController {
    
    var mainView: RegistrationImageView {
        return view as! RegistrationImageView
    }
    
    override func loadView() {
        view = RegistrationImageView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.nextButton.target = self
        mainView.nextButton.action = #selector(nextButtonTapped)
    }
    
    @objc private func nextButtonTapped() {
        present(RegistrationNicknameViewController())
    }
}
