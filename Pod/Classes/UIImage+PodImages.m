//
//  UIImage+PodImages.m
//  Pods
//
//  Created by Robin Crorie on 12/08/2015.
//
//

#import "UIImage+PodImages.h"
#import "NSMessageData.h"

@implementation UIImage (PodImages)

+ (UIImage*)podImageNamed:(NSString*)name {
    UIImage *imageFromMainBundle = [UIImage imageNamed:name];
    if (imageFromMainBundle) {
        return imageFromMainBundle;
    }
    
    NSBundle *bundle = [NSBundle bundleForClass:[NSMessageData class]];
    UIImage *imageFromMyLibraryBundle = [UIImage imageNamed:name inBundle:bundle compatibleWithTraitCollection:nil];
                                         
    return imageFromMyLibraryBundle;
}

@end
