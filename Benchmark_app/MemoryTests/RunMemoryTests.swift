//
//  RunMemoryTests.swift
//  Benchmark_app
//
//  Created by Bogdan Savianu on 20.11.2024.
//

import Foundation
import UIKit

/// Executes a Memory test function on a background thread and returns the result to the main thread.
/// - Parameters:
///   - testFunction: The Memory test function to execute.
///   - completion: A closure that receives the result on the main thread.
public func runTestMemory(testFunction: @escaping () -> Double, completion: @escaping (Double) -> Void) {
    Singleton.serialTestQueue.async {
        let result = testFunction()
        
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
