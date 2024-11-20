//
//  SystemInformation.swift
//  Benchmark_app
//
//  Created by Bogdan Savianu on 08.11.2024.
//

import SwiftUI

struct SystemInformation: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Device Info")
                .font(.headline)
                .padding(.bottom)
            
            Text("Device Name: \(Singleton.systemInfo.deviceName)")
            Text("Device Model: \(Singleton.systemInfo.deviceModel)")
            Text("System Version: \(Singleton.systemInfo.systemVersion)")
        }
        .padding()
    }
}

#Preview {
    SystemInformation()
}
