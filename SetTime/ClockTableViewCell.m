//
//  ClockTableViewCell.m
//  CBayelProjectManage
//
//  Created by gcf on 16/6/23.
//  Copyright © 2016年 CBayel. All rights reserved.
//

#import "ClockTableViewCell.h"

@implementation ClockTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self drawView];
    }
    return self;
}

-(void)drawView{
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 80, 60)];
    self.titleLabel.text = NSLocalizedString(@"repetition", nil);
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.titleLabel];
    
    self.detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, SCREEN_WIDTH - 128, 60)];
    self.detailLabel.text = NSLocalizedString(@"only_once", nil);
    self.detailLabel.font = [UIFont systemFontOfSize:14];
    self.detailLabel.textColor = [UIColor whiteColor];
    self.detailLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.detailLabel];
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
