//
//  HBVHButton.m
//  happyBycle
//
//  Created by Stephen on 2017/5/23.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "HBVHButton.h"

#define SLTabBarButtonImageRatio 0.3
@implementation HBVHButton

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        // self.userInteractionEnabled=NO;
        // 图片居中
        self.imageView.contentMode =UIViewContentModeCenter;
        
        //文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        // 文字大小
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        //  文字正常颜色
        [self setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:UIControlStateNormal];
        // 文字选中颜色
        [self setTitleColor:[UIColor colorWithRed:61/255.0 green:139/255.0 blue:213/255.0 alpha:1.0] forState:UIControlStateSelected];
        
    }
    return self;
}
/**
 *  计算UIButton的图像的位置，大小
 *
 *  @param
 *
 *  @return 位置
 */
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
 
    return CGRectMake(0, 0, self.width, self.height*(1-SLTabBarButtonImageRatio));
}

//-(void)setTitle:(NSString *)title forState:(UIControlState)state
//{
//    CGSize size=[title sizeWithAttributes:@{NSFontAttributeName:MDJTitleFoneSize(12)}];
//    [self setNeedsLayout];
//}

/**
 *  计算UIButton的文字的位置
 *
 *  @param
 *
 *  @return 位置，大小
 */
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    
    return CGRectMake(0, self.height*(1-SLTabBarButtonImageRatio), self.width, self.height*SLTabBarButtonImageRatio);
}


- (void)setHighlighted:(BOOL)highlighted { }



@end
