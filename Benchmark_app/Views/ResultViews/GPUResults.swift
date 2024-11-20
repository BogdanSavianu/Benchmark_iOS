import SwiftUI

struct GPUResults: View {
    @State private var fps: Double = 0.0
    @State private var isTesting = false

    var body: some View {
        VStack(alignment: .leading) {
            Text("GPU Info")
                .font(.headline)
                .padding(.bottom)

            Text("Device Name: \(getGPUDeviceName())")
            Text("Supports Metal: \(supportsMetal() ? "Yes" : "No")")
            Text("Max Threads Per Threadgroup: \(getMaxThreadsPerThreadgroup())")

            if isTesting {
                Text("Running Rendering Test...")
                    .foregroundColor(.blue)
                    .padding(.top)
            } else if fps > 0 {
                Text("Average FPS: \(String(format: "%.2f", fps))")
                    .font(.headline)
                    .foregroundColor(.green)
                    .padding(.top)
            } else {
                Text("Rendering Test Not Started")
                    .foregroundColor(.gray)
                    .padding(.top)
            }
        }
        .padding()
        .onAppear {
            if supportsMetal() {
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

#Preview {
    GPUResults()
}
