import SwiftUI

struct ContentView: View {
    @State private var navigateToCompleteResults = false
    @State private var navigateToCPUResults = false
    @State private var navigateToGPUResults = false
    @State private var navigateToMemoryResults = false
    @State private var navigateToLeaderbaord = false
    @State private var navigateToChart = false


    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [.green, .cyan]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack {
                    Text("Welcome to iOS Benchmarking")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .padding(.bottom, 40)
                    
                    HStack {
                        Spacer(minLength: 20)
                        VStack {
                            
                            VStack(alignment: .leading, spacing: 20) {
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
                                    navigateToLeaderbaord = true
                                }
                                
                                ButtonView(title: "Chart") {
                                    navigateToChart = true
                                }
                            }
                            .padding()
                        }
                        Spacer(minLength: 200)
                    }
                }
            }
            .navigationDestination(isPresented: $navigateToCPUResults) {
                CPUResults(isStandalone: true)
            }
            .navigationDestination(isPresented: $navigateToGPUResults) {
                GPUResults(isStandalone: true)
            }
            .navigationDestination(isPresented: $navigateToCompleteResults) {
                CompleteResults()
            }
            .navigationDestination(isPresented: $navigateToMemoryResults) {
                MemoryResults(isStandalone: true)
            }
            .navigationDestination(isPresented: $navigateToLeaderbaord) {
                LeaderboardView()
            }
            .navigationDestination(isPresented: $navigateToChart) {
                GraphView()
            }
        }
    }
}

#Preview {
    ContentView()
}
