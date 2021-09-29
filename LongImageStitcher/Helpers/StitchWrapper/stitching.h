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

struct StitchReturn {
    cv::Mat pano;
    int statusCode;
};

StitchReturn stitchImages (std::vector <cv::Mat> & images);


#endif
