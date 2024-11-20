import SwiftUI

struct CompleteResults: View {
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                SystemInformation()
                CPUResults()
                GPUResults()
                MemoryResults()
            }
            .padding()
        }
    }
}

#Preview {
    CompleteResults()
}
