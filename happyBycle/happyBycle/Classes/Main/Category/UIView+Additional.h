//
//  UIView+Additional.h
//  happyBycle
//
//  Created by Stephen on 2017/5/23.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ZJViewBorder) {
    ZJViewBorderTop = 1<<1,
    ZJViewBorderLeft = 1<<2,
    ZJViewBorderBottom = 1<<3,
    ZJViewBorderRight = 1<<4,
};
@interface UIView (Additional)
@property (nonatomic, assign) ZJViewBorder borderWhich;  
@end
