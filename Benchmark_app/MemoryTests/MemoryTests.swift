//
//  MemoryTests.swift
//  Benchmark_app
//
//  Created by Bogdan Savianu on 20.11.2024.
//

import Foundation

class Wrapper {
    var length: Int
    var array: [Int]
    
    init(length: Int = 1_000_000) {
        self.length = length
        self.array = Array(repeating: 0, count: length)
    }
}

public func testMemoryWrite() -> Double {
    let wrapper = Singleton.memoryWrapper
    let length = wrapper.length
    
    let randomNumbers = (0..<length).map { _ in
        Int.random(in: 0...10000)
    }
    
    let start = DispatchTime.now()
    for index in 0..<length {
        wrapper.array[index] = randomNumbers[index]
    }
    
    let end = DispatchTime.now()
    let time = Double(end.uptimeNanoseconds - start.uptimeNanoseconds) / 1_000_000_000.0
    
    Singleton.calculator.memoryValues.append(Singleton.calculator.normalize(time, memoryWriteReference))
    Singleton.calculator.totalValues.append(Singleton.calculator.normalize(time, memoryWriteReference))
    
    return time
}

public func testMemoryRead() -> Double {
    let wrapper = Singleton.memoryWrapper
    var readNumbers = Array(repeating: 0, count: wrapper.length)
    let length = wrapper.length
    
    let start = DispatchTime.now()
    for index in 0..<length {
        readNumbers[index] = wrapper.array[index]
    }
    
    let end = DispatchTime.now()
    let time = Double(end.uptimeNanoseconds - start.uptimeNanoseconds) / 1_000_000_000.0
    
    Singleton.calculator.memoryValues.append(Singleton.calculator.normalize(time, memoryWriteReference))
    Singleton.calculator.totalValues.append(Singleton.calculator.normalize(time, memoryReadReference))
    
    return time
}
