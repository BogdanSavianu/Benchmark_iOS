//
//  CPUInfo.swift
//  Benchmark_app
//
//  Created by Bogdan Savianu on 20.11.2024.
//

import Foundation
import SwiftUI

struct CPUInfo {
    let processorCount = ProcessInfo.processInfo.processorCount
    let activeProcessorCount = ProcessInfo.processInfo.activeProcessorCount
    let physicalMemory = ProcessInfo.processInfo.physicalMemory
}

struct SystemInfo {
    let systemVersion = UIDevice.current.systemVersion
    let deviceModel = UIDevice.current.model
    let deviceName = UIDevice.current.name
}

struct GPUInfo {
    func getGPUDeviceName() -> String {
        guard let device = MTLCreateSystemDefaultDevice() else {
            return "No Metal device available"
        }
        return device.name
    }

    func getMaxThreadsPerThreadgroup() -> Int {
        guard let device = MTLCreateSystemDefaultDevice() else {
            return 0
        }
        return device.maxThreadsPerThreadgroup.width
    }

    func supportsMetal() -> Bool {
        return MTLCreateSystemDefaultDevice() != nil
    }
}
