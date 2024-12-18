//
//  CompressionTests.swift
//  Benchmark_app
//
//  Created by Bogdan Savianu on 27.11.2024.
//

import Foundation
import DataCompression

struct CompressUtil {
    func compress(filePath: String) {
        let fileURL = Bundle.main.url(forResource: filePath, withExtension: "pdf")
        let fileData = try? Data(contentsOf: fileURL!)
        let _ = fileData?.compress(withAlgorithm: .lzfse)
    }
}

func compressionTests() -> Double {
    let start = DispatchTime.now()
    for _ in 0..<1000 {
        CompressUtil().compress(filePath: "compress_this")
    }
    let end = DispatchTime.now()
    let time = Double(end.uptimeNanoseconds - start.uptimeNanoseconds) / 1_000_000_000.0
    
    Singleton.calculator.cpuValues.append(Singleton.calculator.normalize(time, compressionReference))
    Singleton.calculator.totalValues.append(Singleton.calculator.normalize(time, compressionReference))
    
    return time
}
