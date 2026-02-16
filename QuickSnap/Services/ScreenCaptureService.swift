import AppKit

class ScreenCaptureService {
    func captureRegion() async -> NSImage? {
        let tempURL = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString)
            .appendingPathExtension("png")

        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/sbin/screencapture")
        process.arguments = ["-i", "-x", tempURL.path]

        do {
            try process.run()

            await withCheckedContinuation { continuation in
                DispatchQueue.global().async {
                    process.waitUntilExit()
                    continuation.resume()
                }
            }

            guard FileManager.default.fileExists(atPath: tempURL.path) else {
                return nil
            }

            let image = NSImage(contentsOf: tempURL)

            try? FileManager.default.removeItem(at: tempURL)

            return image
        } catch {
            return nil
        }
    }
}
