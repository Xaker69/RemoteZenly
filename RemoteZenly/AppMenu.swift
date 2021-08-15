//
//  AppMenu.swift
//  RemoteZenly
//
//  Created by Maxim Khrabryi on 16.08.2021.
//

import Cocoa

class AppMenu: NSMenu {
    
    private lazy var applicationName = ProcessInfo.processInfo.processName
    
    override init(title: String) {
        super.init(title: title)
        
        let mainMenu = NSMenuItem()
        mainMenu.title = "MainMenu"
        mainMenu.submenu = NSMenu(title: "MainMenu")
        mainMenu.submenu?.items = [
            NSMenuItem(title: "About \(applicationName)", action: #selector(NSApplication.orderFrontStandardAboutPanel(_:)), keyEquivalent: ""),
            NSMenuItem.separator(),
            NSMenuItem(title: "Preferences...", action: nil, keyEquivalent: ","),
            NSMenuItem.separator(),
            NSMenuItem(title: "Hide \(applicationName)", action: #selector(NSApplication.hide(_:)), keyEquivalent: "h"),
            NSMenuItem(title: "Hide Others", target: self, action: #selector(NSApplication.hideOtherApplications(_:)), keyEquivalent: "h", modifier: .init(arrayLiteral: [.command, .option])),
            NSMenuItem(title: "Show All", action: #selector(NSApplication.unhideAllApplications(_:)), keyEquivalent: ""),
            NSMenuItem.separator(),
            NSMenuItem(title: "Quit \(applicationName)", action: #selector(NSApplication.shared.terminate(_:)), keyEquivalent: "q")
        ]
        
        let editMenu = NSMenuItem()
        editMenu.title = "Edit"
        editMenu.submenu = NSMenu(title: "Edit")
        editMenu.submenu?.items = [
            NSMenuItem(title: "Undo", action: #selector(UndoManager.undo), keyEquivalent: "z"),
            NSMenuItem(title: "Redo", action: #selector(UndoManager.redo), keyEquivalent: "Z"),
            NSMenuItem.separator(),
            NSMenuItem(title: "Cut", action: #selector(NSText.cut(_:)), keyEquivalent: "x"),
            NSMenuItem(title: "Copy", action: #selector(NSText.copy(_:)), keyEquivalent: "c"),
            NSMenuItem(title: "Paste", action: #selector(NSText.paste(_:)), keyEquivalent: "v"),
            NSMenuItem.separator(),
            NSMenuItem(title: "Select All", action: #selector(NSText.selectAll(_:)), keyEquivalent: "a"),
            NSMenuItem.separator(),
            NSMenuItem(title: "Delete", target: self, action: nil, keyEquivalent: "⌫", modifier: .init()),
        ]
        
        items = [mainMenu, editMenu]
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

extension NSMenuItem {
    convenience init(title string: String, target: AnyObject = self as AnyObject, action selector: Selector?, keyEquivalent charCode: String, modifier: NSEvent.ModifierFlags = .command) {
        self.init(title: string, action: selector, keyEquivalent: charCode)
        keyEquivalentModifierMask = modifier
        self.target = target
    }
    convenience init(title string: String, submenuItems: [NSMenuItem]) {
        self.init(title: string, action: nil, keyEquivalent: "")
        self.submenu = NSMenu()
        self.submenu?.items = submenuItems
    }
}
