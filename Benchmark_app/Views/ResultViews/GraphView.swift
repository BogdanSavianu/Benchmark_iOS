//
//  GraphView.swift
//  Benchmark_app
//
//  Created by Bogdan Savianu on 02.12.2024.
//

import SwiftUI
import Charts

struct GraphView: View {
    @State var results: [ResultType] = Singleton.fileWorker.read()
    @State private var displayedCount: Int = 0
    @State private var animatedResults: [ResultType] = []

    var body: some View {
            Chart(animatedResults, id: \.id) { result in
                LineMark(
                    x: .value("Index", results.firstIndex(where: { $0.id == result.id })! + 1),
                    y: .value("Score", result.value)
                )
                .foregroundStyle(by: .value("Device type", result.device))
                .symbol(by: .value("Device type", result.device))
            }
            .chartXScale(domain: 1...results.count)
            .aspectRatio(contentMode: .fit)
            .padding()
            .onAppear {
                results = Singleton.fileWorker.read()
                animateGraph()
            }
        }
    
    private func animateGraph() {
        animatedResults = []
        displayedCount = 0

        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            if displayedCount < results.count {
                withAnimation(.bouncy(duration: 0.5, extraBounce: 0.4)) {
                    animatedResults.append(results[displayedCount])
                }
                displayedCount += 1
            } else {
                timer.invalidate()
            }
        }
    }
}

#Preview {
    GraphView(results: [])
}
