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
            Singleton.fileWriter.write(String(result))
            semaphore.signal()
        }

        semaphore.wait()
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
