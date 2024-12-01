//
//  FileWriter.swift
//  Benchmark_app
//
//  Created by Bogdan Savianu on 20.11.2024.
//

import Foundation

struct FileWriter {
    func write(_ result: String) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let filename = documentsDirectory?.appendingPathComponent("output.txt")
        
        do {
            if let filename = filename {
                if FileManager.default.fileExists(atPath: filename.path) {
                    if let fileHandle = FileHandle(forWritingAtPath: filename.path) {
                        fileHandle.seekToEndOfFile()
                        let result_ = result+"\n"
                        if let data = result_.data(using: .utf8) {
                            fileHandle.write(data)
                        }
                        fileHandle.closeFile()
                    } else {
                        print("Failed to open file handle.")
                    }
                } else {
                    let result_ = result+"\n"
                     try result_.write(to: filename, atomically: true, encoding: .utf8)
                }

                print("Result written successfully to: \(filename.path)")
            } else {
                print("Failed to create file path.")
            }
        } catch {
            print("Error writing file: \(error.localizedDescription)")
        }
    }
}
