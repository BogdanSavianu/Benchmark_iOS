//
//  VisualEffectView.swift
//  Benchmark_app
//
//  Created by Bogdan Savianu on 29.11.2024.
//


import SwiftUI

struct VisualEffectView: UIViewRepresentable {
    var effect: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: effect))
        return view
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: effect)
    }
}
