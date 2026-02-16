import SwiftUI

struct PreviewView: View {
    let image: NSImage
    let onDismiss: () -> Void

    @State private var appeared = false

    var body: some View {
        VStack(spacing: 0) {
            Image(nsImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 300, maxHeight: 200)
                .cornerRadius(8)
        }
        .padding(8)
        .background(.ultraThinMaterial)
        .cornerRadius(12)
        .shadow(radius: 10)
        .opacity(appeared ? 1 : 0)
        .offset(y: appeared ? 0 : 20)
        .onTapGesture {
            onDismiss()
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.3)) {
                appeared = true
            }
        }
    }
}
