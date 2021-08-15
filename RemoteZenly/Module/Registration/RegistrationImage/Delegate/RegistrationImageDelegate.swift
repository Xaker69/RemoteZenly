import Cocoa

@objc protocol RegistrationImageDelegate: AnyObject {
    func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation
    func draggingExited(_ sender: NSDraggingInfo?)
    func draggingEnded(_ sender: NSDraggingInfo)
    func performDragOperation(_ sender: NSDraggingInfo) -> Bool
//    func pasteboardWriter(forImageCanvas imageCanvas: ImageCanvas) -> NSPasteboardWriting
}
