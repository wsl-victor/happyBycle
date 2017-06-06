//
//  CustomServiceAlert.h
//  happyBycle
//
//  Created by Stephen on 2017/5/23.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomServiceAlert : UIView

+(instancetype)dreamAlertViweWithTitle:(NSString *)title oneBtnTitle:(NSString *)oneTitle oneBlock:(void(^)())oneBlock twoBtnTitle:(NSString *)twoTitle twoBlock:(void(^)())twoBlock  threeBtnTitle:(NSString *)threeTitle threeBlock:(void(^)())threeBlock  fourBtnTitle:(NSString *)fourTitle fourBlock:(void(^)())fourBlock;


-(void)show;
-(void)disMiss;

@end
