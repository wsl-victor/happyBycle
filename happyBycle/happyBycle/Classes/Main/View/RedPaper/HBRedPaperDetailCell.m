//
//  HBRedPaperDetailCell.m
//  happyBycle
//
//  Created by Stephen on 2017/5/25.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "HBRedPaperDetailCell.h"

@implementation HBRedPaperDetailCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID=@"HBRedPaperDetailCell";
    HBRedPaperDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"HBRedPaperDetailCell" owner:nil options:nil][0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
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
