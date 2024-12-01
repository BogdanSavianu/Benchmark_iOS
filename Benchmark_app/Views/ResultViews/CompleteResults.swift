import SwiftUI

struct CompleteResults: View {
    
    var body: some View {
        ScrollView {
            Spacer()
                .frame(height: 65)
            VStack(alignment: .leading) {
                SystemInformation()
                CPUResults()
                GPUResults()
                MemoryResults()
            }
            .padding()
        }
        .background(LinearGradient(gradient: Gradient(colors: [.orange, .white]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .ignoresSafeArea()
    }
}

#Preview {
    CompleteResults()
}
