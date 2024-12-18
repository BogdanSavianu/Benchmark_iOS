//
//  RunCPUTests.swift
//  Benchmark_app
//
//  Created by Bogdan Savianu on 17.11.2024.
//

import Foundation
import UIKit

/// Executes a CPU test function on a background thread and returns the result to the main thread.
/// - Parameters:
///   - testFunction: The CPU test function to execute.
///   - completion: A closure that receives the result on the main thread.
public func runTestCPU(testFunction: @escaping () -> Double, completion: @escaping (Double) -> Void) {
    Singleton.serialTestQueue.async {
        let result = testFunction()
    DispatchQueue.main.async {
            completion(result)
        }
    }
}

public func runTestCPUMulti(testFunctionAsync: @escaping () async -> Double, completion: @escaping (Double)-> Void) {
    Singleton.serialTestQueue.async {
        Task.detached {
            let result = await testFunctionAsync()
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}

