//
//  YLCacheTool.h
//  TemplateProject
//
//  Created by Lin Yan on 2018/5/8.
//  Copyright © 2018年 Lin Yan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYCache.h"
//缓存路径
static NSString * const cachePath = @"/download/yyCache";

@interface YLCacheTool : NSObject

@property(nonatomic, strong) YYDiskCache * yyCache;

+ (instancetype)shareInstance;

@end
