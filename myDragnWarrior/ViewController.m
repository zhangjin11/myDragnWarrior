//
//  ViewController.m
//  myDragnWarrior
//
//  Created by jin on 2020/6/29.
//  Copyright © 2020 jin. All rights reserved.
//

#import "ViewController.h"
#import "myputGameController0.h"
/** 十六进制颜色 */
#define KRGB16HEX(rgbValue)     [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/** 整个屏幕宽 */
#define KScreenWidth             ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)

/** 整个屏幕高 */
#define KScreenHeight            ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

/** UserDefaults */
#define KUserDefaults           [NSUserDefaults standardUserDefaults]

/** NotificationCenter */
#define KNotificationCenter     [NSNotificationCenter defaultCenter]



@interface ViewController ()

@end

@implementation ViewController
- (IBAction)frfr:(id)sender {
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
      myputGameController0 * controller = [storyboard instantiateViewControllerWithIdentifier:@"myputGameController0"];

      [self.navigationController pushViewController:controller animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


@end
