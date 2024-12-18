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
        VStack {
            if calculator.totalValues.count.isMultiple(of: Singleton.totalTests) && calculator.totalValues.count > 0 {
                Text("Final Score: \(Int(Singleton.calculator.mean(write: true)[3]))")
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
            
            if calculator.cpuValues.count.isMultiple(of: Singleton.cpuTests) && calculator.cpuValues.count > 0 {
                Text("CPU Score: \(Int(Singleton.calculator.mean(write: false)[0]))")
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
            
            if calculator.gpuValues.count.isMultiple(of: Singleton.gpuTests) && calculator.gpuValues.count > 0 {
                Text("GPU Score: \(Int(Singleton.calculator.mean(write: false)[1]))")
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
            
            if calculator.memoryValues.count.isMultiple(of: Singleton.memoryTests) && calculator.memoryValues.count > 0 {
                Text("Memory Score: \(Int(Singleton.calculator.mean(write: false)[2]))")
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
}

#Preview {
    FinalScore()
}
