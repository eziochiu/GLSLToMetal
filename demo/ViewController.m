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
@property (weak) IBOutlet NSImageCell *imageView;
@property (nonatomic, strong) OEFilterChain *filterChain;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MTKTextureLoader *loader = [[MTKTextureLoader alloc] initWithDevice:MTLCreateSystemDefaultDevice()];
    NSData *imagedata = [self.imageView.image TIFFRepresentation];
    id <MTLTexture> texture = [loader newTextureWithData:imagedata options:@{MTKTextureLoaderOptionSRGB:@(NO)} error:nil];
    
    
    NSString *path = @"/Users/eziochiu/Downloads/Shaders/scalehq/4xScaleHQ.slangp";
    NSURL *pathUrl = [NSURL fileURLWithPath:path];
    NSLog(@"loading shader from %@", [pathUrl.absoluteString stringByDeletingPathExtension]);
    
    self.filterChain = [[OEFilterChain alloc] initWithDevice:MTLCreateSystemDefaultDevice()];
    self.filterChain.sourceTexture = texture;
    [self.filterChain setSourceRect:self.view.bounds aspect:self.view.bounds.size];
    self.filterChain.drawableSize = [NSScreen mainScreen].frame.size;
    [self.filterChain setDefaultFilteringLinear:NO];
    [self.filterChain setShaderFromURL:pathUrl error:nil];
    
    
    for (int i = 0; i < 30; i++) {
        NSBitmapImageRep *imageRep = [self.filterChain captureOutputImage];
        NSImage * image = [[NSImage alloc] initWithSize:[imageRep size]];
        [image addRepresentation: imageRep];
        self.imageView.image = image;
    }
    // Do any additional setup after loading the view.
}



- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
