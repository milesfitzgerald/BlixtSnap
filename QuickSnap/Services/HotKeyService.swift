import HotKey

class HotKeyService {
    private var hotKey: HotKey?
    private let onTrigger: () -> Void

    init(onTrigger: @escaping () -> Void) {
        self.onTrigger = onTrigger
        // Cmd+Shift+6 (Cmd+Shift+4 is taken by macOS)
        self.hotKey = HotKey(key: .six, modifiers: [.command, .shift])
        self.hotKey?.keyDownHandler = { [weak self] in
            self?.onTrigger()
        }
    }
}
