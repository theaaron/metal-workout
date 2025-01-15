import PlaygroundSupport
import MetalKit

guard let device = MTLCreateSystemDefaultDevice() else { fatalError("gpu not supported") }

let frame = CGRect(x: 0, y: 0, width: 600, height: 600)
let view = MTKView(frame: frame, device: device)
//setting the background color as cream
view.clearColor = MTLClearColor(red: 1.0, green: 1.0, blue: 0.8, alpha: 1.0)

//buffer to manage memory of our model i/o mesh
let allocator = MTKMeshBufferAllocator(device: device)
//creating a model i/o mesh, a sphere
let mdlMesh = MDLMesh(sphereWithExtent: [0.75, 0.75, 0.75], segments: [100, 100], inwardNormals: false, geometryType: .triangles, allocator: allocator)
let mesh = try MTKMesh(mesh: mdlMesh, device: device)

//queues, buffers, and encoders



print("yay")
