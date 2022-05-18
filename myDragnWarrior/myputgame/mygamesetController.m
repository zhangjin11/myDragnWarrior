//
//  mygamesetController.m
//  FanBi
//
//  Created by jin on 2020/5/29.
//  Copyright © 2020 zhangjin. All rights reserved.
//

#import "mygamesetController.h"

@interface mygamesetController ()
@property (weak, nonatomic) IBOutlet UIImageView *myiamhge;

@property (weak, nonatomic) IBOutlet UIButton *mybtn1;
@property (weak, nonatomic) IBOutlet UIButton *mybtn2;
@property(nonatomic,strong)NSString *myvoice0;
@property(nonatomic,strong)NSString *myvoice1;
@end

@implementation mygamesetController

- (IBAction)mydeklclicked:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.myiamhge.contentMode =  UIViewContentModeScaleToFill;
    
    
    self.myvoice0 = [[NSUserDefaults standardUserDefaults] valueForKey:@"voice0"];
      if([self.myvoice0 isEqualToString:@"voice0_0"])
      {
          //关
           [self.mybtn1 setImage:[UIImage imageNamed:@"pic_shez_yin2_g"] forState:0];
      }
      else
      {
          //开
          [self.mybtn1 setImage:[UIImage imageNamed:@"pic_shez_yin2_k"] forState:0];
      }
    
    
    self.myvoice1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"voice1"];
        if([self.myvoice1 isEqualToString:@"voice1_1"])
        {
            //关
             [self.mybtn2 setImage:[UIImage imageNamed:@"pic_shez_yin_g"] forState:0];
        }
        else
        {
            //开
            [self.mybtn2 setImage:[UIImage imageNamed:@"pic_shez_yin_k"] forState:0];
        }
    
}


- (IBAction)myyouximusic:(id)sender {
    //游戏音乐
  
    self.myvoice0 = [[NSUserDefaults standardUserDefaults] valueForKey:@"voice0"];
        if([self.myvoice0 isEqualToString:@"voice0_0"])
        {
            //关
             [self.mybtn1 setImage:[UIImage imageNamed:@"pic_shez_yin2_k"] forState:0];
        }
        else
        {
            //开
            [self.mybtn1 setImage:[UIImage imageNamed:@"pic_shez_yin2_g"] forState:0];
        }
    self.mymusicVoiceBlock0(@"11");
      
    
}
- (IBAction)myyoux22imusic:(id)sender {
    //背景音乐
    self.myvoice1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"voice1"];
           if([self.myvoice1 isEqualToString:@"voice1_1"])
           {
               //关
                [self.mybtn2 setImage:[UIImage imageNamed:@"pic_shez_yin_k"] forState:0];
           }
           else
           {
               //开
               [self.mybtn2 setImage:[UIImage imageNamed:@"pic_shez_yin_g"] forState:0];
           }
     self.mymusicVoiceBlock0(@"22");
}
- (IBAction)myyou33ximusic:(id)sender {
    //新手引导
     self.mymusicVoiceBlock0(@"33");
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
