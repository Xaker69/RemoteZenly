import Cocoa

let appMenu = AppMenu()
let delegate = AppDelegate() //alloc main app's delegate class
NSApplication.shared.delegate = delegate //set as app's delegate
NSApplication.shared.mainMenu = appMenu
_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv) //start of run loop
