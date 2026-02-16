```
                         ⠀⠀⠀⠀⠀⠀⠀⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀
                     ⠀⠀⠀⢀⣤⣶⣿⣿⣿⣿⣿⣿⣿⣶⣤⡀⠀⠀⠀
                     ⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡀⠀
                     ⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆
                     ⠛⠛⠛⠛⠛⠛⣿⣿⣿⣿⡟⠛⠛⠛⠛⠛⠛⠛
                     ⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⠁⠀⠀⠀⠀⠀⠀⠀
                     ⠀⠀⠀⠀⠀⣾⣿⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀
                     ⠀⠀⠀⠀⣸⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀
                     ⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀⠀⠀⠀
                     ⠀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠀⠀
                     ⠀⠉⠉⠉⠉⣿⣿⣿⣿⡏⠉⠉⠉⠉⠉⠉⠀⠀
                     ⠀⠀⠀⠀⢰⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀
                     ⠀⠀⠀⠀⣾⣿⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀
                     ⠀⠀⠀⣸⣿⣿⣿⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀
                     ⠀⠀⠀⣿⣿⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                     ⠀⠀⠀⠈⠻⣿⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
```

# BlixtSnap

A lightweight macOS menu bar app that captures screenshots without polluting your Desktop.

**Blixt** — Swedish for lightning. Snap a screenshot in a flash.

## How It Works

1. Press **Cmd+Shift+6** from any app
2. Drag to select a region (native macOS crosshairs)
3. Screenshot is copied to your clipboard instantly
4. A floating preview appears briefly in the bottom-right corner
5. Paste anywhere with **Cmd+V**

No files saved. No Desktop clutter. Just clipboard.

## Build & Run

Requires **macOS 13+** and **Xcode 15+**.

```bash
# Clone
git clone https://github.com/milesfitzgerald/BlixtSnap.git
cd BlixtSnap

# Generate Xcode project (if needed)
brew install xcodegen
xcodegen generate

# Build
open QuickSnap.xcodeproj
# Press Cmd+R in Xcode
```

On first capture, macOS will ask for **Screen Recording** permission.
Grant it in **System Settings > Privacy & Security > Screen Recording**.

## Tech

- **SwiftUI** + **AppKit** (MenuBarExtra, NSPanel, NSPasteboard)
- **screencapture** CLI for native region selection
- [HotKey](https://github.com/soffes/HotKey) for global keyboard shortcuts
- No sandbox — runs outside the App Store for direct `screencapture` access

## Project Structure

```
QuickSnap/
  QuickSnapApp.swift           App entry point, MenuBarExtra
  Models/
    CaptureState.swift         Capture flow coordinator
  Services/
    ScreenCaptureService.swift Invokes screencapture CLI
    ClipboardService.swift     Copies images to clipboard
    HotKeyService.swift        Global Cmd+Shift+6 hotkey
  Views/
    MenuBarView.swift          Menu bar dropdown UI
    PreviewPanel.swift         Floating preview window
    PreviewView.swift          Screenshot thumbnail view
```
