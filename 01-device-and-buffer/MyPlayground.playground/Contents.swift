import Metal

// Starting off by creating a device.
let device = MTLCreateSystemDefaultDevice()!
// ok so that's how you create a device. I wonder what this device is.
print(device.name)
// ok, so it an apple ios simulator gpu. got it.


// lets move on. now we need a buffer.
// we need this buffer so we can put some data in our memory.
let buffer = device.makeBuffer(length: 16, options: [])!

// ok, so that's a buffer. what are we doing here?
// we are using the makeBuffer method on the device to create a buffer.
// we've set the buffer's length to 16.
// this means that the length of this buffer is 16 bytes of memory.
// we'll talk about the options later.

let pointer = buffer.contents()
// now this is a pointer to those 16 bytes of memory.

let points = pointer.bindMemory(to: SIMD2<Float>.self, capacity: 2)
// this is an array. the length of this array is 2, per the capacity parameter.
// the type of this array is SIMD2<Float>. this is like a 2d vector of floats.
// so this array can hold two items, and those items will be 2d vectors.
// something like this: [(1.0, 1.0), (2.0, 2.0)]

points[0] = SIMD2<Float>(1.0, 1.0)
points[1] = SIMD2<Float>(10.0, 10.0)

print(points[0] + points[1])
//wow, look at that. we can do some vector math here.


