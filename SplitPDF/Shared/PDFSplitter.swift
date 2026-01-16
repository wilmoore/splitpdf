import AppKit
import Foundation
import PDFKit
import UserNotifications

/// Shared PDF splitting logic used by the Finder extension
class PDFSplitter {
    static let shared = PDFSplitter()

    private init() {
        requestNotificationPermission()
    }

    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { _, _ in }
    }

    /// Split a PDF file into individual pages
    /// - Parameter pdfURL: URL of the PDF file to split
    func split(pdfURL: URL) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.performSplit(pdfURL: pdfURL)
        }
    }

    private func performSplit(pdfURL: URL) {
        // Load the PDF document
        guard let pdfDocument = PDFDocument(url: pdfURL) else {
            showNotification(
                title: "Split Failed",
                body: "Could not open \(pdfURL.lastPathComponent). The file may be corrupted or password-protected."
            )
            return
        }

        let pageCount = pdfDocument.pageCount
        guard pageCount > 0 else {
            showNotification(
                title: "Split Failed",
                body: "\(pdfURL.lastPathComponent) has no pages."
            )
            return
        }

        // Create output directory
        let baseName = pdfURL.deletingPathExtension().lastPathComponent
        let parentDirectory = pdfURL.deletingLastPathComponent()
        let outputDirectory = parentDirectory.appendingPathComponent("\(baseName) Pages")

        do {
            try FileManager.default.createDirectory(
                at: outputDirectory,
                withIntermediateDirectories: true,
                attributes: nil
            )
        } catch {
            showNotification(
                title: "Split Failed",
                body: "Could not create output folder: \(error.localizedDescription)"
            )
            return
        }

        // Get output format preference
        let outputFormat = Preferences.shared.outputFormat
        let fileExtension = outputFormat.fileExtension

        // Split each page into separate files
        var successCount = 0
        for pageIndex in 0..<pageCount {
            guard let page = pdfDocument.page(at: pageIndex) else {
                continue
            }

            let pageNumber = pageIndex + 1
            let outputFileName = "\(baseName)_Page_\(pageNumber).\(fileExtension)"
            let outputURL = outputDirectory.appendingPathComponent(outputFileName)

            let success: Bool
            switch outputFormat {
            case .pdf:
                success = writePDFPage(page, to: outputURL)
            case .png:
                success = writePNGPage(page, to: outputURL)
            }

            if success {
                successCount += 1
            }
        }

        // Show completion notification
        if successCount == pageCount {
            showNotification(
                title: "PDF Pages (Finder)",
                body: "PDF split into \(pageCount) pages\nSaved to: \(baseName) Pages"
            )
        } else {
            showNotification(
                title: "Split Partially Complete",
                body: "Split \(successCount) of \(pageCount) pages"
            )
        }
    }

    private func showNotification(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: nil
        )

        UNUserNotificationCenter.current().add(request) { _ in }
    }

    // MARK: - Output Writers

    private func writePDFPage(_ page: PDFPage, to url: URL) -> Bool {
        let singlePageDocument = PDFDocument()
        singlePageDocument.insert(page, at: 0)
        return singlePageDocument.write(to: url)
    }

    private func writePNGPage(_ page: PDFPage, to url: URL) -> Bool {
        let pageBounds = page.bounds(for: .mediaBox)

        // Render at 2x for Retina quality (144 DPI)
        let scale: CGFloat = 2.0
        let width = Int(pageBounds.width * scale)
        let height = Int(pageBounds.height * scale)

        guard let colorSpace = CGColorSpace(name: CGColorSpace.sRGB),
              let context = CGContext(
                  data: nil,
                  width: width,
                  height: height,
                  bitsPerComponent: 8,
                  bytesPerRow: 0,
                  space: colorSpace,
                  bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
              ) else {
            return false
        }

        // Fill with white background
        context.setFillColor(CGColor.white)
        context.fill(CGRect(x: 0, y: 0, width: width, height: height))

        // Scale and draw the page
        context.scaleBy(x: scale, y: scale)
        page.draw(with: .mediaBox, to: context)

        guard let cgImage = context.makeImage() else {
            return false
        }

        let bitmapRep = NSBitmapImageRep(cgImage: cgImage)
        guard let pngData = bitmapRep.representation(using: .png, properties: [:]) else {
            return false
        }

        do {
            try pngData.write(to: url)
            return true
        } catch {
            return false
        }
    }
}
