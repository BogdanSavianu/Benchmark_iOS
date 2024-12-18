//
//  RenderHelper.swift
//  Benchmark_app
//
//  Created by Bogdan Savianu on 20.11.2024.
//

import Metal
import MetalKit
import UIKit
import simd

class SphereRenderDelegate: NSObject, MTKViewDelegate {
    private let commandQueue: MTLCommandQueue
    private let device: MTLDevice
    private var pipelineState: MTLRenderPipelineState!
    private var vertexBuffer: MTLBuffer!
    private var indexBuffer: MTLBuffer!
    private var uniformBuffer: MTLBuffer!
    private var indexCount: Int = 0

    init(device: MTLDevice, commandQueue: MTLCommandQueue) {
        self.device = device
        self.commandQueue = commandQueue
        super.init()
        setupPipeline()
        setupSphere()
    }

    private func setupPipeline() {
        guard let library = device.makeDefaultLibrary() else { fatalError("Unable to load Metal library.") }
        let vertexFunction = library.makeFunction(name: "vertex_main")
        let fragmentFunction = library.makeFunction(name: "fragment_main")

        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        pipelineDescriptor.vertexFunction = vertexFunction
        pipelineDescriptor.fragmentFunction = fragmentFunction
        pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm

        pipelineState = try? device.makeRenderPipelineState(descriptor: pipelineDescriptor)
    }

    private func setupSphere() {
        let (vertices, indices) = generateSphere(radius: 3.0, latSegments: 40, longSegments: 40)
        vertexBuffer = device.makeBuffer(bytes: vertices, length: vertices.count * MemoryLayout<Float>.size, options: [])
        indexBuffer = device.makeBuffer(bytes: indices, length: indices.count * MemoryLayout<UInt16>.size, options: [])
        indexCount = indices.count

        let aspectRatio = Float(UIScreen.main.bounds.width / UIScreen.main.bounds.height)
        var mvpMatrix = makePerspectiveMatrix(fov: 60.0 * .pi / 180.0, aspect: aspectRatio, near: 0.1, far: 100.0)
        uniformBuffer = device.makeBuffer(bytes: &mvpMatrix, length: MemoryLayout<simd_float4x4>.size, options: [])
    }

    func draw(in view: MTKView) {
        guard let renderPassDescriptor = view.currentRenderPassDescriptor,
              let drawable = view.currentDrawable,
              let commandBuffer = commandQueue.makeCommandBuffer(),
              let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor) else { return }

        renderEncoder.setRenderPipelineState(pipelineState)
        renderEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderEncoder.setVertexBuffer(uniformBuffer, offset: 0, index: 1)
        renderEncoder.drawIndexedPrimitives(type: .triangle, indexCount: indexCount, indexType: .uint16, indexBuffer: indexBuffer, indexBufferOffset: 0)
        renderEncoder.endEncoding()

        commandBuffer.present(drawable)
        commandBuffer.commit()
    }

    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {}
}

func generateSphere(radius: Float, latSegments: Int, longSegments: Int) -> ([Float], [UInt16]) {
    var vertices: [Float] = []
    var indices: [UInt16] = []

    for lat in 0...latSegments {
        let theta = Float(lat) * .pi / Float(latSegments)
        let sinTheta = sin(theta)
        let cosTheta = cos(theta)

        for lon in 0...longSegments {
            let phi = Float(lon) * 2 * .pi / Float(longSegments)
            let sinPhi = sin(phi)
            let cosPhi = cos(phi)

            let x = radius * cosPhi * sinTheta
            let y = radius * cosTheta
            let z = radius * sinPhi * sinTheta

            vertices += [x, y, z]
        }
    }

    for x in 0..<latSegments {
        for y in 0..<longSegments {
            let first = UInt16((x * (longSegments + 1)) + y)
            let second = UInt16(Int(first) + longSegments + 1)

            indices += [first, second, first + 1]
            indices += [second, second + 1, first + 1]
        }
    }

    return (vertices, indices)
}

func makePerspectiveMatrix(fov: Float, aspect: Float, near: Float, far: Float) -> simd_float4x4 {
    let yScale = 1 / tan(fov * 0.5)
    let xScale = yScale / aspect
    let zRange = far - near
    let zScale = -(far + near) / zRange
    let wzScale = -2 * far * near / zRange

    return simd_float4x4(columns: (
        simd_float4(xScale, 0, 0, 0),
        simd_float4(0, yScale, 0, 0),
        simd_float4(0, 0, zScale, -1),
        simd_float4(0, 0, wzScale, 0)
    ))
}
