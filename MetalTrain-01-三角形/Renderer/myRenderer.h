//
//  myRenderer.h
//  MetalTrain
//
//  Created by kissingfire123 on 2021/10/29.
//

#ifndef myRenderer_h
#define myRenderer_h
@import MetalKit;

@interface myRenderer : NSObject<MTKViewDelegate>

- (nonnull instancetype)initWithMetalKitView:(nonnull MTKView *)mtkView;

@end

#endif /* myRenderer_h */
