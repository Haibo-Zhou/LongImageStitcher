//
//  CVWrapper.m
//  CVOpenTemplate
//
//  Created by Washe on 02/01/2013.
//  Copyright (c) 2013 foundry. All rights reserved.
//

#import "stitching.h"
#import "CVWrapper.h"
#import "UIImage+OpenCV.h"
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

+ (UIImage*) processWithArray:(NSArray*)imageArray status:(int*)status;
{
    if ([imageArray count]==0){
        NSLog (@"imageArray is empty");
        return 0;
        }
    std::vector<cv::Mat> matImages;

    for (id image in imageArray) {
        NSLog(@"image orientation: %ld", (long)[image imageOrientation]);
        
        if ([image isKindOfClass: [UIImage class]]) {
            
//            UIImage* rotatedImage = [image rotateToImageOrientation];
            // UIImage to cv::Mat, no alpha channel
            cv::Mat matImage = [image CVMat3];
            NSLog (@"matImage: %@",image);
            matImages.push_back(matImage);
        }
    }
    NSLog (@"stitching...");
    NSLog(@"💋 matImages count: %lu", matImages.size());
    StitchReturn stitchRet = stitchImages (matImages);
    int statusCode = stitchRet.statusCode;
    if (statusCode == -1) {
        *status = -1;
    }
    UIImage* newImage =  [UIImage imageWithCVMat:stitchRet.pano];
    
    return newImage;
}


@end
