import SwiftUI

struct CPUResults: View {
    @State var isStandalone: Bool = false
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
                Text("CPU Info")
                    .font(.headline)
                    .padding(.bottom)

                Text("Total Cores: \(Singleton.cpuInfo.processorCount)")
                Text("Active Cores: \(Singleton.cpuInfo.activeProcessorCount)")

                VStack(alignment: .leading, spacing: 10) {
                    Text("CPU Test Results")
                        .font(.headline)
                    TestResultView(testType: .CPUSingle, label: "Floating Point +-", function: testFloatingPointSumDiff)
                    TestResultView(testType: .CPUSingle, label: "Floating Point */", function: testFloatingPointProdDiv)
                    TestResultView(testType: .CPUMulti, label: "Floating Point +- Multithreaded", functionAsync: testFloatingPointSumDiffMultithreaded)
                    TestResultView(testType: .CPUMulti, label: "Floating Point */ Multithreaded", functionAsync: testFloatingPointProdDivfMultithreaded)
                    TestResultView(testType: .CPUArgon, label: "Easy Argon Test", function: testArgonEasy)
                    TestResultView(testType: .CPUArgon, label: "Medium Argon Test", function: testArgonMedium)
                    TestResultView(testType: .CPUArgon, label: "Hard Argon Test", function: testArgonHard)
                    TestResultView(testType: .Compression, label: "Compression test", function: compressionTests)
                }
            }
            .padding()
            .background(
                ZStack {
                    VisualEffectView(effect: .systemUltraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                }
            )
            .blendMode(.hardLight)
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
        }
    }
}

#Preview {
    CPUResults(isStandalone: true)
}
