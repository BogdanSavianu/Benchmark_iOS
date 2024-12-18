//
//  FileWriter.swift
//  Benchmark_app
//
//  Created by Bogdan Savianu on 20.11.2024.
//

import Foundation

struct FileWorker {
    func write(_ result: String) {
        let deviceName = Singleton.systemInfo.deviceModel
        let deviceNameFormatted = deviceName.replacingOccurrences(of: ",", with: ".")
        let currentDate = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = dateFormatter.string(from: currentDate)
        
        let resultString = "\(deviceNameFormatted), \(result), \(formattedDate)\n"
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let filename = documentsDirectory?.appendingPathComponent("output.txt")
        
        do {
            if let filename = filename {
                if FileManager.default.fileExists(atPath: filename.path) {
                    if let fileHandle = FileHandle(forWritingAtPath: filename.path) {
                        fileHandle.seekToEndOfFile()
                        if let data = resultString.data(using: .utf8) {
                            fileHandle.write(data)
                        }
                        fileHandle.closeFile()
                    } else {
                        print("Failed to open file handle.")
                    }
                } else {
                    try resultString.write(to: filename, atomically: true, encoding: .utf8)
                }
                
                print("Result written successfully to: \(filename.path)")
            } else {
                print("Failed to create file path.")
            }
        } catch {
            print("Error writing file: \(error.localizedDescription)")
        }
    }
    
    func read() -> [[ResultType]] {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let filename = documentsDirectory?.appendingPathComponent("output.txt")
        
        if let filename = filename, FileManager.default.fileExists(atPath: filename.path) {
            print("File exists at: \(filename.path)")
            
            do {
                let data = try String(contentsOf: filename, encoding: .utf8)
                print("File content: \(data)")
                
                let lines = data.split(separator: "\n")
                var groupedResults: [[ResultType]] = []
                
                let dateFormatter: DateFormatter = {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    return formatter
                }()
                
                var currentGroup: [ResultType] = []
                
                for line in lines {
                    let components = line.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
                    if components.count == 3 {
                        let device = String(components[0])
                        if let value = Double(components[1]), let date = dateFormatter.date(from: components[2]) {
                            let result = ResultType(device: device, value: Int(value), date: date)
                            currentGroup.append(result)
                            
                            if currentGroup.count == 4 {
                                groupedResults.append(currentGroup)
                                currentGroup.removeAll()
                            }
                        }
                    }
                }
                
                if !currentGroup.isEmpty {
                    print("Incomplete group detected, skipping: \(currentGroup)")
                }
                
                return groupedResults
            } catch {
                print("Error reading file: \(error.localizedDescription)")
            }
        } else {
            print("File does not exist or path is incorrect")
        }
        
        return []
    }
}
