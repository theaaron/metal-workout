import PlaygroundSupport
import MetalKit

guard let device = MTLCreateSystemDefaultDevice() else { fatalError("gpu not supported") }

// how the sketch will work

setup {
    createCanvas(w: 600, h: 400)
}

draw {
    sphere(r: 0.75, seg1: 100, seg2: 100)
    // overload functions for choice? or just make a decision and stick with it?
    // named parameters or no named parameters.
    sphere(0.75, 100, 100)

}



// this is all the logic that will be abstracted away

func createCanvas(w: Int, h: Int) {
    frame = CGRect(x: 0, y: 0, width: w, height: h)
}



var frame = CGRect(x: 0, y: 0, width: 600, height: 600)
let view = MTKView(frame: frame, device: device)

//setting the background color as cream
view.clearColor = MTLClearColor(red: 1.0, green: 1.0, blue: 0.8, alpha: 1.0)

//buffer to manage memory of our model i/o mesh
let allocator = MTKMeshBufferAllocator(device: device)
//creating a model i/o mesh, a sphere
let mdlMesh = MDLMesh(sphereWithExtent: [0.75, 0.75, 0.75], segments: [100, 100], inwardNormals: false, geometryType: .triangles, allocator: allocator)
let mesh = try MTKMesh(mesh: mdlMesh, device: device)

//queues, buffers, and encoders

guard let commandQueue = device.makeCommandQueue() else { fatalError("command queue could not be created.") }

//creating vertex and frag shaders. this would typically go in a different file with a .metal extension.
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
    return float4(1, 0, 0, 1);
}

"""

//making a library of our shader, and then making functions of the vert and frag shaders.
let library = try device.makeLibrary(source: shader, options: nil)
let vertexFunction = library.makeFunction(name: "vertex_main")
let fragmentFunction = library.makeFunction(name: "fragment_main")



func setup(_ method: () -> Void) {
    method()
}

func draw(_ method: () -> Void) {
    method()
}

func sphere(r: Float, seg1: Int, seg2: Int) {
    let mdlMesh = MDLMesh(sphereWithExtent: [r, r, r], segments: [UInt32(seg1), UInt32(seg2)], inwardNormals: false, geometryType: .triangles, allocator: allocator)
    guard let mesh = try? MTKMesh(mesh: mdlMesh, device: device) else { return }
    
    //draw sphere after this
}

func sphere(_ r: Float, _ seg1: Int, _ seg2: Int) {
    let mdlMesh = MDLMesh(sphereWithExtent: [r, r, r], segments: [UInt32(seg1), UInt32(seg2)], inwardNormals: false, geometryType: .triangles, allocator: allocator)
    guard let mesh = try? MTKMesh(mesh: mdlMesh, device: device) else { return }
    
    //draw sphere after this
}
