//
//  myShaderTypes.h
//  MetalTrain
//
//  Created by kissingfire123 on 2021/10/29.
//

#ifndef myShaderTypes_h
#define myShaderTypes_h

#include <simd/simd.h>

// Buffer index values shared between shader and C code to ensure Metal shader buffer inputs
// match Metal API buffer set calls.
typedef enum myVertexInputIndex
{
    myVertexInputIndexVertices     = 0,
    myVertexInputIndexViewportSize = 1,
} myVertexInputIndex;

//  This structure defines the layout of vertices sent to the vertex
//  shader. This header is shared between the .metal shader and C code, to guarantee that
//  the layout of the vertex array in the C code matches the layout that the .metal
//  vertex shader expects.
typedef struct
{
    vector_float2 position;
    vector_float4 color;
} myVertex;



#endif /* myShaderTypes_h */
