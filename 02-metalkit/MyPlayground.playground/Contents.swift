import MetalKit
import Foundation

guard let device = MTLCreateSystemDefaultDevice() else { fatalError("gpu not supported")}

print(device.name)

//lets create a frame

let frame = CGRect(x: 0, y: 0, width: 600, height: 600)
let view = MTKView(frame: frame, device: device)
// a background color for the view, it's a cream color.
view.clearColor = MTLClearColor(red: 1, green: 1, blue: 0.8, alpha: 1)

//using model i/o to load 3d models
// allocator manages the memory for the mesh data
let allocator = MTKMeshBufferAllocator(device: device)
// model i/o creates a sphere with the following properties, and
// stores the information in the buffer (the constant named allocator)
let mdlMesh = MDLMesh(sphereWithExtent: [0.75, 0.75, 0.75], segments: [100, 100], inwardNormals: false, geometryType: .triangles, allocator: allocator)
// in order for Metal to be able to use this mesh, we convert it
// to a MetalKit Mesh
let mesh = try MTKMesh(mesh: mdlMesh, device: device)


// queues, buffers and encoders
//generally, the commandQueue and the device should be created at the start of the app.
//you should use the same device and command queue throughout the app
// command queue => command buffer => command encoder
// each frame will have a list of commands in a command encoder.
// the command buffer will organize these commands in the encoder.
// the command queue will organize the command buffers.
guard let commandQueue = device.makeCommandQueue() else { fatalError("could not create Command Queue") }

// shaders
//this is the vertex and frag shader
let shader = """
#include <metal_stdlib>
using namespace metal;

struct VertexIn {
    float4 position [[attribute(0)]];
};

vertex float4 vertex_main(const VertexIn vertex_in [[stage_in]])
{
    return vertex_in.position;
}

fragment float4 fragment_main() {
    return float4(1,0,0,1);
}
"""

//to use these shaders, we need to set up a metal library.

let library = try device.makeLibrary(source: shader, options: nil)

let vertexFunction = library.makeFunction(name: "vertex_main")
let fragmentFunction = library.makeFunction(name: "fragment_main")

// pipeline state
//this is where we set pu a pipeline state for the gpu.

// by setting this state, we tell the gpu that nothing will change unless the state changes.

// the pipeline state holds the information about the pixel format and other things
// that the gpu needs knowledge of
// We don't create the pipeline state directly, we so so by using a descriptor

let pipelineDescriptor = MTLRenderPipelineDescriptor()
// pixel format is 8 unsigned integers in blue, green, red, alpha order
pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
//we also add the shader functions to the pipeline descriptor
pipelineDescriptor.vertexFunction = vertexFunction
pipelineDescriptor.fragmentFunction = fragmentFunction


