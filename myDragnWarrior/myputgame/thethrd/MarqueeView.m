//
//  MarqueeView.m
//  practiceDemo
//
//  Created by wanhouhong on 2017/9/11.
//  Copyright © 2017年 wanhouhong. All rights reserved.
//

#import "MarqueeView.h"
#import "UIView+SDAutoLayout.h"

@interface MarqueeView()

@property (nonatomic, strong) UILabel *marqueeLabel;


@end

@implementation MarqueeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self.layer setCornerRadius:5.f];
        self.clipsToBounds = YES;
      
        [self setUpView];
    }
    return self;
}

- (void)setUpView {
    [self addSubview:self.marqueeLabel];
    self.marqueeLabel.sd_layout.leftSpaceToView(self, self.frame.size.width).centerYEqualToView(self).heightIs(20);
    
    // 启动NSTimer定时器来改变label的位置
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                  target:self selector:@selector(changePosition)
                                                userInfo:nil repeats:YES];
}

- (void)setMarqueeText:(NSString *)marqueeText {
    self.marqueeLabel.text = marqueeText;
}

- (void) changePosition
{
    CGPoint curPosition = self.marqueeLabel.center;
    // 当curPos的x坐标已经超过了屏幕的宽度
    if(curPosition.x <  - self.marqueeLabel.width/2 )
    {
        //CGFloat jianJu = self.marqueeLabel.frame.size.width/2;
        // 控制label再次从屏幕左侧开始移动
        self.marqueeLabel.center = CGPointMake(self.frame.size.width + self.marqueeLabel.width/2, 20);
        
    }
    else
    {
        // 通过修改iv的center属性来改变iv控件的位置
        self.marqueeLabel.center = CGPointMake(curPosition.x - 0.5, 20);
    }
    //其实label的整个移动都是靠label.center来去设置的
}

- (UILabel *)marqueeLabel {
    if (!_marqueeLabel) {
        _marqueeLabel = [[UILabel alloc] init];
        _marqueeLabel.font = [UIFont systemFontOfSize:15];
        _marqueeLabel.textColor = [UIColor whiteColor];
        [_marqueeLabel setSingleLineAutoResizeWithMaxWidth:MAXFLOAT];
    }
    return _marqueeLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
