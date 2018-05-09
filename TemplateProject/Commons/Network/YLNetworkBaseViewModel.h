//
//  YLNetworkBaseViewModel.h
//  YLExtensionExample
//
//  Created by Lin Yan on 2017/9/30.
//  Copyright © 2017年 Lin Yan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, YLLoadEvent) {
    LOADING         = 1,//正在加载
    LOAD_FAIL       = 2,//业务原因加载失败
    LOAD_SUCCESS    = 3,//加载成功
    LOAD_UNLOGIN    = 4,//未登陆
    INVALID_SESSION = 5,//session失效
    LOAD_NET_FAIL   = 6,//网络原因加载失败
    READY_TOLOAD    = 7,//准备好下载，进入下载队列
    AUTOPAUSE_LOAD  = 8,//由于网络等原因自动暂停
    MANUALLY_PAUSE_LOAD = 9,//手动暂停下载
    CANCEL_LOAD     = 10,//取消下载
    RESUME_LOAD     = 11 //恢复下载
};

@interface YLNetworkBaseViewModel : NSObject

@property (nonatomic ,assign) YLLoadEvent loadEvent;
@property (nonatomic ,strong) NSString * loadInfo;

@end

@interface YLBaseNetworkRequestModel : NSObject

@end


@interface YLBaseNetworkResponseModel : NSObject

@end


