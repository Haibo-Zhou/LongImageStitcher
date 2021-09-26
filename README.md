### A image stitcher app written in Swift. 

The ability of this app is to stitch images/screenshots vertically into a new long image. For instance, when a user browses the posts in his/her twitter, they might want to take a few screenshots along scrolling the content. By import those screenshots into this app, the user could get a new generated long image, which combine all screenshots, and remove the overlapped parts between the screenshots.

### what used?
- This app utilize the `openCV` framework, and I used a class wrapper [OpenCVSwiftStitch](https://github.com/foundry/OpenCVSwiftStitch) to deal with image stitching.
- By default, this wrapper could handle Panoramic pictures stitching, however I need stitching images vertically. Thus, I modify the code of `- (UIImage *)rotateToImageOrientation` in `UIImage+Rotate.m` to make it worked for vertical images stitched. In short, I convert image orientation from up, down, right to **left**.

The screenshots below illustrated the workflow of this app.

### 🍊 original screenshots
<img src = "https://www.haibosfashion.com/images/longImageStitcher/001.png" width ="200" />  <img src = "https://www.haibosfashion.com/images/longImageStitcher/002.png" width ="200" />  <img src = "https://www.haibosfashion.com/images/longImageStitcher/003.png" width ="200" /> 

&nbsp;


### 🍊 Generated stitched image
<img src = "https://www.haibosfashion.com/images/longImageStitcher/app_001.png" width ="200" /> <img src = "https://www.haibosfashion.com/images/longImageStitcher/app_002.png" width ="200" /> <img src = "https://www.haibosfashion.com/images/longImageStitcher/app_003.png" width ="200" /> 


### Install
1. Install `openCV` framework, `pod 'OpenCV', '~> 3.1.0.1'`. If you are using Mac M1, you might need to add this in your Podfile.
```
# for Mac M1
post_install do |installer|
installer.pods_project.build_configurations.each do |config|
config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
end

installer.pods_project.targets.each do |target|
target.build_configurations.each do |config|
config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
end
end
end
```
2. Close your project and reopen .xcworkspace.

That is all, you are ready to go!

### Yeah, it has many bugs:
1. I found some screenshots in Youtube app works, some of them not.
2. The generated stitched image from openCV is Squashed with wrong ratio.
3. Now, it only could stitched like 3, 4 images at most. I'd like to look into this problem later to make it support more images as a scrollView.
4. I got interest at the algorithm of how openCV stitch the images, but I didn't find the code yet, maybe it is hided deeper, will dig more.
