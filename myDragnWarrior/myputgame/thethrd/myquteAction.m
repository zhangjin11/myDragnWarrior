//
//  myquteAction.m
//  FanBi
//
//  Created by jin on 2020/6/10.
//  Copyright © 2020 zhangjin. All rights reserved.
//

#import "myquteAction.h"

@implementation myquteAction

//得到我的龙的具体等级
+ (UIImage *)getmyImageDragnbylevel:(NSInteger)mylevel
{
    UIImage  *myimage = [UIImage new];
    if (mylevel == 1)
    {
        myimage = [UIImage imageNamed:@"pic_index_long_1"];
    }
    else if(mylevel == 2)
    {
        myimage = [UIImage imageNamed:@"pic_index_long_2"];
    }
    else if (mylevel == 3)
    {
        myimage = [UIImage imageNamed:@"pic_index_long_3"];
    }
    else if (mylevel == 4)
    {
        myimage = [UIImage imageNamed:@"pic_index_long_4"];
    }
    else if(mylevel == 5)
    {
        myimage = [UIImage imageNamed:@"pic_index_long_5"];
    }
    else
    {
        myimage = [UIImage imageNamed:@"pic_index_long_dan1"];
    }
    return myimage;
}

@end
