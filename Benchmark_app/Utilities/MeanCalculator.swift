//
//  MeanCalculator.swift
//  Benchmark_app
//
//  Created by Bogdan Savianu on 01.12.2024.
//

import Foundation
import Combine

class Calculator: ObservableObject {
    @Published var totalValues: [Double] = []
    @Published var cpuValues: [Double] = []
    @Published var gpuValues: [Double] = []
    @Published var memoryValues: [Double] = []

    func normalize(_ value: Double, _ reference: Double, _ weight: Double = 1000.0) -> Double {
        return reference / value * weight
    }

    func mean(write: Bool) -> [Double] {
        let cpuMean = pow(self.cpuValues.reduce(1.0, *), 1/Double(self.cpuValues.count))
        let gpuMean = pow(self.gpuValues.reduce(1.0, *), 1/Double(self.gpuValues.count))
        let memoryMean = pow(self.memoryValues.reduce(1.0, *), 1/Double(self.memoryValues.count))
        let finalMean = pow(self.totalValues.reduce(1.0, *), 1/Double(self.totalValues.count))
        
        if write {
            Singleton.fileWorker.write(String(Int(cpuMean)))
            Singleton.fileWorker.write(String(Int(gpuMean)))
            Singleton.fileWorker.write(String(Int(memoryMean)))
            Singleton.fileWorker.write(String(Int(finalMean)))
        }
        
        print(memoryValues)
        
        return [cpuMean, gpuMean, memoryMean, finalMean]
    }
    
    func cleanup() {
        self.totalValues.removeAll()
        self.cpuValues.removeAll()
        self.gpuValues.removeAll()
        self.memoryValues.removeAll()
    }
}
