//
//  HBManalLockController.m
//  happyBycle
//
//  Created by Stephen on 2017/5/23.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "HBManalLockController.h"
#import "TKeyBoardView.h"
#import <AVFoundation/AVFoundation.h>
#define kwidth  [UIScreen mainScreen].bounds.size.width
@interface HBManalLockController ()<UITextFieldDelegate,keyBoardViewDelegate>

@property (strong, nonatomic)  TKeyBoardView *boardView;
@property (strong, nonatomic)  UITextField *textField_userNmae;

@property (strong, nonatomic)  NSMutableArray *labelArr;

@property (strong, nonatomic)  NSMutableArray *valuelabelArr;

@property (nonatomic,copy) NSString *strCode;
@end

@implementation HBManalLockController

-(NSMutableArray *)labelArr
{
    if (_labelArr==nil) {
        _labelArr=[NSMutableArray array];
    }
    return _labelArr;
}
-(NSMutableArray *)valuelabelArr
{
    if (_valuelabelArr==nil) {
        _valuelabelArr=[NSMutableArray array];
    }
    return _valuelabelArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:52/255.0 green:48/255.0 blue:47/255.0 alpha:1.0];
    self.navigationItem.title=@"手动开锁";
    
    [self inputViewa];
  
    // Do any additional setup after loading the view, typically from a nib.
    self.textField_userNmae=[[UITextField alloc] init];
    [self.view addSubview:self.textField_userNmae];
    
    self.boardView = [TKeyBoardView kBoardView];
   self.boardView.keyDelegate=self;
    self.boardView.keyTextField = self.textField_userNmae;
    
     UIButton * queryBt=[[UIButton alloc] init];
    queryBt.frame = CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width  , 52);
    queryBt.titleLabel.font=[UIFont systemFontOfSize:18];
    queryBt.backgroundColor=[UIColor redColor];
    [queryBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [queryBt setTitle:@"确定" forState:UIControlStateNormal];
    [queryBt addTarget:self action:@selector(queryBtOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.textField_userNmae setInputAccessoryView:queryBt];
    [self.textField_userNmae becomeFirstResponder];
}


-(void)inputViewa
{
    UIImageView *image1=[[UIImageView alloc] initWithFrame:CGRectMake(20, 20, kwidth/3 , 80)];
    image1.contentMode = UIViewContentModeScaleAspectFit;
    [image1 setImage:[UIImage imageNamed:@"bike"]];
    [self.view addSubview:image1];
    UIImageView *image2=[[UIImageView alloc] initWithFrame:CGRectMake(20+kwidth/3+10,20 , 20, 80)];
      image2.contentMode = UIViewContentModeScaleAspectFit;
    [image2 setImage:[UIImage imageNamed:@"top_arrow"]];
    [self.view addSubview:image2];
    UIImageView *image3=[[UIImageView alloc] initWithFrame:CGRectMake(20+kwidth/3+20+5, 20, kwidth/3, 80)];
      image3.contentMode = UIViewContentModeScaleAspectFit;
    [image3 setImage:[UIImage imageNamed:@"bigbike"]];
    [self.view addSubview:image3];
    
    UIButton * flashBtn=[[UIButton alloc] init];
    flashBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-60,0, 60  , self.view.height * 0.1);
    [flashBtn setImage:[UIImage imageNamed:@"lamplight_open"] forState:UIControlStateNormal];
    flashBtn.contentMode=UIViewContentModeScaleAspectFit;
    [flashBtn addTarget:self action:@selector(openFlash:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:flashBtn];
    
    int intputNum=10;
    int margin=5;//边缘处两个margin
   CGFloat intPutWidth=([UIScreen mainScreen].bounds.size.width-(intputNum+3)*margin)/10;
    CGFloat width=intPutWidth;
    CGFloat height=intPutWidth*2;
    for (int i=0; i<intputNum; i++) {
        CGFloat x=margin*2+intPutWidth*i+margin*i;
        CGFloat y=120;
      
        UILabel *label=[[UILabel alloc] init];
        label.frame=CGRectMake(x, y, width, height);
        label.backgroundColor=[UIColor colorWithRed:92/255.0 green:92/255.0 blue:92/255.0 alpha:1.0];
        label.textColor=[UIColor whiteColor];
        label.textAlignment=NSTextAlignmentCenter;
        label.font=[UIFont systemFontOfSize:18 weight:2];
        label.tag=2000+i;
        [self.view addSubview:label];
        [self.labelArr addObject:label];
    }
    
//    
    UILabel *desLable=[[UILabel alloc] initWithFrame:CGRectMake(0, 120+height+10, [UIScreen mainScreen].bounds.size.width, 25)];
    [desLable setTextColor:[UIColor grayColor]];
    [desLable setFont:[UIFont systemFontOfSize:12]];
    desLable.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:desLable];
    [desLable setText:@"请确认您输入了正确的自行车编码"];
    
    
    
}
#pragma mark-> 确定
-(void)queryBtOnClick:(UIButton*)button{
    
   
    
}

#pragma mark-> 闪光灯
-(void)openFlash:(UIButton*)button{
    
    button.selected = !button.selected;
    if (button.selected) {
        [self turnTorchOn:YES];
    }
    else{
        [self turnTorchOn:NO];
    }
    
}
#pragma mark-> 开关闪光灯
- (void)turnTorchOn:(BOOL)on
{
    
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        if ([device hasTorch] && [device hasFlash]){
            
            [device lockForConfiguration:nil];
            if (on) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
                
            } else {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
            }
            [device unlockForConfiguration];
        }
    }
}


-(void)selectNumber:(NSString *)str
{

    if (str.length>10) {
        str=[str substringToIndex:10];
        return;
    }
    if (str.length==0) {
        UILabel *label=self.valuelabelArr.lastObject;
        label.text=@"";
        self.strCode=@"";
    }else {
     
        if (self.strCode.length<str.length) {
            [self.valuelabelArr removeAllObjects];
            for (int i=0; i<str.length; i++) {
                UILabel *label=self.labelArr[i];
                label.text=[str substringWithRange:NSMakeRange(i, 1)];
                [self.valuelabelArr addObject:label];
            }
            self.strCode=str;
        }else{
            UILabel *label=self.valuelabelArr.lastObject;
            label.text=@"";
            [self.valuelabelArr removeObject:label];
            self.strCode=str;
        }
        
       
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
