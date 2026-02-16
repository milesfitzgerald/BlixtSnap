import SwiftUI

struct MenuBarView: View {
    @ObservedObject var captureState: CaptureState

    var body: some View {
        Button("Capture Region") {
            captureState.triggerCapture()
        }
        .keyboardShortcut("6", modifiers: [.command, .shift])
        .disabled(captureState.isCapturing)

        Divider()

        if captureState.capturedImage != nil {
            Text("Last capture copied to clipboard")
                .font(.caption)
                .foregroundColor(.secondary)
            Divider()
        }

        if let error = captureState.lastError {
            Text(error)
                .font(.caption)
                .foregroundColor(.red)
            Divider()
        }

        Button("Quit QuickSnap") {
            NSApplication.shared.terminate(nil)
        }
        .keyboardShortcut("q")
    }
}
