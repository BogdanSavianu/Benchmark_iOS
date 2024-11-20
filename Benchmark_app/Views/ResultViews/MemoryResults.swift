import SwiftUI

struct MemoryResults: View {
    let physicalMemory = ProcessInfo.processInfo.physicalMemory
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Memory Info")
                .font(.headline)
                .padding(.bottom)
            Text("Physical Memory: \(physicalMemory / (1024 * 1024)) MB")
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Memory Test Results")
                    .font(.headline)
                TestResultView(testType: .Memory, label: "Memory write", function: testMemoryWrite)
                TestResultView(testType: .Memory, label: "Memory read", function: testMemoryRead)
            }
            .padding(.top)
        }
        .padding()
    }
}

#Preview {
    MemoryResults()
}
