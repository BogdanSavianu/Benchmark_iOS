//
//  RunGPUTests.swift
//  Benchmark_app
//
//  Created by Bogdan Savianu on 20.11.2024.
//
import Foundation

public func runTestGPU(testFunction: @escaping (@escaping (Double) -> Void) -> Void, completion: @escaping (Double) -> Void) {
    Singleton.serialTestQueue.async {
        let semaphore = DispatchSemaphore(value: 0)
        var result: Double = 0

        testFunction { fps in
            result = fps
            semaphore.signal()
        }

        semaphore.wait()
        Singleton.calculator.gpuValues.append(Singleton.calculator.normalize(result, renderingReference))
        Singleton.calculator.totalValues.append(Singleton.calculator.normalize(result, renderingReference))
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
