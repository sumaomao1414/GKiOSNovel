//
//  BaseRefreshController.m
//  RefreshController
//
//  Created by wangws1990 on 2018/7/19. 
//  Copyright © 2018年 wangws1990. All rights reserved.
//

#import "BaseRefreshController.h"

static NSString *FDMSG_Home_DataRefresh                      = @"数据加载中...";
static NSString *FDMSG_Home_DataEmpty                        = @"数据空空如也...";
static NSString *FDNoNetworkMsg                              = @"无网络连接,请检查网络设置";
@interface BaseRefreshController ()<ATRefreshDataSource>
@property (nonatomic, strong) NSMutableArray *images;
@end

@implementation BaseRefreshController
- (void)dealloc {
    NSLog(@"%@", NSStringFromClass(self.class));
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = self;
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = Appxffffff;
    self.navigationController.interactivePopGestureRecognizer.delegate=(id)self;
    self.fd_interactivePopDisabled = NO;
    self.fd_prefersNavigationBarHidden = NO;
}
#pragma mark ATRefreshDataSource
- (NSArray <UIImage *>*)refreshFooterData{
    return self.images;
}
- (NSArray <UIImage *>*)refreshHeaderData{
    return self.images;
}
- (NSArray <UIImage *>*)refreshLoaderData{
    return self.images;
}
- (UIImage *)refreshEmptyData{
    return [UIImage imageNamed:@"icon_data_empty"];
}
- (UIImage *)refreshErrorData{
    return [UIImage imageNamed:@"icon_net_error"];
}
- (NSString *)refreshLoaderToast{
    return FDMSG_Home_DataRefresh;
}
- (NSString *)refreshErrorToast{
    return FDNoNetworkMsg;
}
- (NSString *)refreshEmptyToast{
    return FDMSG_Home_DataEmpty;
}
- (NSMutableArray *)images{
    if (!_images) {
        _images = @[].mutableCopy;
        for (int i = 1; i <= 4; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading%@", @(i+1)]];
            if (!image) {
                break;
            }
            [_images addObject:image];
        }
        for (int i = 4; i > 0; i--) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading%@", @(i+1)]];
            if (!image) {
                break;
            }
            [_images addObject:image];
        }
    }
    return _images;
}

@end
