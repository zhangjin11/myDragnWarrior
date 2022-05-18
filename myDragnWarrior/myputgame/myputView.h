//
//  myputView.h
//  FanBi
//
//  Created by jin on 2020/4/17.
//  Copyright © 2020 zhangjin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


/** 整个屏幕宽 */
#define KScreenWidth1             ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)

/** 整个屏幕高 */
#define KScreenHeight1            ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)



@interface myputView : UIView

@property (weak, nonatomic) IBOutlet UILabel *myputlabel;
@property (weak, nonatomic) IBOutlet UIButton *myputbutton;
@property(nonatomic,assign)NSInteger myDragnLevel;
@property(nonatomic,assign)NSInteger mytagg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mybtnWidthCon;



@end

NS_ASSUME_NONNULL_END
