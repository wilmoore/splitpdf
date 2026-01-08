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

        // Split each page into a separate PDF
        var successCount = 0
        for pageIndex in 0..<pageCount {
            guard let page = pdfDocument.page(at: pageIndex) else {
                continue
            }

            let singlePageDocument = PDFDocument()
            singlePageDocument.insert(page, at: 0)

            let pageNumber = pageIndex + 1
            let outputFileName = "\(baseName)_Page_\(pageNumber).pdf"
            let outputURL = outputDirectory.appendingPathComponent(outputFileName)

            if singlePageDocument.write(to: outputURL) {
                successCount += 1
            }
        }

        // Show completion notification
        if successCount == pageCount {
            showNotification(
                title: "SplitPDF",
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
}
