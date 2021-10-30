//
//  myRenderer.m
//  MetalTrain
//
//  Created by kissingfire123 on 2021/10/29.
//

#import <Foundation/Foundation.h>

@import simd;
@import MetalKit;

#import "myRenderer.h"

// oc和metal通用的头文件
#import "myShaderTypes.h"

// 渲染类
@implementation myRenderer
{
    id<MTLDevice> _device;

    // 基于shader创建的pipelineState.
    id<MTLRenderPipelineState> _pipelineState;

    // 渲染指令队列，保证渲染指令有序地提交到GPU
    id<MTLCommandQueue> _commandQueue;

    // 当前的viewSize，需传递给Shader
    vector_uint2 _viewportSize;
    
    //顶点数据
    myVertex* _verticesData;
    NSUInteger _vertexNum;
}

-(void)setupVertex{
    static const myVertex triangleVertices[] =
    {
        // 2D positions,    RGBA colors
        { {  300,  -200 }, { 1, 0, 0, 1 } },
        { { -300,  -200 }, { 0, 1, 0, 1 } },
        { {    0,   200 }, { 0, 0, 1, 1 } },
    };
    _verticesData = (myVertex*)(&triangleVertices[0]);
    _vertexNum = sizeof(triangleVertices)/ sizeof(myVertex);
}

- (nonnull instancetype)initWithMetalKitView:(nonnull MTKView *)mtkView
{
    self = [super init];
    if(self == nil){
        NSLog(@"init MtkView failed!!! \n");
        return nil;
    }
    
    [self setupVertex];
    NSError *error;

    _device = mtkView.device;

    // 该方法加载工程内就,所有metal后缀名的shader文件内容
    //获得MTLLibrary还存在另外一种方法,shader存成文本文件,不以metal为后缀名,像openGL的shader一样读成字符串,[_device newLibraryWithSource:fileContentStr]
    id<MTLLibrary> defaultLibrary = [_device newDefaultLibrary];
    id<MTLFunction> vertexFunction = [defaultLibrary newFunctionWithName:@"vertexShader"];
    id<MTLFunction> fragmentFunction = [defaultLibrary newFunctionWithName:@"fragmentShader"];

    // Configure a pipeline descriptor that is used to create a pipeline state.
    MTLRenderPipelineDescriptor *pipelineStateDescriptor = [[MTLRenderPipelineDescriptor alloc] init];
    pipelineStateDescriptor.label = @"Simple Pipeline";
    pipelineStateDescriptor.vertexFunction = vertexFunction;
    pipelineStateDescriptor.fragmentFunction = fragmentFunction;
    pipelineStateDescriptor.colorAttachments[0].pixelFormat = mtkView.colorPixelFormat;
    // 创建图形渲染管道，耗性能操作不宜频繁调用
    _pipelineState = [_device newRenderPipelineStateWithDescriptor:pipelineStateDescriptor
                                                             error:&error];
            
    // 当属性设置不合理,Pipeline State 可能会创建失败
    NSAssert(_pipelineState, @"Failed to create pipeline state: %@", error);

    // Create the command queue
    _commandQueue = [_device newCommandQueue];
    return self;
}

/// MTKView的resize代理方法,自动调用,也可手动调用
- (void)mtkView:(nonnull MTKView *)view drawableSizeWillChange:(CGSize)size
{
    // Save the size of the drawable to pass to the vertex shader.
    _viewportSize.x = size.width;
    _viewportSize.y = size.height;
}

/// MTKView的draw代理方法
- (void)drawInMTKView:(nonnull MTKView *)view
{
    // 每次渲染都创建一个 command buffer.
    id<MTLCommandBuffer> commandBuffer = [_commandQueue commandBuffer];
    commandBuffer.label = @"MyCommand";

    // renderPassDescriptor 描述渲染管线状态
    MTLRenderPassDescriptor *renderPassDescriptor = view.currentRenderPassDescriptor;
    renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColorMake(0.3, 0.6, 0.4, 1.0); // 设置背景色

    if(renderPassDescriptor != nil)
    {
        // 创建 render command encoder.
        id<MTLRenderCommandEncoder> renderEncoder =
        [commandBuffer renderCommandEncoderWithDescriptor:renderPassDescriptor];
        renderEncoder.label = @"MyRenderEncoder";

        // Set the region of the drawable to draw into.
        [renderEncoder setViewport:(MTLViewport){0.0, 0.0, _viewportSize.x, _viewportSize.y, 0.0, 1.0 }];
        
        [renderEncoder setRenderPipelineState:_pipelineState];

        // 传递顶点等数据
        [renderEncoder setVertexBytes:_verticesData
                               length:sizeof(myVertex)*_vertexNum
                              atIndex:myVertexInputIndexVertices];
        
        [renderEncoder setVertexBytes:&_viewportSize
                               length:sizeof(_viewportSize)
                              atIndex:myVertexInputIndexViewportSize];

        // 图元绘制
        [renderEncoder drawPrimitives:MTLPrimitiveTypeTriangle
                          vertexStart:0
                          vertexCount:_vertexNum];

        [renderEncoder endEncoding];

        // Schedule a present once the framebuffer is complete using the current drawable.
        [commandBuffer presentDrawable:view.currentDrawable];
    }

    // Finalize rendering here & push the command buffer to the GPU.
    [commandBuffer commit];
}

@end
