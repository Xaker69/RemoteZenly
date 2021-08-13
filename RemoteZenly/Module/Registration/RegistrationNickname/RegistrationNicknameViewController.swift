import Cocoa
import Alamofire

class RegistrationNicknameViewController: NavigationViewController {
    
    var model: RegistrationModel!
    
    var mainView: RegistrationNicknameView {
        return view as! RegistrationNicknameView
    }
    
    override func loadView() {
        view = RegistrationNicknameView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.nicknameFieldView.delegate = self
        
        mainView.nextButton.target = self
        mainView.nextButton.action = #selector(nextButtonTapped)
    }
    
    @objc private func nextButtonTapped() {
        model.nickname = mainView.nicknameFieldView.textField.stringValue
        
        AF.request("https://api.apptracker.blaster.cool/api/user/me", method: .get, parameters: model).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else { return }
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension RegistrationNicknameViewController: TextFieldViewDelegate {
    func textField(didChange textField: TextField) {
        if textField.stringValue.count > 3 {
            mainView.validLabel.isHidden = true
            mainView.nextButton.isEnabled = true
        } else {
            mainView.validLabel.isHidden = false
            mainView.nextButton.isEnabled = false
        }
    }
}
