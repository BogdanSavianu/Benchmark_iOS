//
//  GraphView.swift
//  Benchmark_app
//
//  Created by Bogdan Savianu on 02.12.2024.
//

import SwiftUI
import Charts

struct GraphPoint: Identifiable {
    let id: UUID
    let device: String
    let value: Int
    let x: Double
}

struct GraphView: View {
    @State private var results: [[ResultType]] = Singleton.fileWorker.read()
    @State private var selectedCategory: ResultCategory = .cpu

    enum ResultCategory: String, CaseIterable {
        case cpu = "CPU"
        case gpu = "GPU"
        case memory = "Memory"
        case total = "Total"
    }

    var body: some View {
        VStack {
            Text("Performance Graphs")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)

            Picker("Category", selection: $selectedCategory) {
                ForEach(ResultCategory.allCases, id: \.self) { category in
                    Text(category.rawValue).tag(category)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            Chart {
                ForEach(groupedResults(for: selectedCategory), id: \.key) { device, graphPoints in
                    ForEach(graphPoints) { point in
                        LineMark(
                            x: .value("Test Index", point.x),
                            y: .value("Score", point.value)
                        )
                        .foregroundStyle(by: .value("Device", device))
                        .symbol(by: .value("Device", device))
                    }
                }
            }
            .aspectRatio(contentMode: .fit)
            .padding()
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [.white, .cyan.opacity(0.3)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        )
        .onAppear {
            results = Singleton.fileWorker.read()
        }
    }

    private func groupedResults(for category: ResultCategory) -> [(key: String, value: [GraphPoint])] {
        let categoryIndex: Int
        switch category {
            case .cpu: categoryIndex = 0
            case .gpu: categoryIndex = 1
            case .memory: categoryIndex = 2
            case .total: categoryIndex = 3
        }
        
        let groupedResults = results.enumerated().reduce(into: [String: [GraphPoint]]()) { dict, element in
            let (testIndex, deviceResults) = element
            guard deviceResults.indices.contains(categoryIndex) else { return }
            let selectedResult = deviceResults[categoryIndex]
            
            if dict[selectedResult.device] == nil {
                dict[selectedResult.device] = []
            }
            
            dict[selectedResult.device]?.append(
                GraphPoint(
                    id: selectedResult.id,
                    device: selectedResult.device,
                    value: selectedResult.value,
                    x: Double(testIndex)
                )
            )
        }
        
        return groupedResults.map { (device, points) in
            let count = points.count
            let normalizedPoints = points.enumerated().map { (index, point) in
                GraphPoint(
                    id: point.id,
                    device: point.device,
                    value: point.value,
                    x: Double(index) / Double(max(count - 1, 1))
                )
            }
            return (device, normalizedPoints)
        }
    }
}

#Preview {
    GraphView()
}
