import Cocoa

protocol TextFieldDelegate: NSTextFieldDelegate {
    func textViewWillBecomeHighlited()
}

extension TextFieldDelegate {
    func textViewWillBecomeHighlited() { }
}

class TextField: NSTextField {

    weak var fieldDelegate: TextFieldDelegate?
    
    @discardableResult
    override func becomeFirstResponder() -> Bool {
        fieldDelegate?.textViewWillBecomeHighlited()
        return super.becomeFirstResponder()
    }
}
