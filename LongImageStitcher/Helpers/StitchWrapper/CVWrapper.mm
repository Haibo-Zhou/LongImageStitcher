//
//  CVWrapper.m
//  CVOpenTemplate
//
//  Created by Washe on 02/01/2013.
//  Copyright (c) 2013 foundry. All rights reserved.
//

#import "CVWrapper.h"
#import "UIImage+OpenCV.h"
#import "stitching.h"
#import "UIImage+Rotate.h"


@implementation CVWrapper

+ (UIImage*) processImageWithOpenCV: (UIImage*) inputImage
{
    NSArray* imageArray = [NSArray arrayWithObject:inputImage];
    int status;
    UIImage* result = [[self class] processWithArray:imageArray status:&status];
    return result;
}

+ (UIImage*) processWithOpenCVImage1:(UIImage*)inputImage1 image2:(UIImage*)inputImage2;
{
    NSArray* imageArray = [NSArray arrayWithObjects:inputImage1,inputImage2,nil];
    int status;
    UIImage* result = [[self class] processWithArray:imageArray status:&status];
    return result;
}

+ (UIImage*) processWithArray:(NSArray*)imageArray status:(int*)status
{
    if ([imageArray count]==0){
        NSLog (@"imageArray is empty");
        return 0;
        }
    std::vector<cv::Mat> matImages;

    for (id image in imageArray) {
        NSLog(@"image orientation: %ld", (long)[image imageOrientation]);
        
        if ([image isKindOfClass: [UIImage class]]) {
            // UIImage to cv::Mat, no alpha channel
            cv::Mat matImage = [image CVMat3];
//            cv::Mat matImage = rotatedImage? [rotatedImage CVMat3] : [image CVMat3];
            NSLog (@"matImage: %@",image);
            matImages.push_back(matImage);
            
        }
    }
    NSLog (@"stitching...");
    NSLog(@"💋 matImages count: %lu", matImages.size());
    StitchReturn stitchRet = stitchImages (matImages);
    
    if (stitchRet.status == 0) { // Cannot stitch images
        *status = 0;
    }
    
    UIImage* result = [UIImage imageWithCVMat:stitchRet.mat];
    NSLog(@"💋 result size: %@", NSStringFromCGSize(result.size));
    return result;
}


@end
