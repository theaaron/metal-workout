//
//  Renderer.swift
//  Transformations
//
//  Created by aaron on 2/2/25.
//
import Foundation
import MetalKit

class Renderer: NSObject, MTKViewDelegate {
    var parent: ContentView
    var metalDevice: MTLDevice!
    var metalCommandQueue: MTLCommandQueue!
    let pipelineState: MTLRenderPipelineState
    var scene: RenderScene
    let mesh: TriangleMesh
    
    init(_ parent: ContentView) {
        self.parent = parent
        guard let metalDevice = MTLCreateSystemDefaultDevice() else {
            fatalError("Could not create Metal Device")
        }
        self.metalDevice = metalDevice
        metalCommandQueue = metalDevice.makeCommandQueue()
        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        let library = metalDevice.makeDefaultLibrary()
        pipelineDescriptor.vertexFunction = library?.makeFunction(name: "vertexShader")
        pipelineDescriptor.fragmentFunction = library?.makeFunction(name: "fragmentShader")
        pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        
        do {
            try pipelineState = metalDevice.makeRenderPipelineState(descriptor: pipelineDescriptor)
        } catch {
            fatalError("could not create pipeline state")
        }
        
        self.mesh = TriangleMesh(metalDevice: metalDevice)
        
        
        
        
    }
}
