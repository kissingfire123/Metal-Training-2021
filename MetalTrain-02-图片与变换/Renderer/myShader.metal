//
//  myShader.metal
//  MetalTrain
//
//  Created by kissingfire123 on 2021/10/29.
//
#include <metal_stdlib>

using namespace metal;

// oc和metal通用的头文件
#include "myShaderTypes.h"

// Vertex shader outputs and fragment shader inputs
struct RasterizerData
{
    // The [[position]] 属性,标识这是顶点数据
    float4 position [[position]];

    // 颜色,不带属性,由metal自动线性插值后，由vertex-shader传递给fragment-shader
    float4 color;
};

vertex RasterizerData
vertexShader(uint vertexID [[vertex_id]],// vertex_id是顶点shader每次处理的index，用于定位当前的顶点
             constant myVertex *vertices [[buffer(myVertexInputIndexVertices)]],
             constant vector_uint2 *viewportSizePointer [[buffer(myVertexInputIndexViewportSize)]])
{
    RasterizerData out;

    // 当前vertex_id的屏幕Pixel位置
    float2 pixelSpacePosition = vertices[vertexID].position.xy;

    // Get the viewport size and cast to float.
    vector_float2 viewportSize = vector_float2(*viewportSizePointer);
    

    // 屏幕的pixel-position转换到标准化的clip-space像素裁剪空间
    out.position = vector_float4(0.0, 0.0, 0.0, 1.0);
    out.position.xy = pixelSpacePosition / (viewportSize / 2.0);

    // Pass the input color directly to the rasterizer.
    out.color = vertices[vertexID].color;

    return out;
}

fragment float4 fragmentShader(RasterizerData in [[stage_in]])
{
    // Return the interpolated color.
    return in.color;
}



