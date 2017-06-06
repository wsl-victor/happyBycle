//
//  HBPersonHeaderView.m
//  happyBycle
//
//  Created by Stephen on 2017/5/22.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "HBPersonHeaderView.h"
#import "UIView+Additional.h"
#import "NSObject+ViewController.h"
//个人中心
#import "HBPersonCenterController.h"
//用户信用
#import "HBMyCreditController.h"
@interface HBPersonHeaderView ()
@property (weak, nonatomic) IBOutlet UIView *leftView;

@property (weak, nonatomic) IBOutlet UIView *centerView;

@property (weak, nonatomic) IBOutlet UIView *rightVIew;

@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *centerLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;



//
@property (weak, nonatomic) IBOutlet UIButton *creditLabel;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;

@property (weak, nonatomic) IBOutlet UIButton *avatarLabel;


@end

@implementation HBPersonHeaderView

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.leftView.borderWhich=ZJViewBorderRight;
    self.rightVIew.borderWhich=ZJViewBorderLeft;
    
    self.leftLabel.textColor=[UIColor redColor];
     self.centerLabel.textColor=[UIColor redColor];
     self.rightLabel.textColor=[UIColor redColor];
    
    self.avatarImage.layer.cornerRadius=35;
    self.avatarImage.layer.masksToBounds=YES;

}


- (IBAction)creditBtOnClick:(UIButton *)sender {
    HBMyCreditController *personVc=[[HBMyCreditController alloc] init];
    [[NSObject viewControllerWithviewObj:self].navigationController pushViewController:personVc animated:YES];
    
}

- (IBAction)avatarBtOnClick:(UIButton *)sender {
    HBPersonCenterController *creditVc=[[HBPersonCenterController alloc] init];
    [[NSObject viewControllerWithviewObj:self].navigationController pushViewController:creditVc animated:YES];
}

@end
