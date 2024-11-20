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
    var wrapper = Singleton.memoryWrapper
    let length = wrapper.length
    
    let randomNumbers = (0..<length).map { _ in
        Int.random(in: 0...10000)
    }
    
    let start = NSDate()
    for index in 0..<length {
        wrapper.array[index] = randomNumbers[index]
    }
    
    let end = NSDate()
    
    return end.timeIntervalSince(start as Date)
}

public func testMemoryRead() -> Double {
    var wrapper = Singleton.memoryWrapper
    var readNumbers = Array(repeating: 0, count: wrapper.length)
    let length = wrapper.length
    
    let start = NSDate()
    for index in 0..<length {
        readNumbers[index] = wrapper.array[index]
    }
    
    let end = NSDate()
    
    return end.timeIntervalSince(start as Date)
    
}
