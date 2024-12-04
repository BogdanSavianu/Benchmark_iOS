//
//  Singleton.swift
//  Benchmark_app
//
//  Created by Bogdan Savianu on 12.11.2024.
//
import Foundation

public struct Singleton {
    static let serialTestQueue = DispatchQueue(label: "com.bogdan.benchmark.serialTestQueue")
    static let argonUtil = Argon2Utility()
    static let fileWorker = FileWorker()
    static let cpuInfo = CPUInfo()
    static let gpuInfo = GPUInfo()
    static let systemInfo = SystemInfo()
    static var memoryWrapper = Wrapper(length: 10_000_000)
    static var calculator = Calculator()
    static let totalTests = 11
}

