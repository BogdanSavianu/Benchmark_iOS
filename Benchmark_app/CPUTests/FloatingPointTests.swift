//
//  FloatingPointTests.swift
//  Benchmark_app
//
//  Created by Bogdan Savianu on 12.11.2024.
//

import Foundation

public func testFloatingPointSumDiff() -> Double {
    let totalIterations: Int = 5_000_000

    let randomNumbers = (0..<totalIterations * 2).map { _ in
        Float.random(in: 0...10000)
    }
    let start = DispatchTime.now()
    for index in 0..<totalIterations {
        let _ = randomNumbers[index] + randomNumbers[index + totalIterations]
        let _ = randomNumbers[index] - randomNumbers[index + totalIterations]
    }
    let end = DispatchTime.now()
    let time = Double(end.uptimeNanoseconds - start.uptimeNanoseconds) / 1_000_000_000.0

    Singleton.calculator.cpuValues.append(Singleton.calculator.normalize(time, floatingPointPlusMinusReference))
    Singleton.calculator.totalValues.append(Singleton.calculator.normalize(time, floatingPointPlusMinusReference))

    return time
}

public func testFloatingPointProdDiv() -> Double {
    let totalIterations: Int = 5_000_000

    let randomNumbers = (0..<totalIterations * 2).map { _ in
        Float.random(in: 0...10000)
    }
    let start = DispatchTime.now()
    for index in 0..<totalIterations {
        let _ = randomNumbers[index] * randomNumbers[index + totalIterations]
        let _ = randomNumbers[index] / randomNumbers[index + totalIterations]
    }
    let end = DispatchTime.now()
    let time = Double(end.uptimeNanoseconds - start.uptimeNanoseconds) / 1_000_000_000.0

    Singleton.calculator.cpuValues.append(Singleton.calculator.normalize(time, floatingPointMulDivReference))
    Singleton.calculator.totalValues.append(Singleton.calculator.normalize(time, floatingPointMulDivReference))
    
    return time
}

func testFloatingPointSumDiffMultithreaded() async -> Double {
    let totalIterations: Int = 5_000_000
    let randomNumbers = (0..<totalIterations * 2).map { _ in
        Float.random(in: 0...10000)
    }
    let numberOfThreads = totalIterations / Singleton.cpuInfo.processorCount
    let iterationsPerThread = totalIterations / numberOfThreads

    let start = DispatchTime.now()
    await withTaskGroup(of: Void.self) { group in
        for indexThread in 0..<numberOfThreads {
            group.addTask {
                let startIndex = indexThread * iterationsPerThread
                for index in 0..<iterationsPerThread {
                    let _ =
                        randomNumbers[index + startIndex + totalIterations]
                        + randomNumbers[index + startIndex + totalIterations]
                    let _ =
                        randomNumbers[index + startIndex + totalIterations]
                        - randomNumbers[index + startIndex + totalIterations]
                }
            }
        }
    }

    let end = DispatchTime.now()
    let time = Double(end.uptimeNanoseconds - start.uptimeNanoseconds) / 1_000_000_000.0
    
    Singleton.calculator.cpuValues.append(Singleton.calculator.normalize(time, floatingPointPlusMinusMultiThReference))
    Singleton.calculator.totalValues.append(Singleton.calculator.normalize(time, floatingPointPlusMinusMultiThReference))
    
    return time
}

func testFloatingPointProdDivfMultithreaded() async -> Double {
    let totalIterations: Int = 5_000_000
    let randomNumbers = (0..<totalIterations * 2).map { _ in
        Float.random(in: 0...10000)
    }
    let numberOfThreads = totalIterations / Singleton.cpuInfo.processorCount
    let iterationsPerThread = totalIterations / numberOfThreads

    let start = DispatchTime.now()
    await withTaskGroup(of: Void.self) { group in
        for indexThread in 0..<numberOfThreads {
            group.addTask {
                let startIndex = indexThread * iterationsPerThread
                for index in 0..<iterationsPerThread {
                    let _ =
                        randomNumbers[index + startIndex + totalIterations]
                        * randomNumbers[index + startIndex + totalIterations]
                    let _ =
                        randomNumbers[index + startIndex + totalIterations]
                        / randomNumbers[index + startIndex + totalIterations]
                }
            }
        }
    }

    let end = DispatchTime.now()
    let time = Double(end.uptimeNanoseconds - start.uptimeNanoseconds) / 1_000_000_000.0
    
    Singleton.calculator.cpuValues.append(Singleton.calculator.normalize(time, floatingPointMulDivMultiThReference))
    Singleton.calculator.totalValues.append(Singleton.calculator.normalize(time, floatingPointMulDivMultiThReference))
    
    return time
}
