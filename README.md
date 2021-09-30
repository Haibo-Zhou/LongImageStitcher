### A image stitcher app written in Swift. 

The ability of this app is to stitch images/screenshots vertically into a new long image. For instance, when a user browses the posts in his/her twitter, they might want to take a few screenshots along scrolling the content. By import those screenshots into this app, the user could get a new generated long image, which combine all screenshots, and remove the overlapped parts between the screenshots.

### Update -> Sep 30, 2021
1. Now the generated stitched image from openCV has correct ratio.
2. Add a UIScrollView for fullscreen long image presentation.
3. Add a save button allows user to export the long image into device photos library.
4. No stitching images limitation now, however I do set 8 images limit for imagePicker.

### What used?
- This app utilize the `openCV` framework for image stitching function, and I used a class wrapper [OpenCVSwiftStitch](https://github.com/foundry/OpenCVSwiftStitch) to deal with image stitching.
- By default, this wrapper could handle Panoramic pictures stitching, however I need stitching images vertically. Thus, I rotate each image to left by 90 degree counterclockwise before processing.

The screenshots below illustrated the workflow of this app.

### 🍊 Original screenshots
<img src = "https://www.haibosfashion.com/images/longImageStitcher/001.png" width ="180" />  <img src = "https://www.haibosfashion.com/images/longImageStitcher/002.png" width ="180" />  <img src = "https://www.haibosfashion.com/images/longImageStitcher/003.png" width ="180" />  <img src = "https://www.haibosfashion.com/images/longImageStitcher/004.png" width ="180" /> 

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



### Yeah, it has bugs:
1. Stitching screenshots from Youtube, Twitter, AppStore apps works fine. But Stitching screenshots from WeChat doesn't working.
2. TBD...
