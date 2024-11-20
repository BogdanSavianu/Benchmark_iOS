import SwiftUI

struct ContentView: View {
    @State private var navigateToCompleteResults = false
    @State private var navigateToCPUResults = false
    @State private var navigateToGPUResults = false
    @State private var navigateToMemoryResults = false

    var body: some View {
        NavigationStack {
            HStack {
                Spacer()
                VStack(alignment: .leading) {
                    Spacer()
                    
                    ButtonView(title: "Complete Run") {
                        navigateToCompleteResults = true
                    }
                    
                    ButtonView(title: "CPU Test") {
                        navigateToCPUResults = true
                    }
                    
                    ButtonView(title: "GPU Test") {
                        navigateToGPUResults = true
                    }
                    
                    ButtonView(title: "Memory Test") {
                        navigateToMemoryResults = true
                    }
                    
                    ButtonView(title: "Leaderboard") {
                    }
                    
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                }
                .padding()
                
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [.green, .cyan]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
            )
            .navigationDestination(isPresented: $navigateToCPUResults) {
                CPUResults()
            }
            .navigationDestination(isPresented: $navigateToGPUResults) {
                GPUResults()
            }
            .navigationDestination(isPresented: $navigateToCompleteResults) {
                CompleteResults()
            }
            .navigationDestination(isPresented: $navigateToMemoryResults) {
                MemoryResults()
            }
        }
    }
}

#Preview {
    ContentView()
}
