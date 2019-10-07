//
//  SetTimeVC.h
//  FarbenSmartHome
//
//  Created by 唐林 on 2018/10/23.
//  Copyright © 2018年 唐林. All rights reserved.
//

#import "BaseViewController.h"

@interface SetTimeVC : BaseViewController

@property (nonatomic,copy) void (^clickDicBack)(NSDictionary *biSceneScheduleTEntity);


- (void)clickDicBack:(void(^)(NSDictionary *biSceneScheduleTEntity))block;

@end
