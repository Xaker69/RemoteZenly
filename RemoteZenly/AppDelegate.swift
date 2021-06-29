import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    
    private let windowController = MainWindowController()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        //NSWorkspace.shared.runningApplications.filter({$0.isActive}).first?.localizedName
        windowController.showWindow(self)
        
        let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
        
        if let button = statusItem.button {
            button.image = NSImage(named: NSImage.Name("menuBarExample"))
            button.action = #selector(printQuote(_:))
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


    @objc func printQuote(_ sender: Any?) {
      let quoteText = "Never put off until tomorrow what you can do the day after tomorrow."
      let quoteAuthor = "Mark Twain"
      
      print("\(quoteText) — \(quoteAuthor)")
    }

}

