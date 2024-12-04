//
//  TestResultView.swift
//  Benchmark_app
//
//  Created by Bogdan Savianu on 17.11.2024.
//

import SwiftUI

enum TestType {
    case CPUSingle
    case CPUMulti
    case CPUArgon
    case Compression
    case Memory
}

struct TestResultView: View {
    let testType: TestType
    var label: String
    @State var testResult: Double? = nil
    var function: () -> Double = { return 0.0 }
    var functionAsync: () async -> Double = { return 0.0 }
    
    var body: some View {
        VStack {
            HStack {
                Text(label)
                    .font(.headline)
                Spacer()
                if let result = testResult {
                    Text("\(result, specifier: "%.4f") seconds")
                        .foregroundColor(.blue)
                } else {
                    ProgressView()
                }
            }
            .padding(.maximum(5, 5))
        }
        .padding(.horizontal)
        .onAppear {
            if testType == .CPUMulti {
                runTestCPUMulti(testFunctionAsync: functionAsync) { result in
                    testResult = result
                }
            } else if testType == .Memory {
                runTestMemory(testFunction: function) { result in
                    testResult = result
                }
            } else {
                runTestCPU(testFunction: function) { result in
                    testResult = result
                }
            }
        }
    }
}

#Preview {
    TestResultView(testType: .CPUSingle, label: "Easy Test", function: testArgonEasy)
}
