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
    static let fileWriter = FileWriter()
    static let cpuInfo = CPUInfo()
    static let systemInfo = SystemInfo()
    static var memoryWrapper = Wrapper(length: 20_000_000)
}

