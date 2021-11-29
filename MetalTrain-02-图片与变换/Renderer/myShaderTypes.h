//
//  myShaderTypes.h
//  MetalTrain
//
//  Created by kissingfire123 on 2021/10/29.
//

#ifndef myShaderTypes_h
#define myShaderTypes_h
// 这个头文件可以在oc和metal通用
#include <simd/simd.h>

// 为vertex-id保持一致,使用enum更安全不易出错
typedef enum myVertexInputIndex
{
    myVertexInputIndexVertices     = 0,
    myVertexInputIndexViewportSize = 1,
} myVertexInputIndex;

//  顶点数据的位置,颜色信息,可在oc和metal间通用,传递顶点信息
typedef struct
{
    vector_float2 position;
    vector_float4 color;
} myVertex;



#endif /* myShaderTypes_h */
