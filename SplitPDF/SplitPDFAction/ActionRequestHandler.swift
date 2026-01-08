import Cocoa
import UniformTypeIdentifiers

class ActionRequestHandler: NSObject, NSExtensionRequestHandling {
    
    func beginRequest(with context: NSExtensionContext) {
        // Get the input items (selected files)
        guard let inputItems = context.inputItems as? [NSExtensionItem] else {
            context.completeRequest(returningItems: nil, completionHandler: nil)
            return
        }
        
        // Process each input item
        for item in inputItems {
            guard let attachments = item.attachments else { continue }
            
            for provider in attachments {
                // Check if it's a file URL
                if provider.hasItemConformingToTypeIdentifier(UTType.fileURL.identifier) {
                    provider.loadItem(forTypeIdentifier: UTType.fileURL.identifier, options: nil) { [weak self] (item, error) in
                        if let url = item as? URL {
                            self?.processPDF(at: url)
                        } else if let data = item as? Data,
                                  let url = URL(dataRepresentation: data, relativeTo: nil) {
                            self?.processPDF(at: url)
                        }
                    }
                }
            }
        }
        
        // Complete the request
        context.completeRequest(returningItems: nil, completionHandler: nil)
    }
    
    private func processPDF(at url: URL) {
        // Only process PDF files
        guard url.pathExtension.lowercased() == "pdf" else { return }
        
        // Use the shared PDFSplitter
        PDFSplitter.shared.split(pdfURL: url)
    }
}
