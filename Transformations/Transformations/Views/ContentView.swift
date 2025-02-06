//
//  ContentView.swift
//  Transformations
//
//  Created by aaron on 2/2/25.
//

import SwiftUI
import MetalKit

struct AppView: View {
    var body: some View {
        ContentView()
            .ignoresSafeArea()
    }
}

struct ContentView: UIViewRepresentable {
    
    func makeCoordinator() -> Renderer {
        Renderer(self)
    }
    func makeUIView(context: UIViewRepresentableContext<ContentView>) -> MTKView {
        let mtkView = MTKView()
        mtkView.delegate = context.coordinator
        mtkView.preferredFramesPerSecond = 60
        mtkView.enableSetNeedsDisplay = false
        
        guard let metalDevice = MTLCreateSystemDefaultDevice() else {
            fatalError()
        }
        mtkView.device = metalDevice
        
        mtkView.framebufferOnly = false
        mtkView.drawableSize = mtkView.frame.size
        return mtkView
    }
    
    func updateUIView(_ uiView: MTKView, context: UIViewRepresentableContext<ContentView>) {
        
    }
}

#Preview {
    AppView()
}
