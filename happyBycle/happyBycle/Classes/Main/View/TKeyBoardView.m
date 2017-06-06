//
//  keyBoardView.m
//  ce
//
//  Created by GXY on 15/7/16.
//  Copyright (c) 2015年 GongXinYing. All rights reserved.
//

#import "TKeyBoardView.h"

@implementation TKeyBoardView

+ (instancetype)kBoardView {
    TKeyBoardView *boardView = [[[UINib nibWithNibName:@"TKeyBoardView" bundle:nil]instantiateWithOwner:self options:nil] objectAtIndex:0];
    return boardView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _constraint_height.constant = 0.5f;
}

- (IBAction)selectNumber:(UIButton *)sender {

    NSString *str = nil;
    if (sender.tag - 300 == 10) {
        if ([_keyTextField.text rangeOfString:@"."].length != 0) {
            str = @"";
            return;
        }
        else {
            str = @".";
        }
    } else if (sender.tag - 300 == 11)
    {
        str = @"";
        [self deleteOneStringToTextField];
    }
    else {
        // 判断两位小数
        NSString *content = _keyTextField.text;
        NSArray *arrays = [content componentsSeparatedByString:@"."];
        NSInteger aConut = arrays.count;
        if (aConut != 0 && aConut == 2) {
            NSString *secondStr = [arrays objectAtIndex:1];
            if (secondStr.length >= 2) {
                return;
            }
        }
        str = [NSString stringWithFormat:@"%ld",sender.tag - 300];
    }
    if (_keyTextField.text.length>10) {
        return;
    }
    [self appendContentToTextField:str];
}

/**
 *  删除光标前面的字符
 */
- (void)deleteOneStringToTextField {
    NSMutableString *source = [_keyTextField.text mutableCopy];
    if ([source length] != 0) {
        // 1.获取光标所在位置
        UITextRange *selectedRange = [_keyTextField selectedTextRange];
        NSInteger offset = [_keyTextField offsetFromPosition:_keyTextField.beginningOfDocument toPosition:selectedRange.end];
        // 2.光标是否置于编辑框开始
        if (offset != 0) {
            NSRange backward = NSMakeRange(offset - 1, 1);
            [source deleteCharactersInRange:backward];
            _keyTextField.text = source;
            // 3.删除字符后，移动光标到新的位置
            UITextPosition *newPos = [_keyTextField positionFromPosition:_keyTextField.beginningOfDocument offset:offset - 2];
            _keyTextField.selectedTextRange = [_keyTextField textRangeFromPosition:newPos toPosition:newPos];
        }
    }
}

/**
 *  添加字符到编辑框末尾
 *
 *  @param appendString 添加的字符内容
 */
- (void)appendContentToTextField:(NSString *)appendString {
    
    // 1.获取光标所在位置
    UITextRange *selectedRange = [_keyTextField selectedTextRange];
    NSInteger offset = [_keyTextField offsetFromPosition:_keyTextField.beginningOfDocument toPosition:selectedRange.end];
    
    // 2.在光标当前位置后一个插入数字
    NSMutableString *contentString =  [[NSMutableString alloc] initWithString:_keyTextField.text];
    [contentString insertString:appendString atIndex:offset];
    
    // 3.添加字符后，移动光标到新的位置
    _keyTextField.text = contentString;
    UITextPosition *newPos = [_keyTextField positionFromPosition:_keyTextField.beginningOfDocument offset:offset + 1];
    _keyTextField.selectedTextRange = [_keyTextField textRangeFromPosition:newPos toPosition:newPos];

    if (_keyDelegate != nil) {
        // 交给代理处理
        [_keyDelegate selectNumber:_keyTextField.text];
    }
}

- (void)setKeyTextField:(UITextField *)keyTextField {
    _keyTextField = keyTextField;
    keyTextField.delegate = self;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.inputView = self;
}

@end
