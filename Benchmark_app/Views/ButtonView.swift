import SwiftUI

struct ButtonView: View {
    @State private var isButtonPressed: Bool = false
    var title: String
    var action: () -> Void // Closure for triggering navigation

    var body: some View {
        Text(title)
            .font(.headline)
            .fontWeight(.semibold)
            .padding()
            .foregroundStyle(.white)
            .background(isButtonPressed ? Color.green : Color.blue)
            .cornerRadius(20)
            .scaleEffect(isButtonPressed ? 1.1 : 1.0)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.3)) {
                    isButtonPressed = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isButtonPressed = false
                    }
                    action()
                }
            }
    }
}

#Preview {
    ButtonView(title: "Start CPU Tests") {}
}
