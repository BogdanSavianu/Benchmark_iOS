import SwiftUI

struct CPUResults: View {

    var body: some View {
        VStack(alignment: .leading) {
            Text("CPU Info")
                .font(.headline)
                .padding(.bottom)

            Text("Total Cores: \(Singleton.cpuInfo.processorCount)")
            Text("Active Cores: \(Singleton.cpuInfo.activeProcessorCount)")
            
            VStack(alignment: .leading, spacing: 10) {
                Text("CPU Test Results")
                    .font(.headline)
                TestResultView(testType: .CPUSingle, label: "Floating Point +-", testResult: nil, function: testFloatingPointSumDiff)
                TestResultView(testType: .CPUSingle, label: "Floating Point */", testResult: nil, function: testFloatingPointProdDiv)
                TestResultView(testType: .CPUMulti, label: "Floating Point +- Multithreaded", testResult: nil, functionAsync: testFloatingPointSumDiffMultithreaded)
                TestResultView(testType: .CPUMulti, label: "Floating Point */ Multithreaded", testResult: nil, functionAsync: testFloatingPointProdDivfMultithreaded)
                TestResultView(testType: .CPUArgon, label: "Easy Argon Test", testResult: nil, function: testArgonEasy)
                TestResultView(testType: .CPUArgon, label: "Medium Argon Test", testResult: nil, function: testArgonMedium)
                TestResultView(testType: .CPUArgon, label: "Hard Argon Test", testResult: nil, function: testArgonHard)
            }
            .padding(.top)

        }
        .padding()
    }
}

#Preview {
    CPUResults()
}
