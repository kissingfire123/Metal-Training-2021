//
//  ViewController.m
//  MetalTrain
//
//  Created by kissingfire123 on 2021/10/29.
//

#import "ViewController.h"
#import "myRenderer.h"
@interface ViewController ()

@end

@implementation ViewController
{
    MTKView *_view;

    myRenderer *_renderer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Set the view to use the default device
    _view = [[MTKView alloc] initWithFrame:self.view.bounds];
    _view.device = MTLCreateSystemDefaultDevice();
    self.view = _view;
    
    NSAssert(_view.device, @"Metal is not supported on this device");
    
    _renderer = [[myRenderer alloc] initWithMetalKitView:_view];
    
    NSAssert(_renderer, @"Renderer failed initialization");

    // Initialize our renderer with the view size
    [_renderer mtkView:_view drawableSizeWillChange:_view.drawableSize];

    _view.delegate = _renderer;
}


@end
