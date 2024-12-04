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
    let start = NSDate()
    for index in 0..<totalIterations {
        let _ = randomNumbers[index] + randomNumbers[index + totalIterations]
        let _ = randomNumbers[index] - randomNumbers[index + totalIterations]
    }
    let end = NSDate()
    let time: Double = end.timeIntervalSince(start as Date)

    Singleton.calculator.values.append(Singleton.calculator.normalize(time, floatingPointPlusMinusReference))

    return time
}

public func testFloatingPointProdDiv() -> Double {
    let totalIterations: Int = 5_000_000

    let randomNumbers = (0..<totalIterations * 2).map { _ in
        Float.random(in: 0...10000)
    }
    let start = NSDate()
    for index in 0..<totalIterations {
        let _ = randomNumbers[index] * randomNumbers[index + totalIterations]
        let _ = randomNumbers[index] / randomNumbers[index + totalIterations]
    }
    let end = NSDate()
    let time: Double = end.timeIntervalSince(start as Date)

    Singleton.calculator.values.append(Singleton.calculator.normalize(time, floatingPointMulDivReference))
    
    return time
}

func testFloatingPointSumDiffMultithreaded() async -> Double {
    let totalIterations: Int = 5_000_000
    let randomNumbers = (0..<totalIterations * 2).map { _ in
        Float.random(in: 0...10000)
    }
    let numberOfThreads = totalIterations / Singleton.cpuInfo.processorCount
    let iterationsPerThread = totalIterations / numberOfThreads

    let start = NSDate()
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

    let end = NSDate()
    let time = end.timeIntervalSince(start as Date)
    
    Singleton.calculator.values.append(Singleton.calculator.normalize(time, floatingPoinPlusMinusMultiThReference))
    
    return time
}

func testFloatingPointProdDivfMultithreaded() async -> Double {
    let totalIterations: Int = 5_000_000
    let randomNumbers = (0..<totalIterations * 2).map { _ in
        Float.random(in: 0...10000)
    }
    let numberOfThreads = totalIterations / Singleton.cpuInfo.processorCount
    let iterationsPerThread = totalIterations / numberOfThreads

    let start = NSDate()
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

    let end = NSDate()
    let time =  end.timeIntervalSince(start as Date)
    
    Singleton.calculator.values.append(Singleton.calculator.normalize(time, floatingPointMulDivMultiThReference))
    
    return time
}
