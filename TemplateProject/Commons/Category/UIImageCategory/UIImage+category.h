//
//  UIImage+category.h
//  TemplateProject
//
//  Created by Lin Yan on 2018/5/8.
//  Copyright © 2018年 Lin Yan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (category)

 /**
  对图片进行滤镜处理

  @param name 滤镜名称（
  怀旧 --> CIPhotoEffectInstant                         单色 --> CIPhotoEffectMono
  黑白 --> CIPhotoEffectNoir                            褪色 --> CIPhotoEffectFade
  色调 --> CIPhotoEffectTonal                           冲印 --> CIPhotoEffectProcess
  岁月 --> CIPhotoEffectTransfer                        铬黄 --> CIPhotoEffectChrome
  CILinearToSRGBToneCurve, CISRGBToneCurveToLinear, CIGaussianBlur, CIBoxBlur, CIDiscBlur, CISepiaTone, CIDepthOfField
  ）
  @return 处理后的图片
  */
- (UIImage *)yl_filterWithfilterName:(NSString *)name;
/**
 对图片进行模糊处理

 @param name 模糊名称（
 CIGaussianBlur ---> 高斯模糊
 CIBoxBlur      ---> 均值模糊(Available in iOS 9.0 and later)
 CIDiscBlur     ---> 环形卷积模糊(Available in iOS 9.0 and later)
 CIMedianFilter ---> 中值模糊, 用于消除图像噪点, 无需设置radius(Available in iOS 9.0 and later)
 CIMotionBlur   ---> 运动模糊, 用于模拟相机移动拍摄时的扫尾效果(Available in iOS 9.0 and later)
 ）
 @param radius 弧度
 @return 处理后的图片
 */
- (UIImage *)yl_blurWithblurName:(NSString *)name radius:(NSInteger)radius;

/**
 调整图片饱和度, 亮度, 对比度

 @param saturation 饱和度
 @param brightness 亮度 -1.0 ~ 1.0
 @param contrast 对比度
 @return 处理后的图片
 */
- (UIImage *)yl_colorControlsWithsaturation:(CGFloat)saturation
                                 brightness:(CGFloat)brightness
                                   contrast:(CGFloat)contrast;

/**
 压缩图片到指定尺寸大小

 @param size 尺寸大小
 @return 处理后的图片
 */
- (UIImage *)yl_compressToSize:(CGSize)size;

/**
 压缩图片到指定文件大小

 @param size 文件大小
 @return 处理后的图片
 */
- (NSData *)yl_compressToMaxDataSizeKBytes:(CGFloat)size;
@end
