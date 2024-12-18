//
//  Argon2Tests.swift
//  Benchmark_app
//
//  Created by Bogdan Savianu on 02.11.2024.
//

import Foundation
import Argon2Swift

struct Argon2Utility {
    func hashString(password: String, iterations: Int, memory: Int, parallelism: Int, length: Int) -> String {
        let s = Salt.newSalt()
        let result = try! Argon2Swift.hashPasswordString(password: password, salt: s, iterations: iterations, memory: memory, parallelism: parallelism, length: length, type: .id, version: .V13)
        return result.encodedString()
    }
    
    func randomAlphaNumericString(length: Int) -> String {
        let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let allowedCharsCount = UInt32(allowedChars.lengthOfBytes(using: .utf8))
        var randomString = ""

        for _ in 0 ..< length {
            let randomNum = Int(arc4random_uniform(allowedCharsCount))
            let randomIndex = allowedChars.index(allowedChars.startIndex, offsetBy: randomNum)
            let newCharacter = allowedChars[randomIndex]
            randomString += String(newCharacter)
        }

        return randomString
    }

}

public func testArgonEasy() -> Double {
    var password: String
    let start = DispatchTime.now()
    for _ in 0..<100 {
        password = Singleton.argonUtil.randomAlphaNumericString(length: 8)
        _ = Singleton.argonUtil.hashString(password: password, iterations: 10, memory: 256, parallelism: 10, length: 64)
    }
    let end = DispatchTime.now()
    let time = Double(end.uptimeNanoseconds - start.uptimeNanoseconds) / 1_000_000_000.0
        
    Singleton.calculator.cpuValues.append(Singleton.calculator.normalize(time, argonEasyReference))
    Singleton.calculator.totalValues.append(Singleton.calculator.normalize(time, argonEasyReference))
    
    return time
}

public func testArgonMedium() -> Double {
    var password: String
    
    let start = DispatchTime.now()
    for _ in 0..<10 {
        password = Singleton.argonUtil.randomAlphaNumericString(length: 12)
        _ = Singleton.argonUtil.hashString(password: password, iterations: 100, memory: 512, parallelism: 4, length: 128)
    }
    let end = DispatchTime.now()
    let time = Double(end.uptimeNanoseconds - start.uptimeNanoseconds) / 1_000_000_000.0
    
    Singleton.calculator.cpuValues.append(Singleton.calculator.normalize(time, argonMediumReference))
    Singleton.calculator.totalValues.append(Singleton.calculator.normalize(time, argonMediumReference))
    
    return time
}

public func testArgonHard() -> Double {
    var password: String
    
    let start = DispatchTime.now()
    password = Singleton.argonUtil.randomAlphaNumericString(length: 20)
    _ = Singleton.argonUtil.hashString(password: password, iterations: 1000, memory: 1024, parallelism: 1, length: 256)
    let end = DispatchTime.now()
    let time = Double(end.uptimeNanoseconds - start.uptimeNanoseconds) / 1_000_000_000.0
    
    Singleton.calculator.cpuValues.append(Singleton.calculator.normalize(time, argonHardReference))
    Singleton.calculator.totalValues.append(Singleton.calculator.normalize(time, argonHardReference))

    return time
}

