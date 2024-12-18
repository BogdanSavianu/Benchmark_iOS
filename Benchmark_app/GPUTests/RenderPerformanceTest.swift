import Metal
import MetalKit
import UIKit
import simd

struct RenderPerformanceTest {
    static func runRenderingTest(duration: TimeInterval = 5, completion: @escaping (Double) -> Void) {
        guard let device = MTLCreateSystemDefaultDevice(),
              let commandQueue = device.makeCommandQueue() else {
            print("Metal is not supported on this device.")
            completion(0)
            return
        }

        let view = MTKView(frame: .zero, device: device)
        view.device = device
        view.isPaused = false
        view.enableSetNeedsDisplay = false
        view.preferredFramesPerSecond = 120

        var frameCount = 0
        let startTime = Date()

        let delegate = SphereRenderDelegate(device: device, commandQueue: commandQueue)
        view.delegate = delegate

        DispatchQueue.main.async {
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = UIViewController()
            window.rootViewController?.view.addSubview(view)
            window.makeKeyAndVisible()

            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                let elapsed = Date().timeIntervalSince(startTime)
                print("Rendering test completed with \(frameCount) frames")
                completion(Double(frameCount) / elapsed)
            }
        }

        DispatchQueue.global().async {
            while Date().timeIntervalSince(startTime) < duration {
                frameCount += 1
                usleep(16_667) // time between frames in microseconds
            }
        }
    }
}
