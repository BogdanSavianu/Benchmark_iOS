import SwiftUI

struct MemoryResults: View {
    @State var isStandalone: Bool = false
    let physicalMemory = ProcessInfo.processInfo.physicalMemory
    
    var body: some View {
        ZStack {
            if isStandalone {
                LinearGradient(
                    gradient: Gradient(colors: [.orange, .white]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
            }
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
            .background(
                ZStack {
                    VisualEffectView(effect: .systemUltraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.white.opacity(0.6), lineWidth: 1)
                }
            )
            .blendMode(.hardLight)
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
        }
    }
}

#Preview {
    MemoryResults(isStandalone: true)
}
