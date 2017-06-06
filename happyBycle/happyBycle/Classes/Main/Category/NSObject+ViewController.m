//
//  NSObject+ViewController.m
//  happyBycle
//
//  Created by Stephen on 2017/5/23.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "NSObject+ViewController.h"

@implementation NSObject (ViewController)

+ (UIViewController*)viewControllerWithviewObj:(UIView *)viewObj {
    for (UIView* next = [viewObj superview]; next; next =
         next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController
                                          class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
