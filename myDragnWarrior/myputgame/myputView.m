//
//  myputView.m
//  FanBi
//
//  Created by jin on 2020/4/17.
//  Copyright © 2020 zhangjin. All rights reserved.
//

#import "myputView.h"

@implementation myputView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
//
     CGFloat mygap = 10;
       CGFloat mywid = ((KScreenWidth1 -80) - mygap *4)/3;
//     CGFloat  myheight = mywid *60/84;
//    self.size = CGSizeMake(mywid-10, mywid-10);
    
    if (KScreenWidth1 <= 375)
    {
         self.mybtnWidthCon.constant = 75;
    }
    else
    {
        self.mybtnWidthCon.constant = mywid-20;
    }
   
}


@end
