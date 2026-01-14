#import <UIKit/UIKit.h>

%hook NSBundle
- (NSString *)bundleIdentifier {
    // 强制返回原版包名，防止 App 发现自己是分身而禁用功能
    return @"com.aliyun.wstudio.amc.AliyunMobileApp";
}
%end

%ctor {
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 填入你图片中那段长链接 
            NSString *urlStr = @"aliyun://forward/sign?target_=/h5&url_=https://developer.aliyun.com/app-mobile/score?";
            NSURL *url = [NSURL URLWithString:urlStr];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            }
        });
    }];
}
