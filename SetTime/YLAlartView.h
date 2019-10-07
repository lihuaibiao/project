//
//  YLAlartView.h
//  YLAlarmClock
//
//  Created by Bing on 16/6/30.
//  Copyright © 2016年 Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  YLAlartViewDelegate<NSObject>

- (void)sendDateWithData:(NSString *)data;

@end

@interface YLAlartView : UIView<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong)UIPickerView *pickerView;
@property (nonatomic, strong)NSMutableArray *data1;
@property (nonatomic, strong)NSMutableArray *data2;


@property (nonatomic, copy)NSString *titleDate;

@property (nonatomic, strong)id <YLAlartViewDelegate>delegate;

@end
