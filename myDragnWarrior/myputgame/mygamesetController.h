//
//  mygamesetController.h
//  FanBi
//
//  Created by jin on 2020/5/29.
//  Copyright © 2020 zhangjin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^mymusicVoiceBlock)(NSString *mystr);

@interface mygamesetController : UIViewController

@property(nonatomic,strong)mymusicVoiceBlock mymusicVoiceBlock0;
@end

NS_ASSUME_NONNULL_END
