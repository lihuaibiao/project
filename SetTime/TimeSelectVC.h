//
//  TimeSelectVC.h
//  FarbenSmartHome
//
//  Created by 唐林 on 2018/10/24.
//  Copyright © 2018年 唐林. All rights reserved.
//

#import "BaseViewController.h"

typedef  void (^myBlockType)(NSString *deliverStr);

@interface TimeSelectVC : BaseViewController

//回调block
@property (nonatomic,strong)myBlockType block;

//如果是模型，你就可以带回一个模型
@property (nonatomic,copy) void (^clickDateBack)(NSArray *dataArr);


- (void)clickDateBack:(void(^)(NSArray *dataArr))block;

@end
