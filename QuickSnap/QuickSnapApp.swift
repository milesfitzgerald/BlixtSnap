import SwiftUI

@main
struct QuickSnapApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var captureState = CaptureState()

    var body: some Scene {
        MenuBarExtra("QuickSnap", systemImage: "camera.viewfinder") {
            MenuBarView(captureState: captureState)
                .onAppear {
                    appDelegate.setupHotKey(with: captureState)
                }
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    private var hotKeyService: HotKeyService?

    func setupHotKey(with captureState: CaptureState) {
        guard hotKeyService == nil else { return }
        hotKeyService = HotKeyService { [weak captureState] in
            Task { @MainActor in
                captureState?.triggerCapture()
            }
        }
    }
}
