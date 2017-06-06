//
//  HBMessageViewCell.m
//  happyBycle
//
//  Created by Stephen on 2017/5/25.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "HBMessageViewCell.h"
@interface HBMessageViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageTitleView;

@property (weak, nonatomic) IBOutlet UILabel *titleView;

@property (weak, nonatomic) IBOutlet UIView *corView;

@end

@implementation HBMessageViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //设置所需的圆角位置以及大小
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-12, self.corView.bounds.size.height) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-12, self.corView.bounds.size.height);
    maskLayer.path = maskPath.CGPath;
    self.corView.layer.mask = maskLayer;
}


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID=@"HBMessageViewCell";
    HBMessageViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"HBMessageViewCell" owner:nil options:nil][0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
