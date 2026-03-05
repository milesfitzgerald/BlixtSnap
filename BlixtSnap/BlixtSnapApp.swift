import SwiftUI

@main
struct BlixtSnapApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var captureState = CaptureState()

    var body: some Scene {
        MenuBarExtra("BlixtSnap", systemImage: "camera.viewfinder") {
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
