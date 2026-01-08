import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        // The app runs as a background utility
        NSApp.setActivationPolicy(.accessory)

        // Register as a service provider
        NSApp.servicesProvider = self
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return false
    }

    // MARK: - Services Handler

    /// Called when user selects "Split into Pages" from Services menu
    @objc func splitPDF(_ pboard: NSPasteboard, userData: String, error: NSErrorPointer) {
        // Get file URLs from pasteboard
        guard let fileURLs = pboard.readObjects(forClasses: [NSURL.self], options: [
            .urlReadingFileURLsOnly: true,
            .urlReadingContentsConformToTypes: ["com.adobe.pdf"]
        ]) as? [URL] else {
            return
        }

        // Process each PDF
        for url in fileURLs {
            PDFSplitter.shared.split(pdfURL: url)
        }
    }
}
