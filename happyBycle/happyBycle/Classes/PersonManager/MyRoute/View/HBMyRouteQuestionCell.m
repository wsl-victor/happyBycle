//
//  HBMyRouteQuestionCell.m
//  happyBycle
//
//  Created by Stephen on 2017/5/26.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "HBMyRouteQuestionCell.h"

@implementation HBMyRouteQuestionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID=@"HBMyRouteQuestionCell";
    HBMyRouteQuestionCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"HBMyRouteQuestionCell" owner:nil options:nil][0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
