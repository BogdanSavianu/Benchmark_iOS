
//
//  VertexIn.swift
//  Benchmark_app
//
//  Created by Bogdan Savianu on 20.11.2024.
//


#include <metal_stdlib>
using namespace metal;

struct VertexIn {
    float3 position [[attribute(0)]];
};

vertex float4 vertex_main(const device float3 *vertices [[buffer(0)]], uint vertexID [[vertex_id]], constant float4x4 &modelViewProjection [[buffer(1)]]) {
    return modelViewProjection * float4(vertices[vertexID], 1.0);
}

fragment float4 fragment_main() {
    return float4(0.4, 0.8, 1.0, 1.0);
}
