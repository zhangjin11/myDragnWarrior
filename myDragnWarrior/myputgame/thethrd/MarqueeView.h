//
//  MarqueeView.h
//  practiceDemo
//
//  Created by wanhouhong on 2017/9/11.
//  Copyright © 2017年 wanhouhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarqueeView : UIView

@property(nonatomic,strong) NSTimer* timer;// 定义定时器
@property (nonatomic,  copy) NSString *marqueeText;

@end
