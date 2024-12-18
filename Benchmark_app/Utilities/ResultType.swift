//
//  ResultType.swift
//  Benchmark_app
//
//  Created by Bogdan Savianu on 02.12.2024.
//
import Foundation

struct ResultType: Identifiable {
    let id =  UUID()
    let device: String
    let value: Int
    let date: Date
}
