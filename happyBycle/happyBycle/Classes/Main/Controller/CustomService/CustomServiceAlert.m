//
//  CustomServiceAlert.m
//  happyBycle
//
//  Created by Stephen on 2017/5/23.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "CustomServiceAlert.h"
@interface CustomServiceAlert ()


@property (weak, nonatomic) IBOutlet UIView *alertView;

@property (copy, nonatomic)void(^oneBlock)();
@property (copy, nonatomic)void(^twoBlock)();
@property (copy, nonatomic)void(^threeBlock)();
@property (copy, nonatomic)void(^fourBlock)();

@end

@implementation CustomServiceAlert

static CustomServiceAlert *alertV;
+(instancetype)dreamAlertView{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        alertV = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
        alertV.frame = [UIScreen mainScreen].bounds;
       alertV.alertView.transform = CGAffineTransformMakeTranslation(0, [UIScreen mainScreen].bounds.size.height);
        alertV.alertView.layer.cornerRadius = 8;
        alertV.alertView.layer.masksToBounds=YES;
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        effectView.alpha = 0.3f;
        effectView.frame = alertV.bounds;
        [alertV insertSubview:effectView belowSubview:alertV.alertView];
    });
    
    return alertV;
}

+(instancetype)dreamAlertViweWithTitle:(NSString *)title oneBtnTitle:(NSString *)oneTitle oneBlock:(void (^)())oneBlock twoBtnTitle:(NSString *)twoTitle twoBlock:(void (^)())twoBlock threeBtnTitle:(NSString *)threeTitle threeBlock:(void (^)())threeBlock fourBtnTitle:(NSString *)fourTitle fourBlock:(void (^)())fourBlock
{
    CustomServiceAlert *alert = [CustomServiceAlert dreamAlertView];
    alert.oneBlock = oneBlock;
    alert.twoBlock = twoBlock;
    alert.threeBlock = threeBlock;
    alert.fourBlock = fourBlock;
    return alert;

}


-(void)show{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alertView.transform = CGAffineTransformIdentity;
    }];
}

-(void)disMiss{
    [UIView animateWithDuration:0.5 animations:^{
        self.alertView.transform = CGAffineTransformMakeTranslation(0, [UIScreen mainScreen].bounds.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self disMiss];
    
}

- (IBAction)oneOnClick:(UIButton *)sender {
     [self disMiss];
    if (self.oneBlock) {
        self.oneBlock();
    }
   

}

- (IBAction)twoOnClick:(UIButton *)sender {
     [self disMiss];
    if (self.twoBlock) {
        self.twoBlock();
    }
   
}

- (IBAction)threeOnClick:(UIButton *)sender {
     [self disMiss];
    if (self.threeBlock) {
        self.threeBlock();
    }
   
}

- (IBAction)fourOnClick:(UIButton *)sender {
     [self disMiss];
    if (self.fourBlock) {
        self.fourBlock();
    }
   
}

@end
