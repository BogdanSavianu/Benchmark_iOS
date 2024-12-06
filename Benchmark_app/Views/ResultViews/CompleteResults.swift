import SwiftUI

struct CompleteResults: View {

    var body: some View {
        ScrollView {
            Spacer()
                .frame(height: 65)
            
            VStack(alignment: .leading) {
                SystemInformation()
                FinalScore()
                CPUResults()
                GPUResults()
                MemoryResults()
            }
            .padding()
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [.orange, .white, .orange]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .ignoresSafeArea()
        .onAppear() {
            Singleton.calculator.values.removeAll()
        }
        .onDisappear() {
            Singleton.calculator.values.removeAll()
        }
    }
}

#Preview {
    CompleteResults()
}
