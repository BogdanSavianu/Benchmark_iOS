import SwiftUI

struct GPUResults: View {
    @State var isStandalone: Bool = false
    @State private var fps: Double = 0.0
    @State private var isTesting = false

    var body: some View {
        ZStack {
            if isStandalone {
                LinearGradient(
                    gradient: Gradient(colors: [.orange, .white]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
            }
            VStack(alignment: .leading) {
                Text("GPU Info")
                    .font(.headline)
                    .padding(.bottom)
                
                Text("Device Name: \(Singleton.gpuInfo.getGPUDeviceName())")
                Text("Supports Metal: \(Singleton.gpuInfo.supportsMetal() ? "Yes" : "No")")
                Text("Max Threads Per Threadgroup: \(Singleton.gpuInfo.getMaxThreadsPerThreadgroup())")
                
                if isTesting {
                    Text("Running Rendering Test...")
                        .foregroundColor(.blue)
                        .padding(.top)
                } else if fps > 0 {
                    Text("Average FPS: \(String(format: "%.2f", fps))")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .padding(.top)
                } else {
                    Text("Rendering Test Not Started")
                        .foregroundColor(.gray)
                        .padding(.top)
                }
            }
            .padding()
            .background(
                ZStack {
                    VisualEffectView(effect: .systemUltraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.white.opacity(0.6), lineWidth: 1)
                }
            )
            .blendMode(.hardLight)
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
            .onAppear {
                if Singleton.gpuInfo.supportsMetal() {
                    isTesting = true
                    runTestGPU(testFunction: { completion in
                        RenderPerformanceTest.runRenderingTest(duration: 5.0, completion: completion)
                    }) { resultFPS in
                        self.fps = resultFPS
                        self.isTesting = false
                    }
                }
            }
        }
    }
}

#Preview {
    GPUResults(isStandalone: true)
}
