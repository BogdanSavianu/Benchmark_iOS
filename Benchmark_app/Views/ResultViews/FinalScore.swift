//
//  FinalScore.swift
//  Benchmark_app
//
//  Created by Bogdan Savianu on 01.12.2024.
//

import SwiftUI

struct FinalScore: View {
    @ObservedObject var calculator = Singleton.calculator

    var body: some View {
        if calculator.values.count.isMultiple(of: Singleton.totalTests) && calculator.values.count > 0 {
            Text("Final Score: \(Int(Singleton.calculator.mean()))")
                .font(.title)
        } else {
            HStack {
                Text("Waiting for results...")
                    .font(.title)
                Spacer(minLength: 70)
                ProgressView()
                Spacer(minLength: 20)
            }
            .padding(.maximum(5, 5))
        }
    }
}

#Preview {
    FinalScore()
}
