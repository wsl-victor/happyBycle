//
//  UIBarButtonItem+MDJExtension.h
//  UserMdj
//
//  Created by victor on 15/3/20.
//  Copyright (c) 2015年 victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (MDJExtension)

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action;

@end
