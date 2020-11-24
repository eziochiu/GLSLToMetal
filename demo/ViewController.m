//
//  ViewController.m
//  demo
//
//  Created by Ezio Chiu on 11/21/20.
//  Copyright © 2020 OpenEmu. All rights reserved.
//

#import "ViewController.h"
#import <OpenEmuShaders/OpenEmuShaders.h>
#import <MetalKit/MetalKit.h>

@interface ViewController ()
@property (weak) IBOutlet NSImageView *imageView1;
@property (weak) IBOutlet NSImageView *imageView2;
@property (nonatomic, strong) OEFilterChain *filterChain;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MTKTextureLoader *loader = [[MTKTextureLoader alloc] initWithDevice:MTLCreateSystemDefaultDevice()];
    NSData *imagedata1 = [self.imageView1.image TIFFRepresentation];
    id <MTLTexture> texture1 = [loader newTextureWithData:imagedata1 options:@{MTKTextureLoaderOptionSRGB:@(NO)} error:nil];
    
    NSData *imagedata2 = [self.imageView2.image TIFFRepresentation];
    id <MTLTexture> texture2 = [loader newTextureWithData:imagedata2 options:@{MTKTextureLoaderOptionSRGB:@(NO)} error:nil];
    
    
    NSString *pathLeft = @"/Users/admin/Downloads/slang-shaders/sabr/sabr.slangp";
    NSURL *pathUrlLeft = [NSURL fileURLWithPath:pathLeft];
    
    NSString *pathRight = @"/Users/admin/Downloads/slang-shaders/xbrz/xbrz-freescale.slangp";
    NSURL *pathUrlRight = [NSURL fileURLWithPath:pathRight];
    
    self.filterChain = [[OEFilterChain alloc] initWithDevice:MTLCreateSystemDefaultDevice()];
    [self.filterChain setSourceRect:self.view.bounds aspect:self.view.bounds.size];
    self.filterChain.drawableSize = [NSScreen mainScreen].frame.size;
    [self.filterChain setDefaultFilteringLinear:NO];
    
    
//    self.filterChain.sourceTexture = texture1;
//    [self.filterChain setShaderFromURL:pathUrlLeft error:nil];
//
//    NSBitmapImageRep *imageRep1 = [self.filterChain captureOutputImage];
//    NSImage * image1 = [[NSImage alloc] initWithSize:[imageRep1 size]];
//    [image1 addRepresentation: imageRep1];
//    self.imageView1.image = image1;
    
    self.filterChain.sourceTexture = texture2;
    [self.filterChain setShaderFromURL:pathUrlRight error:nil];
    
    NSBitmapImageRep *imageRep2 = [self.filterChain captureOutputImage];
    NSImage * image2 = [[NSImage alloc] initWithSize:[imageRep2 size]];
    [image2 addRepresentation: imageRep2];
    self.imageView2.image = image2;
    
    // Do any additional setup after loading the view.
}



- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
