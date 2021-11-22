import Cocoa
import Alamofire

class RegistrationImageViewController: NavigationViewController {
    
    var model: RegistrationModel?
    
    var isHighlighted: Bool = false {
        didSet {
            guard isHighlighted != oldValue else { return }
            
            if isHighlighted {
                NSAnimationContext.runAnimationGroup { context in
                    context.duration = 0.3
                    context.allowsImplicitAnimation = true
                    
                    mainView.imageView.alphaValue = 0.8
                    var transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                    transform = transform.translatedBy(x: -6, y: -6)
                    mainView.imageView.layer?.setAffineTransform(transform)
                }
            } else {
                NSAnimationContext.runAnimationGroup { context in
                    context.duration = 0.3
                    context.allowsImplicitAnimation = true
                    
                    mainView.imageView.alphaValue = 0.2
                    mainView.imageView.layer?.setAffineTransform(.identity)
                }
            }
        }
    }
    
    var mainView: RegistrationImageView {
        return view as! RegistrationImageView
    }
    
    private lazy var destinationURL: URL = {
        let destinationURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("Drops")
        try? FileManager.default.createDirectory(at: destinationURL, withIntermediateDirectories: true, attributes: nil)
        return destinationURL
    }()
    
    private lazy var workQueue: OperationQueue = {
        let providerQueue = OperationQueue()
        providerQueue.qualityOfService = .userInitiated
        return providerQueue
    }()
    
    override func loadView() {
        view = RegistrationImageView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let editItem = appMenu.item(withTitle: "Edit")
        let pastItem = editItem?.submenu?.item(withTitle: "Paste")
        pastItem?.action = #selector(pastImage)
        
        shouldHideBackView = true
        mainView.delegate = self
        
        mainView.registerForDraggedTypes(NSFilePromiseReceiver.readableDraggedTypes.map { NSPasteboard.PasteboardType($0) })
        mainView.registerForDraggedTypes([NSPasteboard.PasteboardType.fileURL])
        
        mainView.nextButton.target = self
        mainView.nextButton.action = #selector(nextButtonTapped)
        
        let gesture = NSClickGestureRecognizer(target: self, action: #selector(openFinder))
        mainView.imageView.addGestureRecognizer(gesture)
        mainView.changeView.action = openFinder
        
    }
    
    @objc private func nextButtonTapped() {
        guard let model = model else { return }
        let params = ["type": "vk", "token": model.token!, "nickname": model.nickname!, "first_name": model.firstName!, "second_name": model.secondName!]
        let url = URL(string: "https://api.orbit.house/api/v1/auth/signup")!
        let headers: HTTPHeaders = [.contentType("multipart/form-data")]
        
        AF.upload(multipartFormData: { formData in
            for (key, value) in params {
                formData.append("\(value)".data(using: .utf8)!, withName: key as String)
            }
            
            if let data = model.avatar, let name = model.avatarName {
                formData.append(data, withName: "avatar", fileName: name, mimeType: "image/jpg")
            }
        }, to: url, method: .post, headers: headers).response { responseData in
            
        }
    }
    
    @objc private func pastImage() {
        let pasteboard = NSPasteboard.general
        
        guard
            let data = pasteboard.data(forType: .fileURL),
            let str =  String(data: data, encoding: .utf8),
            let url = URL(string: str)
        else { return }
        
        handleFile(at: url)
    }
    
    @objc private func openFinder() {
        let panel = NSOpenPanel()
        guard let window = mainView.window else { return }
        
        panel.beginSheetModal(for: window) { result in
            if (result == .OK) {
                let url = panel.urls[0]
                self.handleFile(at: url)
            }
        }
    }
    
    private func prepareForUpdate() {
        mainView.imageView.isLoading = true
    }
    
    private func handleError(_ error: Error) {
        OperationQueue.main.addOperation {
            if let window = self.mainView.window {
                self.presentError(error, modalFor: window, delegate: nil, didPresent: nil, contextInfo: nil)
            } else {
                self.presentError(error)
            }
            self.mainView.imageView.isLoading = false
        }
    }
    
    private func handleFile(at url: URL) {
        model?.avatarName = url.lastPathComponent
        let image = NSImage(contentsOf: url)
        OperationQueue.main.addOperation {
            self.handleImage(image)
        }
    }
    
    private func handleImage(_ image: NSImage?) {
        guard let image = image else { return }
        
        model?.avatar = image.tiffRepresentation
        mainView.imageView.image = image
        mainView.imageView.isImageChoosed = true
        mainView.titleLabel.stringValue = "Супер! Почти всё готово"
        mainView.skipView.isHidden = true
        mainView.changeView.isHidden = false
    }
}

extension RegistrationImageViewController: RegistrationImageDelegate {
    func draggingExited(_ sender: NSDraggingInfo?) {
        isHighlighted = false
    }
    
    func draggingEnded(_ sender: NSDraggingInfo) {
        isHighlighted = false
    }
    
    func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        let result = sender.draggingSourceOperationMask.intersection([.copy])
        isHighlighted = result != []
        return result
    }
    
    func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        let supportedClasses = [
            NSFilePromiseReceiver.self,
            NSURL.self
        ]
        
        let searchOptions: [NSPasteboard.ReadingOptionKey: Any] = [
            .urlReadingFileURLsOnly: true,
            .urlReadingContentsConformToTypes: [kUTTypeImage]
        ]
        
        sender.enumerateDraggingItems(options: [], for: nil, classes: supportedClasses, searchOptions: searchOptions) { (draggingItem, _, _) in
            switch draggingItem.item {
            case let filePromiseReceiver as NSFilePromiseReceiver:
                self.prepareForUpdate()
                filePromiseReceiver.receivePromisedFiles(atDestination: self.destinationURL, options: [:],
                                                         operationQueue: self.workQueue) { (fileURL, error) in
                    if let error = error {
                        self.handleError(error)
                    } else {
                        self.handleFile(at: fileURL)
                    }
                }
            case let fileURL as URL:
                self.handleFile(at: fileURL)
                
            default: break
            }
        }
        
        return true
    }
}
