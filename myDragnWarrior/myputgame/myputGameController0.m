//
//  myputGameController0.m
//  FanBi
//
//  Created by jin on 2020/4/13.
//  Copyright © 2020 zhangjin. All rights reserved.
//

#import "myputGameController0.h"
#import "myputView.h"
#import "mygamesetController.h"
//#import "myshopController.h"
//#import "myjiangPoolController.h"
//#import "mygameInvateController.h"
//#import "myOffLinePopController.h"
#import <AVFoundation/AVFoundation.h> //音频视频框架
#import <AudioToolbox/AudioToolbox.h>
#import "MarqueeView.h"
//#import "mylingquModle.h"
#import "ZXCountDownView.h"
#import "Masonry.h"
#import "UIView+WYKit.h"
#import "myquteAction.h"

#define myStantime  2+arc4random()%3

/** UserDefaults */
#define KUserDefaults           [NSUserDefaults standardUserDefaults]

/** NotificationCenter */
#define KNotificationCenter     [NSNotificationCenter defaultCenter]


@interface myputGameController0 ()<AVAudioPlayerDelegate>
{
    
    
    CGPoint startPoint;
    CGPoint originPoint;
    CGPoint movingPoint;
    CGPoint mycenter;
    CGPoint myfinilCenter;
    int _buttonIndex;
    NSInteger mybtnMoveStart_index;
    NSInteger mybtnMoveEnd_index;
    CGFloat myheight;
    NSInteger myownlevel;
    
}
@property (weak, nonatomic) IBOutlet UIView *mybgview;
@property(nonatomic,strong)NSMutableArray *mypointarray0;//所有的4个点数组

@property(nonatomic,strong)NSMutableArray *mypointarray2;//所有的单个中心点数组
@property(nonatomic,strong)NSMutableArray *mynewpointArray3;//已放置的单个中心点数组
@property(nonatomic,strong)NSMutableArray *mybtnArray;//已放置的单个中心点数组

@property(nonatomic,strong)NSMutableArray *mybackcolorArray;//已放置的单个中心点数组
@property (weak, nonatomic) IBOutlet UIImageView *mysellimage;
@property (weak, nonatomic) IBOutlet UILabel *mytotallabel;
@property (weak, nonatomic) IBOutlet UILabel *mytotal2label;

@property(nonatomic,strong)AVAudioPlayer *audioplayer;//音频播放器
@property(nonatomic,strong)NSString *myvoice0;
@property(nonatomic,strong)NSString *myvoice1;

@property(nonatomic,strong)NSMutableArray *mytimerArray;//放置我所有龙金币的timer
@property (nonatomic , strong) MarqueeView *marqueeView; //跑马灯的view

@property(nonatomic,assign)NSInteger myAllCoinNumber;
@property(nonatomic,assign)NSInteger myAllDamnNumber;
@property (weak, nonatomic) IBOutlet UILabel *mydamnNumber;
@property (weak, nonatomic) IBOutlet UILabel *myuplevelLabel;

@property (weak, nonatomic) IBOutlet UIButton *mybtn0;
@property (weak, nonatomic) IBOutlet UIButton *mybtn1;

@property (weak, nonatomic) IBOutlet UIButton *mybtn2;
@property (weak, nonatomic) IBOutlet UIButton *mybtn3;
@property (weak, nonatomic) IBOutlet UIButton *mybtn4;


//@property(nonatomic,strong)mylingquModle *mylingqumod;
//@property(nonatomic,strong)mylingquModle *myDamnmod;
@property (weak, nonatomic) IBOutlet UILabel *mynickname;
@property (weak, nonatomic) IBOutlet UIImageView *myheadimage;

//@property(nonatomic,strong)BXBBasicUserInfo *myuserInfo;

@property(nonatomic,assign) CGFloat myAccert;

@property (weak, nonatomic) IBOutlet UIImageView *mysuoImage1;
@property (weak, nonatomic) IBOutlet UIImageView *mysuoImage2;


@property (weak, nonatomic) IBOutlet ZXCountDownLabel *mycountDownLabel1;
@property (weak, nonatomic) IBOutlet ZXCountDownLabel *mycountDownLabel2;
@property (weak, nonatomic) IBOutlet ZXCountDownLabel *mycountDownLabel3;


@end


static SystemSoundID soundIDTest = 0;//当soundIDTest == kSystemSoundID_Vibrate的时候为震动


@implementation myputGameController0


- (IBAction)mybackclicked:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    

    //这里退出的时候mytimer都要关闭
    
    //移除数组里所有的timer
    for (int i = 0; i<self.mytimerArray.count; i++)
    {
        NSTimer *myti =  (NSTimer *)self.mytimerArray[i];
        [myti isValid];
        [myti invalidate];
        myti = nil;
    }
  
    //没有
    [self.audioplayer pause];
    
    [self.marqueeView.timer invalidate];
    
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //播放背景音乐
//    self.myuserInfo = [BXBBasicUserInfo sharedUerInfo];
    
    self.mynickname.text = @"小苹果";
   
    self.myheadimage.layer.cornerRadius = 18;
    self.myheadimage.clipsToBounds = YES;
//     [self.myheadimage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:nil];
    
    self.myvoice0 = [[NSUserDefaults standardUserDefaults] valueForKey:@"voice0"];
    self.myvoice1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"voice1"];
    
    if ([self.myvoice1 isEqualToString:@"voice1_1"])
    {
        //没有
        [self.audioplayer pause];
    }
    else
    {
        [self.audioplayer play];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    self.navigationController.navigationBar.hidden = YES;
    
//    self.mybtn0.enabled = NO;
//    self.mybtn1.enabled = NO;
    
//    self.bxb_prefersNavigationBarHidden = YES;
    
    self.myAllCoinNumber = 0;
     self.myAllDamnNumber = 0;
    self.mytotallabel.text = @"0";
     self.mytotal2label.text = @"点我放置蛋蛋";
     self.mydamnNumber.text = @"0";
    self.myAccert = 0;
    _buttonIndex = 0;
    myownlevel = 0;
    
    self.mypointarray0 = [NSMutableArray arrayWithCapacity:0];
    
    self.mypointarray2 = [NSMutableArray arrayWithCapacity:0];
    self.mynewpointArray3 = [NSMutableArray arrayWithCapacity:0];
    self.mybtnArray = [NSMutableArray arrayWithCapacity:0];
    self.mybackcolorArray = [NSMutableArray arrayWithCapacity:0];
    self.mytimerArray = [NSMutableArray arrayWithCapacity:0];
    
    self.mysellimage.hidden = YES;
    CGFloat mygap = 10;
    CGFloat mywid = ((KScreenWidth1-80) - mygap *4)/3;
    myheight = mywid *60/84;
    NSLog(@"mywid = %f,%f",mywid,myheight);
    for (int i = 0; i<15; i++)
    {
        NSMutableArray *myimagepoint = [NSMutableArray arrayWithCapacity:0];
        int j = (int)((int)i/3);
        int k = (int)((int)i%3);
        NSLog(@"%d",j);
        UIView *myview = [[UIView alloc]initWithFrame:CGRectMake(mygap+(mygap+mywid)*k+40, j*(mygap+myheight)+mygap+190, mywid, myheight)];
        myview.backgroundColor = [UIColor clearColor];
        myview.tag = i;
        //        myview.alpha = 0.6;
        
        UIImageView *myimage0 = [[UIImageView alloc]init];
        myimage0.image = [UIImage imageNamed:@"pic_index_di"];
        [myview addSubview:myimage0];
        [myimage0 mas_makeConstraints:^(MASConstraintMaker *make) {
            //                make.bottom.equalTo(0);
            //                make.left.right.equalTo(0);
            //                make.height.equalTo(120);
            make.centerY.equalTo(myview).offset(15);
            make.centerX.equalTo(myview);
            //            make.centerY.equalTo(myview).offset(10);
        }];
        
        UIImageView *myimage1 = [[UIImageView alloc]init];
        myimage1.image = [UIImage imageNamed:@"pic_index_di_quan"];
        myimage1.tag = i;
        myimage1.hidden = YES;
        //        if (i>7)
        //        {
        [myview addSubview:myimage1];
        [myimage1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(myview).offset(8);
            //                make.centerY.equalTo(myview);
            make.centerX.equalTo(myview);
        }];
        //        }
        [self.mybackcolorArray addObject:myimage1];
        
        [self.view addSubview:myview];
        
        [myimagepoint addObject:[NSString stringWithFormat:@"%.02f",mygap+(mygap+mywid)*k+40]];
        [myimagepoint addObject:[NSString stringWithFormat:@"%.02f",j*(mygap+myheight)+mygap+190]];
        [myimagepoint addObject:[NSString stringWithFormat:@"%.02f",mywid]];
        [myimagepoint addObject:[NSString stringWithFormat:@"%.02f",myheight]];
        [self.mypointarray0 addObject:myimagepoint];
        
        
        NSString *cente1 = [NSString stringWithFormat:@"%.02f",mygap+(mygap+mywid)*k + mywid/2+40];
        NSString *cente2 = [NSString stringWithFormat:@"%.02f",j*(mygap+myheight)+mygap + myheight/2+190];
        CGPoint mypoint =  CGPointMake(cente1.floatValue, cente2.floatValue);
        [self.mypointarray2 addObject:NSStringFromCGPoint(mypoint)];
        
        
        
        myputView *myoldview = [[[NSBundle mainBundle] loadNibNamed:@"myputView" owner:nil options:nil] firstObject];
        //        myoldview.myputlabel.text = [NSString stringWithFormat:@"%d",i];
        myoldview.myputlabel.hidden = YES;
        myoldview.tag = i;
        myoldview.mytagg = i;
        [myoldview.myputbutton setImage:[UIImage imageNamed:@"pic_index_long_dan1"] forState:0];
        myoldview.myDragnLevel = 0;
        myoldview.center = mypoint;
        myoldview.hidden = YES;
        myoldview.backgroundColor = [UIColor clearColor];
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(buttonpanPressed:)];
        panGesture.view.tag = i;
        [myoldview addGestureRecognizer:panGesture];
        myoldview.userInteractionEnabled = NO;
        [self.view addSubview:myoldview];
        [self.mybtnArray addObject:myoldview];
        
       
        NSTimer  *mytimer = [NSTimer scheduledTimerWithTimeInterval:myStantime target:self selector:@selector(addmycoinnumber:) userInfo:myoldview repeats:YES];
        [mytimer setFireDate:[NSDate distantFuture]];//暂停
        [self.mytimerArray addObject:mytimer];
        
        #pragma mark 跑马灯内容
         [self.view addSubview:self.marqueeView];
        self.marqueeView.marqueeText = @"我是你远方飘来的云，你是我江南遇见的雨。 我是你远方飘来的云，你是我江南遇见的雨。 我是你远方飘来的云，你是我江南遇见的雨。 我是你远方飘来的云，你是我江南遇见的雨。 我是你远方飘来的云，你是我江南遇见的雨。 我是你远方飘来的云，你是我江南遇见的雨。 我是你远方飘来的云，你是我江南遇见的雨。 我是你远方飘来的云，你是我江南遇见的雨。 我是你远方飘来的云，你是我江南遇见的雨。 我是你远方飘来的云，你是我江南遇见的雨。 我是你远方飘来的云，你是我江南遇见的雨。 我是你远方飘来的云，你是我江南遇见的雨。 我是你远方飘来的云，你是我江南遇见的雨。 我是你远方飘来的云，你是我江南遇见的雨。 我是你远方飘来的云，你是我江南遇见的雨。";
        
    }
    
    
    [self myGoidremain]; //查询金币和位置
    [self checkmyDragnCaEarnn]; //查询分红龙是否可领
    [self myDamnNUMberRequest];//查询砖石是否可领
    
    
      
}


 #pragma mark 产生金币的view
- (void)addmycoinnumber:(NSTimer *)mytime
{
    myputView *myoldview = mytime.userInfo;
    
    
    
    if(myoldview.hidden)
    {
        [mytime invalidate];
        mytime = nil;
    }
    
    
    UIView *mycoinback = [[UIView alloc]initWithFrame:CGRectMake(0, myheight-30, myoldview.frame.size.width, 30)];
    mycoinback.backgroundColor = [UIColor clearColor];
    [myoldview addSubview:mycoinback];
    
    UILabel *mylabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, myoldview.frame.size.width-28, 20)];
    mylabel1.backgroundColor = [UIColor clearColor];
    mylabel1.text = @"+134";
    mylabel1.textAlignment = NSTextAlignmentRight;
    mylabel1.font = [UIFont boldSystemFontOfSize:14];
    mylabel1.textColor = [UIColor whiteColor];
    [mycoinback addSubview:mylabel1];
    
    UIImageView *mycoinimage = [[UIImageView alloc]initWithFrame:CGRectMake(myoldview.frame.size.width-25, 2, 25, 23)];
    mycoinimage.backgroundColor = [UIColor clearColor];
    mycoinimage.image = [UIImage imageNamed:@"pic_index_bi1"];
    [mycoinback addSubview:mycoinimage];
    
    
    
    [UIView animateWithDuration:0.8 animations:^{
        mycoinback.Y = -10;
    } completion:^(BOOL finished) {
        mycoinback.hidden = YES;
    }];
    
    
    [UIView animateWithDuration:0.2 animations:^{
        self.mytotallabel.text = [NSString stringWithFormat:@"%ldK",[self.mytotallabel.text integerValue]+134];
        self.mytotallabel.transform = CGAffineTransformScale(self.mytotallabel.transform, 1.8, 1.8);
        //播放加金币背景音乐
        
        self.myvoice0 = [KUserDefaults valueForKey:@"voice0"];
        if([self.myvoice0 isEqualToString:@"voice0_0"])
        {
            //游戏音乐关
        }
        else
        {
            //游戏音乐开
            NSString *filePath = [[NSBundle mainBundle] pathForResource:@"get_Gold" ofType:@"wav"];
            [self playmycoinMusicforOnce:filePath];
        }
        
        
    } completion:^(BOOL finished) {
        
        self.mytotallabel.transform  = CGAffineTransformIdentity;
    }];
    
}

- (IBAction)addmydandanBtnClicked:(UIButton *)sender {
    #pragma mark 创建蛋蛋
    
    //初始买最开始蛋蛋
    [self CreatemyDandan:0];
   
    
}

- (void)CreatemyDandan:(NSInteger )myLevel
{
    
       //获取为放置的空白处
       NSMutableArray *myarry1 = [self getmyNotContainArray];
       if (myarry1.count == 0)
       {
           return ;
       }
       CGPoint mybtn4 = CGPointFromString([myarry1 objectAtIndex:0]);

       if (![self.mynewpointArray3 containsObject:NSStringFromCGPoint(mybtn4)]) {
           [self.mynewpointArray3 addObject:NSStringFromCGPoint(mybtn4)];
       }
       
       
       
       for (int i = 0; i<self.mybtnArray.count; i++)
       {
           myputView *myoldview = self.mybtnArray[i];
           //判断两个点是否相同
           
           if (CGPointEqualToPoint(myoldview.center,mybtn4))
           {
               [myoldview.myputbutton setImage:[UIImage imageNamed:@"pic_index_long_dan1"] forState:0];
               if (myLevel > 0)
               {
                     myoldview.myDragnLevel = myLevel;
               }
               else
               {
                     myoldview.myDragnLevel = 0;
               }
             
               myoldview.hidden = NO;
               myoldview.tag = i;
               myoldview.userInteractionEnabled = YES;
               [self.view bringSubviewToFront:myoldview];
               
               [self performSelector:@selector(fuhuadandan:) withObject:myoldview afterDelay:2.0];
               
           }
//           NSLog(@"%@",NSStringFromCGPoint(myoldview.center));
       }
       
      
}

 #pragma mark 蛋的孵化过程
- (void)fuhuadandan:(myputView *)myoldview
{
    //初始化一个动画 ,,摇一摇孵化蛋蛋
    CABasicAnimation *baseAnimation = [CABasicAnimation animation];
    //动画运动的方式，现在指定的是围绕Z轴旋转
    baseAnimation.keyPath = @"transform.rotation.z";
    //动画持续时间
    baseAnimation.duration = 0.4;
    //     baseAnimation.speed = 0.2;
    //动画次数
    baseAnimation.repeatCount = MAXFLOAT;
    //开始的角度
    baseAnimation.fromValue = [NSNumber numberWithFloat:-(M_PI/8)];
    //结束的角度
    baseAnimation.toValue = [NSNumber numberWithFloat:M_PI/8];
    //动画的运动方式
    baseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    //是否反向移动动画
    baseAnimation.autoreverses = YES;
    
    //动画结束后的状态
    baseAnimation.fillMode = kCAFillModeBackwards;
    [baseAnimation setValue:@"left" forKey:@"left"];
    [myoldview.layer addAnimation:baseAnimation forKey:@"left"];
    
    [self performSelector:@selector(level1dragn:) withObject:myoldview afterDelay:1.2];
    
    //0.4秒后停止动画，表示蛋蛋已经孵化了，
    
    
}

 #pragma mark 蛋蛋开始孵化
-(void)level1dragn:(myputView *)myoldview
{
    [myoldview.layer removeAllAnimations];
    
    if (myoldview.myDragnLevel==0)
    {
        myoldview.myDragnLevel = myoldview.myDragnLevel+1;
    }
    else
    {
        myoldview.myDragnLevel = myoldview.myDragnLevel;
    }
   
    
 
    
    UIImage *mydargnimage = [myquteAction getmyImageDragnbylevel:myoldview.myDragnLevel];
//    [myoldview.myputbutton setImage:[UIImage imageNamed:@"pic_index_long_1"] forState:0];
     [myoldview.myputbutton setImage:mydargnimage forState:0];
    //孵化以后再增加金币
    
    //    mytimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(addmycoinnumber:) userInfo:myoldview repeats:YES];
    //    [self.mytimerArray addObj:mytimer];
//    NSLog(@"mydragnTag = %ld",myoldview.tag);
    
    
    #pragma mark  //蛋蛋孵化成龙的声音
           NSString *filePath = [[NSBundle mainBundle] pathForResource:@"egg_Open" ofType:@"wav"];
           [self playmycoinMusicforOnce:filePath];
    
   #pragma mark //2秒后才孵化 拿到对应的timer并打开产生金币 、
    [self performSelector:@selector(openmyegg:) withObject:myoldview afterDelay:myStantime];
    
   //把孵化的龙上传位置
      [self getmycoordPostion];
    
}
 #pragma mark 蛋孵化龙2秒后产生金币
- (void)openmyegg:(myputView *)myoldview{
    NSTimer *myti =  (NSTimer *)self.mytimerArray[myoldview.tag];
    [myti setFireDate:[NSDate date]];//播放金币的声音
}
 #pragma mark 拖动龙的过程
- (void)buttonpanPressed:(UIPanGestureRecognizer *)sender
{
    
    mybtnMoveStart_index = sender.view.tag;
    mybtnMoveEnd_index = mybtnMoveStart_index; //终点值默认为起始值直到后面重新赋值，没有这句话后面会有bug
    myputView *mybtn = self.mybtnArray[sender.view.tag];
    
    self.mysellimage.hidden = NO;
    
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        
        
        startPoint = [sender locationInView:sender.view];
        originPoint = mybtn.center;
        mycenter = mybtn.center;
        [UIView animateWithDuration:0.2 animations:^{
            
            mybtn.transform = CGAffineTransformMakeScale(1.1, 1.1);
            mybtn.alpha = 0.6;
        }];
        
        
        
        for (int i = 0; i<self.mybtnArray.count; i++)
        {
            myputView *myoldview = self.mybtnArray[i];
            
            
            if (!myoldview.hidden)
            {
                UIImageView *mybackimage = self.mybackcolorArray[i];
                if (mybtn.myDragnLevel == myoldview.myDragnLevel)
                {
                    mybackimage.hidden = NO;
                }
                else
                {
                    mybackimage.hidden = YES;
                }
            }
            
            
        }
        
        
        
    }
    else if (sender.state == UIGestureRecognizerStateChanged)
    {
        CGPoint newPoint = [sender locationInView:sender.view];
        CGFloat deltaX = newPoint.x-startPoint.x;
        CGFloat deltaY = newPoint.y-startPoint.y;
        mybtn.center = CGPointMake(mybtn.center.x+deltaX,mybtn.center.y+deltaY);
        //        NSLog(@"Moving Center = %@",NSStringFromCGPoint(self.center));
        originPoint = mybtn.center;
        
        
        [UIView animateWithDuration:0.2 animations:^{
            
            CGPoint temp = CGPointZero;
            myputView *button = mybtn;
            temp = button.center;
            button.center = originPoint;
            //            mybtn.center = temp;
            originPoint = mybtn.center;
            NSLog(@"移动中的点的坐标%@",NSStringFromCGPoint(originPoint));
            //            contain = YES;
            
        }];
        
        
    }
    else if (sender.state == UIGestureRecognizerStateEnded)
    {
        
        self.mysellimage.hidden = YES;
        
        for (int i = 0; i<self.mybackcolorArray.count; i++)
        {
            UIImageView *mybackimage = self.mybackcolorArray[i];
            mybackimage.hidden = YES;
        }
        
        
        if (self.mypointarray0.count>0) {
            if (YES==[self buttonCanDownByArray:self.mypointarray0]) {
                [UIView animateWithDuration:0.2 animations:^{
                    mybtn.transform = CGAffineTransformIdentity;
                    mybtn.alpha = 1.0;
                    //                    self.center = originPoint;
                    if (myfinilCenter.x > 0 && myfinilCenter.y > 0)
                    {
                        
                        
                        for (int i = 0; i<self.mypointarray2.count; i++)
                       {
                              CGPoint mypoint = CGPointFromString([self.mypointarray2 objectAtIndex:i]);
                           NSLog(@"%@",NSStringFromCGPoint(mypoint));
                           if(CGPointEqualToPoint(mypoint,myfinilCenter))
                           {
                               mybtnMoveEnd_index = i;
                           }
                       }
                        if (mybtnMoveStart_index == mybtnMoveEnd_index)
                        {
                            mybtn.center = mycenter;
                            //在同一个框内拖动不移动
                            return;
                        }
                        
                        
                        if ([self.mynewpointArray3 containsObject:NSStringFromCGPoint(myfinilCenter)])
                        {
 
                            myputView * theButton1 = self.mybtnArray[mybtnMoveEnd_index];
                            
                            if (mybtn.myDragnLevel == theButton1.myDragnLevel)
                            {
                                
                                myputView *mysubbtn = self.mybtnArray[mybtnMoveStart_index];
                                myputView *mysubbtn1 = self.mybtnArray[mybtnMoveEnd_index];
                                if (mysubbtn.myDragnLevel == 40 || mysubbtn1.myDragnLevel == 40)
                                {
                                    mysubbtn.center = mycenter;
//                                    [myalertobject presentMyTimeInViewController:sender AndMessage:@"您已是最高级龙"];
                                    return;
                                }
                                
                                
                                [self.mynewpointArray3 removeObject:NSStringFromCGPoint(mycenter)];
                                
                                mysubbtn.center = mycenter;
                                mysubbtn.hidden = YES;
                                mysubbtn.myDragnLevel = 0;
                                mysubbtn.tag = mybtnMoveStart_index;
                                mysubbtn.userInteractionEnabled = NO;
                                [self.view bringSubviewToFront:mysubbtn];
                                [self.mybtnArray replaceObjectAtIndex:mybtnMoveStart_index withObject:mysubbtn];
                                //
                                //                             //移动后按钮赋值
                                
                                mysubbtn1.center = myfinilCenter;
                                mysubbtn1.tag = mybtnMoveEnd_index;
                                
                             
                                mysubbtn1.myDragnLevel = mysubbtn1.myDragnLevel+1;
                               
                                #pragma mark   //把两个想通同的蛋蛋互合成一个更高级的龙
                                
                                [self.mybtnArray replaceObjectAtIndex:mybtnMoveEnd_index withObject:mysubbtn1];
                                
                                
                                 #pragma mark  //合成后开始的时间暂停，后面的时间继续播放，其实后面的时间不写他也会播放
                                NSTimer *myti1 =  (NSTimer *)self.mytimerArray[mybtnMoveStart_index];
                                [myti1 setFireDate:[NSDate distantFuture]];//暂停
                                
                                NSTimer *myti2 =  (NSTimer *)self.mytimerArray[mybtnMoveEnd_index];
                                [myti2 setFireDate:[NSDate date]];//播放
                                
                                
                                #pragma mark  //合成高级别龙的声音
                                NSString *filePath = @"";
                                 if (mysubbtn1.myDragnLevel > 3)
                                 {
                                      filePath  = [[NSBundle mainBundle] pathForResource:@"get_Reward" ofType:@"wav"];
                                 }
                                else
                                {
                                      filePath = [[NSBundle mainBundle] pathForResource:@"get_MergeDragon" ofType:@"wav"];
                                }
                                       
                                [self playmycoinMusicforOnce:filePath];
                                
                                //接口上传合成龙的位置，level是合成前的
                                [self upGrademyDragnByLevel:mysubbtn1.myDragnLevel-1 Andposition1:mybtnMoveStart_index Andposition2:mybtnMoveEnd_index];
                                [self relinemybtnFormup];
                                //把孵化的龙上传位置
//                                    [self getmycoordPostion];
                                
                                return ;
                            }
                            else
                            {
                              #pragma mark     //把两个想不同的蛋蛋互换
                             
                                
                                myputView *mysubbtn = self.mybtnArray[mybtnMoveStart_index];
                                mysubbtn.center = mycenter;
                            
                                
                                
                                NSInteger myleeee = mysubbtn.myDragnLevel;
                                
                                
                               
                                
                                 //移动后按钮赋值
                                
                                myputView *mysubbtn1 = self.mybtnArray[mybtnMoveEnd_index];
                                mysubbtn1.center = myfinilCenter;
                                 mysubbtn.myDragnLevel = mysubbtn1.myDragnLevel;
                                mysubbtn1.myDragnLevel = myleeee;
                               
                                
                                 [self.mybtnArray replaceObjectAtIndex:mybtnMoveStart_index withObject:mysubbtn];
                                [self.mybtnArray replaceObjectAtIndex:mybtnMoveEnd_index withObject:mysubbtn1];
                                
  
                                NSTimer *myti1 =  (NSTimer *)self.mytimerArray[mybtnMoveStart_index];
                             [myti1 setFireDate:[NSDate date]];//播放
                             
                             NSTimer *myti2 =  (NSTimer *)self.mytimerArray[mybtnMoveEnd_index];
                             [myti2 setFireDate:[NSDate date]];//播放
                             
                             
                             #pragma mark  //合成高级别龙的声音
                             NSString *filePath = [[NSBundle mainBundle] pathForResource:@"runway_Finish" ofType:@"wav"];
                                    
                             [self playmycoinMusicforOnce:filePath];
                                                         
                                                         
                                
                                [self relinemybtnFormup];
                                //把孵化的龙上传位置
//                                    [self getmycoordPostion];
                            }
                            
                        }
                        else
                        {
                            
                           #pragma mark    //把蛋蛋将移动到新空白地方
                            
                            [self.mynewpointArray3 removeObject:NSStringFromCGPoint(mycenter)];
                            if (![self.mynewpointArray3 containsObject:NSStringFromCGPoint(myfinilCenter)]) {
                                [self.mynewpointArray3 addObject:NSStringFromCGPoint(myfinilCenter)];
                            }
     
//                            //移动前按钮
//                            myputView *mysubbtn = self.mybtnArray[mybtnMoveStart_index];
//                            mysubbtn.center = myfinilCenter;
//                            //                            mysubbtn.tag = mybtnMoveEnd_index;
//                            [self.mybtnArray replaceObjectAtIndex:mybtnMoveStart_index withObject:mysubbtn];
//                            //移动后按钮赋值
//                            myputView *mysubbtn1 = self.mybtnArray[mybtnMoveEnd_index];
//                            mysubbtn1.center = mycenter;
//                            //                            mysubbtn1.tag = mybtnMoveStart_index;
//                            [self.mybtnArray replaceObjectAtIndex:mybtnMoveEnd_index withObject:mysubbtn1];
                            
                            
                                
                            //移动前按钮
                         myputView *mysubbtn = self.mybtnArray[mybtnMoveStart_index];
                      NSInteger myleeee = mysubbtn.myDragnLevel;
                            mysubbtn.center = mycenter;
                         //                            mysubbtn.tag = mybtnMoveEnd_index;
                      
                         //移动后按钮赋值
                         myputView *mysubbtn1 = self.mybtnArray[mybtnMoveEnd_index];
                         mysubbtn1.center = myfinilCenter;
                            mysubbtn.hidden = YES;
                            mysubbtn.myDragnLevel = 0;
                            mysubbtn1.myDragnLevel = myleeee;
                            mysubbtn1.hidden = NO;
                      
                         [self.mybtnArray replaceObjectAtIndex:mybtnMoveEnd_index withObject:mysubbtn1];
                        [self.mybtnArray replaceObjectAtIndex:mybtnMoveStart_index withObject:mysubbtn];
                            

//                            [self.mybackcolorArray exchangeObjectAtIndex:mybtnMoveEnd_index withObjectAtIndex:mybtnMoveStart_index];//交换同类的背景色，没有这个句，讲道理这里和下面时间不应该移动，因为我数组里面button没有移动过
                            //这个timer在数组里也要移到新的地方
//                            [self.mytimerArray exchangeObjectAtIndex:mybtnMoveEnd_index withObjectAtIndex:mybtnMoveStart_index];
                            
                            NSTimer *myti1 =  (NSTimer *)self.mytimerArray[mybtnMoveStart_index];
                            [myti1 setFireDate:[NSDate distantFuture]];//暂停
                            
                            NSTimer *myti2 =  (NSTimer *)self.mytimerArray[mybtnMoveEnd_index];
                            [myti2 setFireDate:[NSDate date]];//播放
                            
                            
                            #pragma mark  //合成高级别龙的声音
                            NSString *filePath = [[NSBundle mainBundle] pathForResource:@"spin_Start" ofType:@"wav"];
                                   
                            [self playmycoinMusicforOnce:filePath];
                            
                            
                            
                            
                            
                            [self relinemybtnFormup];
                            
                        }
                    }
                    else
                    {
                        mybtn.transform = CGAffineTransformIdentity;
                        mybtn.alpha = 1.0;
                        mybtn.center = mycenter;
                    }
                    
                }];
            }else {
                [UIView animateWithDuration:0.2 animations:^{
                    mybtn.transform = CGAffineTransformIdentity;
                    mybtn.alpha = 1.0;
                    mybtn.center = mycenter;
                }];
            }
        }else{
            [UIView animateWithDuration:0.2 animations:^{
                mybtn.transform = CGAffineTransformIdentity;
                mybtn.alpha = 1.0;
                mybtn.center = mycenter;
            }];
        }
        
        
    }//else if 结束
}


#pragma mark 按钮重新主队
- (void)relinemybtnFormup
{
    for (int i = 0; i<self.mybtnArray.count; i++)
    {
        myputView *myoldview = self.mybtnArray[i];
        //判断两个点是否相同
        if (myoldview.hidden)
        {
            myoldview.hidden = YES;
            myoldview.tag = i;
            myoldview.userInteractionEnabled = NO;
            [self.view bringSubviewToFront:myoldview];
        }
        else
        {
            myoldview.hidden = NO;
            myoldview.tag = i;
            myoldview.userInteractionEnabled = YES;
            [self.view bringSubviewToFront:myoldview];
        }
        if (myoldview.myDragnLevel == 0)
        {
            
            [myoldview.myputbutton setImage:[UIImage imageNamed:@"pic_index_long_dan1"] forState:0];
        }
        else
        {
             [myoldview.myputbutton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"pic_index_long_%ld",myoldview.myDragnLevel]] forState:0];
        }
//        else if(myoldview.myDragnLevel == 1)
//        {
//            [myoldview.myputbutton setImage:[UIImage imageNamed:@"pic_index_long_1"] forState:0];
//        }
//        else if(myoldview.myDragnLevel == 2)
//        {
//            [myoldview.myputbutton setImage:[UIImage imageNamed:@"pic_index_long_2"] forState:0];
//        }
//        else if(myoldview.myDragnLevel == 3)
//        {
//            [myoldview.myputbutton setImage:[UIImage imageNamed:@"pic_index_long_3"] forState:0];
//        }
    }
    //把孵化的龙上传位置
    [self getmycoordPostion];
}
//根据数组里面的是否有YES
-(BOOL)buttonCanDownByArray:(NSMutableArray *)array{
    for (NSArray *arr in self.mypointarray0) {
        NSString *X = arr[0];
        NSString *Y = arr[1];
        NSString *W = arr[2];
        NSString *H = arr[3];
        if ([self thePoint:originPoint isInTheRange:CGRectMake(X.intValue, Y.intValue, W.intValue, H.intValue)]==YES) {
            return YES;
        }
    }//for 结束
    return NO;
}


//判断传入的CGPoint 是否在一个范围内
-(BOOL)thePoint:(CGPoint)point isInTheRange:(CGRect)frame{
    
    //得到范围的4个顶点
    CGPoint lTPoint = CGPointMake(frame.origin.x,frame.origin.y);//左上角顶点 P1
    CGPoint rTPoint= CGPointMake(frame.origin.x+frame.size.width,frame.origin.y);//右上角顶点 P2
    CGPoint lBPoint= CGPointMake(frame.origin.x,frame.origin.y+frame.size.height);//左下角顶点 P3
    CGPoint rBPoint= CGPointMake(frame.origin.x+frame.size.width,frame.origin.y+frame.size.height);//右下角顶点 P4
    NSLog(@"4个顶点是：(%@,%@,%@,%@)",NSStringFromCGPoint(lTPoint),NSStringFromCGPoint(rTPoint),NSStringFromCGPoint(lBPoint),NSStringFromCGPoint(rBPoint));
    //在范围内，return YES
    if (point.x>=lTPoint.x && point.y>=lTPoint.y && point.x<=rBPoint.x && point.y<=rBPoint.y) {
        
        //          CGPoint mybtn1 = CGPointFromString([self.mypointarray2 objectAtIndex:mybtnMoveStart_index]);
        NSLog(@"%lf,%lf",frame.origin.x + frame.size.width/2,frame.origin.y + frame.size.height/2);
        
        
       CGFloat cente1 = frame.origin.x + frame.size.width/2;
        CGFloat cente2 = frame.origin.y + frame.size.height/2;
      
        
        for (int i = 0; i<self.mypointarray2.count; i++)
             {
                    CGPoint mypoint = CGPointFromString([self.mypointarray2 objectAtIndex:i]);
                 NSLog(@"%@",NSStringFromCGPoint(mypoint));
                 if((mypoint.x-5 < cente1 && cente1 < mypoint.x+5) && (mypoint.y-5 < cente2 && cente2 < mypoint.y+5))
                 {
                     myfinilCenter = mypoint;
                 }
             }


        
        
//        myfinilCenter =  CGPointMake(cente1.floatValue,cente2.floatValue);
        
        
        return YES;
    }
    
    if (point.x>=KScreenWidth1/2-63 && point.y>=KScreenHeight1-60 && point.x<=KScreenWidth1/2+63 && point.y<=KScreenHeight1-5)
    {
        NSLog(@"删除这个恐龙");
        //重置拖动的这个蛋蛋
        [self.mynewpointArray3 removeObject:NSStringFromCGPoint(mycenter)];
        
        myputView *myoldview = self.mybtnArray[mybtnMoveStart_index];
        myoldview.mytagg = mybtnMoveStart_index;
        [myoldview.myputbutton setImage:[UIImage imageNamed:@"pic_index_long_dan1"] forState:0];
        
        //告诉服务器我要卖龙
        
        
        NSLog(@"-----1111--1---%ld,%ld",myoldview.myDragnLevel,mybtnMoveStart_index);
        
         [self sellmyDragnByLevel:myoldview.myDragnLevel Andposition:mybtnMoveStart_index];
        
        myoldview.myDragnLevel = 0;
        myoldview.center = mycenter;
        myoldview.hidden = YES;
        myoldview.backgroundColor = [UIColor clearColor];
        myoldview.userInteractionEnabled = NO;
        
       
        //把孵化的龙上传位置，这里不确定要不要吧龙的位置接口放到删成功以后
        [self getmycoordPostion];
        
        //删除的时候暂停这个timer
        NSTimer *myti =  (NSTimer *)self.mytimerArray[mybtnMoveStart_index];
        [myti setFireDate:[NSDate distantFuture]];//暂停
        
       #pragma mark  //删除龙的声音
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"delete_Dragon" ofType:@"wav"];
        [self playmycoinMusicforOnce:filePath];
    }
    
    return NO;
}

- (NSMutableArray *)getmyNotContainArray
{
    NSMutableArray *myarray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i<self.mypointarray2.count; i++)
    {
        
        CGPoint mybtn1 = CGPointFromString([self.mypointarray2 objectAtIndex:i]);
        
        if (self.mynewpointArray3.count == 0)
        {
            [myarray addObject:NSStringFromCGPoint(mybtn1)];
            
        }
        else
        {
            for (int k= 0; k<self.mynewpointArray3.count; k++)
            {
                CGPoint mybtn2 = CGPointFromString([self.mynewpointArray3 objectAtIndex:k]);
                
                if (![self.mynewpointArray3 containsObject:NSStringFromCGPoint(mybtn1)])
                {
                    if (![myarray containsObject:NSStringFromCGPoint(mybtn1)])
                    {
                        [myarray addObject:NSStringFromCGPoint(mybtn1)];
                    }
                }
            }
        }
        
    }
    
    return myarray;
}


//可重复播放的背景音乐
-(AVAudioPlayer *)audioplayer
{
    if (!_audioplayer) {
        
        NSURL *url =  [[NSBundle mainBundle] URLForResource:@"BGM.wav" withExtension:nil];
        NSError *error = nil;
        _audioplayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        _audioplayer.numberOfLoops = -1;
        _audioplayer.delegate = self;
        [_audioplayer prepareToPlay];
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        CGFloat currentVol = audioSession.outputVolume;
        NSLog(@"%lf",currentVol);
        _audioplayer.volume = currentVol;
    }
    return _audioplayer;
}
//播放比如产生金币的音乐，每次只播放一次，不重复这种
- (void)playmycoinMusicforOnce:(NSString *)filePath
{
    
    if (filePath) {
        AudioServicesCreateSystemSoundID( (__bridge CFURLRef)[NSURL fileURLWithPath:filePath], &soundIDTest );
    }
    AudioServicesPlaySystemSound( soundIDTest );
    AudioSessionAddPropertyListener(kAudioSessionProperty_CurrentHardwareOutputVolume ,
                                    
                                    volumeListenerCallback,
                                    
                                    (__bridge void *)(self)
                                    
                                    );
    AudioServicesAddSystemSoundCompletion(soundIDTest, NULL, NULL, soundCompleteCallback, NULL);
}
void volumeListenerCallback (
                             
                             void                      *inClientData,
                             
                             AudioSessionPropertyID    inID,
                             
                             UInt32                    inDataSize,
                             
                             const void                *inData
                             
                             ){
    
    const float *volumePointer = inData;
    
    float volume = *volumePointer;
    
    NSLog(@"volumeListenerCallback %f", volume);
//    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
//        audioSession setvol = volume;
   
}
void soundCompleteCallback(SystemSoundID soundID,void * clientData){
//    NSLog(@"金币声音播放完成.的回调");
}
- (IBAction)mysetClicked:(UIButton *)sender {
    
    //设置弹框
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    mygamesetController * spcontroller = [storyboard instantiateViewControllerWithIdentifier:@"mygamesetController"];
    spcontroller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    spcontroller.providesPresentationContextTransitionStyle = YES;
    spcontroller.definesPresentationContext = YES;
    spcontroller.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    spcontroller.mymusicVoiceBlock0 = ^(NSString * _Nonnull mystr)
    {
        if ([mystr isEqualToString:@"11"])
        {
            self.myvoice0 = [KUserDefaults valueForKey:@"voice0"];
            if([self.myvoice0 isEqualToString:@"voice0_0"])
            {
                [KUserDefaults setValue:@"" forKey:@"voice0"];//游戏音乐开
            }
            else
            {
                [KUserDefaults setValue:@"voice0_0" forKey:@"voice0"];//游戏音乐关
            }
            
        }
        if ([mystr isEqualToString:@"22"])
        {
            
            self.myvoice1 = [KUserDefaults valueForKey:@"voice1"];
            if([self.myvoice1 isEqualToString:@"voice1_1"])
            {
                [KUserDefaults setValue:@"" forKey:@"voice1"];//背景音乐开
                [self.audioplayer play];
            }
            else
            {
                [KUserDefaults setValue:@"voice1_1" forKey:@"voice1"];//背景音乐关
                [self.audioplayer pause];
            }
            
        }
        if ([mystr isEqualToString:@"33"])
        {
            
        }
    };
    [self presentViewController:spcontroller animated:YES completion:nil];
    
}

- (IBAction)myshopClicked:(UIButton *)sender {
    
    //商店弹框
//    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"main" bundle:nil];
//    myshopController * spcontroller = [storyboard instantiateViewControllerWithIdentifier:@"myshopController"];
//    spcontroller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    spcontroller.providesPresentationContextTransitionStyle = YES;
//    spcontroller.definesPresentationContext = YES;
//    spcontroller.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//    spcontroller.myownlevel = myownlevel;
//    spcontroller.mybuydragnBlo0 = ^(NSString * _Nonnull mylevel) {
//        NSInteger my2level = [mylevel integerValue];
//         [self CreatemyDandan:my2level]; //买了后放置龙到新的位置上
//    };
//    [self presentViewController:spcontroller animated:YES completion:nil];
    
}
- (IBAction)myjiangchiClicked:(UIButton *)sender {
    
    //奖池弹框
//    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"main" bundle:nil];
//    myjiangPoolController * spcontroller = [storyboard instantiateViewControllerWithIdentifier:@"myjiangPoolController"];
//    spcontroller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    spcontroller.providesPresentationContextTransitionStyle = YES;
//    spcontroller.definesPresentationContext = YES;
//    spcontroller.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//
//    [self presentViewController:spcontroller animated:YES completion:nil];
    
}
- (IBAction)myjgameinvateiClicked:(UIButton *)sender {
    
    //邀请弹框
//    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"main" bundle:nil];
//    mygameInvateController * spcontroller = [storyboard instantiateViewControllerWithIdentifier:@"mygameInvateController"];
//    spcontroller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    spcontroller.providesPresentationContextTransitionStyle = YES;
//    spcontroller.definesPresentationContext = YES;
//    spcontroller.myaccortStr = [NSString stringWithFormat:@"%.01f",self.myAccert];
//    spcontroller.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//
//    [self presentViewController:spcontroller animated:YES completion:nil];
//
}
- (IBAction)myjgOFFlineiClicked:(UIButton *)sender {
    
    //离线收益弹框
//    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"main" bundle:nil];
//    myOffLinePopController * spcontroller = [storyboard instantiateViewControllerWithIdentifier:@"myOffLinePopController"];
//    spcontroller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    spcontroller.providesPresentationContextTransitionStyle = YES;
//    spcontroller.definesPresentationContext = YES;
//    spcontroller.mymrk = @"lixian";
//    spcontroller.mymoney = @"100 K";
//    spcontroller.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//
//    [self presentViewController:spcontroller animated:YES completion:nil];
    
}

- (IBAction)mybtnclcked:(UIButton *)sender {
    //升级和邀请领取
    
    
    //离线收益弹框
//    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"main" bundle:nil];
//    myOffLinePopController * spcontroller = [storyboard instantiateViewControllerWithIdentifier:@"myOffLinePopController"];
//    spcontroller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    spcontroller.providesPresentationContextTransitionStyle = YES;
//    spcontroller.definesPresentationContext = YES;
//
//    if(sender.tag == 50)
//    {
//        spcontroller.mymrk = @"zhuansi";
//        spcontroller.mymoney = [NSString stringWithFormat:@"X1"];
//    }
//    else  if(sender.tag == 60)
//      {
//          spcontroller.mymrk = @"yao1";
//          spcontroller.mymoney = [NSString stringWithFormat:@"X1"];
//      }
//    else  if(sender.tag == 70)
//      {
//          spcontroller.mymrk = @"yao2";
//          spcontroller.mymoney = [NSString stringWithFormat:@"X1"];
//      }
//    else  if(sender.tag == 100)
//   {
//       spcontroller.mymrk = @"shengji";
//       spcontroller.mymoney = [NSString stringWithFormat:@"X %ld",self.mylingqumod.data.upgradeNum];
//   }
//   else
//   {
//       spcontroller.mymrk = @"yaoqing";
//        spcontroller.mymoney = [NSString stringWithFormat:@"X %ld",self.mylingqumod.data.inviteNum];
//   }
//
//    spcontroller.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//    spcontroller.allLoadBlock0 = ^(NSString * _Nonnull str) {
//        //领取后刷新数据
//        [self checkmyDragnCaEarnn]; //查询分红龙是否可领
//           [self myDamnNUMberRequest];//查询砖石是否可领
//    };
//
//
//    [self presentViewController:spcontroller animated:YES completion:nil];
   
}


//跑马灯÷
- (MarqueeView *)marqueeView {
    if (!_marqueeView) {
        _marqueeView = [[MarqueeView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 36)];

    }
    return _marqueeView;
}

- (IBAction)lifangCLicked:(id)sender {
    
    //礼物反向添加蛋蛋
       
       
       
       //获取为放置的空白处
       NSMutableArray *myarry1 = [self getmyNotContainArray];
       if (myarry1.count == 0)
       {
           return ;
       }
       CGPoint mybtn4 = CGPointFromString([myarry1 lastObject]);

       if (![self.mynewpointArray3 containsObject:NSStringFromCGPoint(mybtn4)]) {
           [self.mynewpointArray3 addObject:NSStringFromCGPoint(mybtn4)];
       }
       
       
       
       for (int i = 0; i<self.mybtnArray.count; i++)
       {
           myputView *myoldview = self.mybtnArray[i];
           //        if (NSStringFromCGPoint(myoldview.center) == NSStringFromCGPoint(mybtn4))
           //判断两个点是否相同
           
           if (CGPointEqualToPoint(myoldview.center,mybtn4))
           {
               [myoldview.myputbutton setImage:[UIImage imageNamed:@"pic_index_long_dan1"] forState:0];
               myoldview.myDragnLevel = 0;
               myoldview.center = CGPointMake(myoldview.center.x,0);
               myoldview.hidden = NO;
               myoldview.tag = i;
               myoldview.userInteractionEnabled = YES;
               [self.view bringSubviewToFront:myoldview];
               
               [UIView animateWithDuration:1.5 animations:^{
                    
                    myoldview.center = mybtn4;
                   [myoldview layoutSubviews];
                   
               } completion:^(BOOL finished) {
                   [self performSelector:@selector(fuhuadandan:) withObject:myoldview afterDelay:2.0];
               }];
               
               
               
               
           }
           NSLog(@"%@",NSStringFromCGPoint(myoldview.center));
       }
    
}



  #pragma mark 判断所有有龙的点，记录位置并上传
- (void)getmycoordPostion
{
    //获取每个位置龙和蛋蛋的坐标并上传,这里是棋盘里每条龙发生变化都上传一次所有龙的位置
     //内部字典
     NSMutableDictionary *diccc2 = [NSMutableDictionary dictionary];
     NSMutableDictionary *diccc3 = [NSMutableDictionary dictionary];
    NSMutableArray *myarrat = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i<self.mybtnArray.count; i++)
    {
        myputView *myoldview = self.mybtnArray[i];
      
        //判断所有有龙的点，记录位置并上传
        
        if (!myoldview.hidden)
        {
           
            NSMutableDictionary *diccc1 = [NSMutableDictionary dictionary];
            [diccc1 setValue:[NSNumber numberWithInteger:myoldview.myDragnLevel] forKey:@"level"];
           [diccc1 setValue:[NSNumber numberWithInteger:i] forKey:@"position"];
            [myarrat addObject:diccc1];
        }
      
    }
  
     [diccc2 setValue:myarrat forKey:@"userArray"];
    NSString * mystr = [self dictionaryToJson:diccc2];

    [diccc3 setValue:mystr forKey:@"coordinate"];
  
    
    
    
    
//
}
- (void)myGoidremain
{
    //查询我账户剩余金币数量
    
     NSMutableDictionary *diccc3 = [NSMutableDictionary dictionary];
//        ;
}

#pragma mark  字典转换成json字符串
- (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


#pragma mark 删除龙，出售龙
- (void)sellmyDragnByLevel:(NSInteger)mylevel Andposition:(NSInteger)myposition
{
    
    if(mylevel == 0)
    {
        
        return;
    }
    
    NSMutableDictionary *dictt = [NSMutableDictionary dictionary];
         [dictt setValue:[NSNumber numberWithInteger:mylevel] forKey:@"level"];
     [dictt setValue:[NSNumber numberWithInteger:myposition] forKey:@"coordinate"];
//             ;
}
#pragma mark 合成龙，升级到高一级龙
- (void)upGrademyDragnByLevel:(NSInteger)mylevel Andposition1:(NSInteger)myposition1 Andposition2:(NSInteger)myposition2
{
    
    if(mylevel == 0)
    {
        
        return;
    }
    
    NSMutableDictionary *dictt = [NSMutableDictionary dictionary];
    [dictt setValue:[NSNumber numberWithInteger:mylevel] forKey:@"level"];
    [dictt setValue:[NSNumber numberWithInteger:myposition1] forKey:@"mtouchIndex"];
    [dictt setValue:[NSNumber numberWithInteger:myposition2] forKey:@"targetIndex"];
//     ;
}


- (NSString *)myUpgradebylevel:(NSInteger)level
{
    NSString *tvGetDragonLevel = @"";
    if (level < 5) {
          tvGetDragonLevel = @"升到５\n级领取";
      } else if (level >= 5 && level < 10) {
          tvGetDragonLevel = @"升到10\n级领取";
      } else if (level >= 10 && level < 15) {
           tvGetDragonLevel = @"升到15\n级领取";
      } else if (level >= 15 && level < 20) {
          tvGetDragonLevel = @"升到20\n级领取";
      } else if (level >= 20) {
          tvGetDragonLevel = [NSString stringWithFormat:@"升到%ld\n级领取",level+1];
      }
    return tvGetDragonLevel;
}


#pragma mark 查询首页分红龙是否可以领取
- (void)checkmyDragnCaEarnn
{
    
    NSMutableDictionary *dictt = [NSMutableDictionary dictionary];
//    [dictt setValue:[NSNumber numberWithInteger:mylevel] forKey:@"level"];
 
     
}


//查询左上方砖石和邀请好友信息
- (void)myDamnNUMberRequest
{
    
    NSMutableDictionary *dictt = [NSMutableDictionary dictionary];
//    [dictt setValue:[NSNumber numberWithInteger:mylevel] forKey:@"level"];
 
//     ;
}



@end
