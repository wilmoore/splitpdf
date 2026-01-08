import Cocoa
import FinderSync

class FinderSync: FIFinderSync {
    override init() {
        super.init()

        // Set up the directory we are syncing.
        // We sync all directories to show our context menu everywhere
        FIFinderSyncController.default().directoryURLs = [URL(fileURLWithPath: "/")]
    }

    // MARK: - Menu and toolbar item support

    override func menu(for menuKind: FIMenuKind) -> NSMenu {
        let menu = NSMenu(title: "SplitPDF")

        // Get selected items
        guard let items = FIFinderSyncController.default().selectedItemURLs(),
              !items.isEmpty else {
            return menu
        }

        // Check if any selected item is a PDF
        let hasPDF = items.contains { url in
            url.pathExtension.lowercased() == "pdf"
        }

        if hasPDF {
            let menuItem = NSMenuItem(
                title: "Split into Pages",
                action: #selector(splitPDFAction(_:)),
                keyEquivalent: ""
            )
            menuItem.image = NSImage(systemSymbolName: "doc.on.doc", accessibilityDescription: "Split PDF")
            menu.addItem(menuItem)
        }

        return menu
    }

    @objc func splitPDFAction(_ sender: AnyObject?) {
        guard let items = FIFinderSyncController.default().selectedItemURLs() else {
            return
        }

        let pdfURLs = items.filter { $0.pathExtension.lowercased() == "pdf" }

        for pdfURL in pdfURLs {
            PDFSplitter.shared.split(pdfURL: pdfURL)
        }
    }
}
