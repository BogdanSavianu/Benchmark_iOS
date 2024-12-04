//
//  MeanCalculator.swift
//  Benchmark_app
//
//  Created by Bogdan Savianu on 01.12.2024.
//

import Foundation
import Combine

class Calculator: ObservableObject {
    @Published var values: [Double] = []

    func normalize(_ value: Double, _ reference: Double, _ weight: Double = 1000.0) -> Double {
        return reference / value * weight
    }

    func mean() -> Double {
        let mean = pow(self.values.reduce(1.0, *), 1/Double(self.values.count))
        Singleton.fileWorker.write(String(Int(mean)))
        return mean
    }
}
