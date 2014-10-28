//
//  UIButton+SelectDateButton.m
//  restaurant_ios
//
//  Created by 村上智紀 on 2014/10/27.
//  Copyright (c) 2014年 pad. All rights reserved.
//

#import "UIButton+SelectDateButton.h"

@implementation SelectDateButton
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        
        self.titleLabel.text = @"aaaaaaaaaaaa";
    }
    return self;
}

@end
