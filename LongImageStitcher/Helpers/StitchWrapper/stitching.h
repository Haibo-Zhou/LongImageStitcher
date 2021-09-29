//
//  stitching.h
//  CVOpenTemplate
//
//  Created by Foundry on 05/01/2013.
//  Copyright (c) 2013 Foundry. All rights reserved.
//

#ifndef CVOpenTemplate_Header_h
#define CVOpenTemplate_Header_h
#include <opencv2/opencv.hpp>
#include <opencv2/stitching.hpp>

// create this struct as I want to handle when "Can't stitch images..." happens
struct StitchReturn {
    cv::Mat pano;
    int statusCode;
};

StitchReturn stitchImages (std::vector <cv::Mat> & images);


#endif
