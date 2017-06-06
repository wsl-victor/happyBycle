//
//  keyBoardView.h
//  ce
//
//  Created by GXY on 15/7/16.
//  Copyright (c) 2015年 GongXinYing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol keyBoardViewDelegate <NSObject>

@optional
- (void)selectNumber:(NSString *)str;

@end

@interface TKeyBoardView : UIView <UITextFieldDelegate>

// 如果外部无需处理选中数字事件，代理则无需实现！
@property (weak, nonatomic) id<keyBoardViewDelegate> keyDelegate;

// 关联的编辑框
@property (strong,nonatomic) UITextField *keyTextField;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_height;

- (IBAction)selectNumber:(id)sender;

+ (instancetype)kBoardView;

@end
