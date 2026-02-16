import AppKit
import SwiftUI

@MainActor
class CaptureState: ObservableObject {
    @Published var capturedImage: NSImage?
    @Published var isCapturing: Bool = false
    @Published var showPreview: Bool = false
    @Published var lastError: String?

    private let captureService = ScreenCaptureService()
    private let clipboardService = ClipboardService()
    private var previewPanel: PreviewPanel?
    private var dismissTimer: Timer?

    func triggerCapture() {
        guard !isCapturing else { return }
        isCapturing = true
        lastError = nil

        Task {
            let image = await captureService.captureRegion()
            isCapturing = false

            guard let image else {
                // User cancelled or capture failed
                return
            }

            capturedImage = image
            clipboardService.copyToClipboard(image)
            showFloatingPreview(for: image)
        }
    }

    private func showFloatingPreview(for image: NSImage) {
        dismissPreview()

        let panelWidth: CGFloat = 300
        let panelHeight: CGFloat = 200
        let panel = PreviewPanel(contentRect: NSRect(x: 0, y: 0, width: panelWidth, height: panelHeight))

        let previewView = PreviewView(image: image) { [weak self] in
            self?.dismissPreview()
        }
        panel.contentView = NSHostingView(rootView: previewView)
        panel.positionBottomRight()
        panel.makeKeyAndOrderFront(nil)

        previewPanel = panel
        showPreview = true

        dismissTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { [weak self] _ in
            Task { @MainActor in
                self?.dismissPreview()
            }
        }
    }

    func dismissPreview() {
        dismissTimer?.invalidate()
        dismissTimer = nil
        previewPanel?.close()
        previewPanel = nil
        showPreview = false
    }
}
