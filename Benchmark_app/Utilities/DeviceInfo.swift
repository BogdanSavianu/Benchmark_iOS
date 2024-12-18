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
    
    static func getDeviceModel() -> String {
            var systemInfo = utsname()
            uname(&systemInfo)
            
            let machineMirror = Mirror(reflecting: systemInfo.machine)
            let model = machineMirror.children.reduce("") { (current, element) in
                guard let value = element.value as? Int8, value != 0 else { return current }
                return current + String(UnicodeScalar(UInt8(value)))
            }
            return model
        }
}

struct SystemInfo {
    let systemVersion = UIDevice.current.systemVersion
    let deviceModel = CPUInfo.getDeviceModel()
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
