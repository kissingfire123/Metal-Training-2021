//
//  ViewController.m
//  LearnMetal
//
//  Created by kissingfire123 on 2021/10/28.
//  Copyright © 2021年 kissingfire123. All rights reserved.
//
#import <MetalKit/MetalKit.h>

#import "ViewController.h"


@interface ViewController()  <MTKViewDelegate>

// view
@property (nonatomic, strong) MTKView *mtkView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor: UIColor.whiteColor];
    NSLog(@"now it's loading ...");
}


- (void)drawInMTKView:(nonnull MTKView *)view {
    //
    NSLog(@"now it's drawing ...");
}

- (void)mtkView:(nonnull MTKView *)view drawableSizeWillChange:(CGSize)size {
    //
}



@end
