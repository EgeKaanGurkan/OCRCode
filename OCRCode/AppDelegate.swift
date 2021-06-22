//
//  AppDelegate.swift
//  OCRCode
//
//  Created by Ege Kaan Gürkan on 16.06.2021.
//

import Cocoa
import SwiftUI

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!
    
    var ocrUtil = OCRUtil()
//    var statusBar = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
//    var button: NSButton!
//    let popoverView = NSPopover.init()
//    var statusItem: NSStatusItem?


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()
        
//        popoverView.behavior = .transient
//        popoverView.contentSize = CGSize(width: 450, height: 300)
//        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
//        statusItem?.button?.title = "􀇂"
//        statusItem?.button?.action = #selector(togglePopover(_:))
        
        // Create the window and set the content view.
        
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.isReleasedWhenClosed = false
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
//    @objc func showPopover(_ sender: AnyObject?) {
//        if let button = statusItem?.button {
//            popoverView.show(relativeTo: button.bounds, of: button, preferredEdge: .maxY)
////            !!! - displays the popover window with an offset in x in macOS BigSur.
//        }
//    }
//    @objc func closePopover(_ sender: AnyObject?) {
//        popoverView.performClose(sender)
//    }
//    @objc func togglePopover(_ sender: AnyObject?) {
//        if popoverView.isShown {
//            closePopover(sender)
//        } else {
//            showPopover(sender)
//        }
//    }


}

