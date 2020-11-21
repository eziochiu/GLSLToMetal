//
//  main.m
//  shaders
//
//  Created by admin on 2020/11/20.
//  Copyright © 2020 OpenEmu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenEmuShaders/OpenEmuShaders.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        OEFilterChain *emu = [[OEFilterChain alloc] initWithDevice:MTLCreateSystemDefaultDevice()];
        NSString *path = @"/Users/eziochiu/Desktop/Shaders/xBRZ Freescale/xBRZ Freescale.slangp";
        NSURL *pathUrl = [NSURL fileURLWithPath:path];
        NSLog(@"loading shader from %@", [pathUrl.absoluteString stringByDeletingPathExtension]);
        [emu setShaderFromURL:pathUrl error:nil];
    }
    return 0;
}
