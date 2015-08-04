//
//  MXLoginViewController.m
//  MenXin
//
//  Created by Alvin on 14-8-27.
//  Copyright (c) 2014年 ___MENGTONG___. All rights reserved.
//

#import "MXLoginAndRegisterViewController.h"
#import "ZFModalTransitionAnimator.h"
#import "MXRegisterViewController.h"
#import "MXLoginViewController.h"
#import "RecordAudio.h"
#import <pop/POP.h>
#import "YLImageView.h"
#import "YLGIFImage.h"
@interface MXLoginAndRegisterViewController ()<ZFModalTransitionAnimatorDelegate,RecordAudioDelegate>
{
    YLImageView *_companyNameView;
    UIButton *_registerBtn;
    UIButton *_loginBtn;
    YLImageView *_logoImageView;
    BOOL isNotFirstLoad;
}
@property (nonatomic, strong) ZFModalTransitionAnimator *animator;
@end

@implementation MXLoginAndRegisterViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)dealloc
{
    [_logoImageView.layer removeAllAnimations];
    _logoImageView.animatedImage=nil;
    self.animator=nil;
}
- (void)changeSkin:(NSNotification *)notification
{
//    _companyNameView.image=[MXUtils getImageWithName:landing_name_word];
//    _logoImageView.image=[MXUtils getImageWithName:landing_name_normal];
    [_registerBtn setBackgroundImage:[MXUtils getImageWithName:landing_enrol_normal] forState:UIControlStateNormal];
    [_registerBtn setBackgroundImage:[MXUtils getImageWithName:landing_enrol_highlight] forState:UIControlStateHighlighted];
    [_loginBtn setBackgroundImage:[MXUtils getImageWithName:landing_land_normal] forState:UIControlStateNormal];
    [_loginBtn setBackgroundImage:[MXUtils getImageWithName:landing_land_highlight] forState:UIControlStateHighlighted];
}
- (void)registerBtnAction
{
    //test
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
//    NSString *docDir = [paths objectAtIndex:0];
//    [[RecordAudio shareInstance] play:[NSString stringWithFormat:@"%@/music.amr",docDir]];
//    return;
    _loginBtn.userInteractionEnabled=NO;
    _registerBtn.userInteractionEnabled=NO;
    //模态话出一个控制器
    MXRegisterViewController *modalVC = [[MXRegisterViewController alloc] init];
    modalVC.modalPresentationStyle = UIModalPresentationCustom;
    [self transitionViewController:modalVC];
}
- (void)loginBtnAction
{
    //模态话出一个控制器
    _loginBtn.userInteractionEnabled=NO;
    _registerBtn.userInteractionEnabled=NO;
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    MXLoginViewController *modalVC = [storyboard instantiateViewControllerWithIdentifier:@"MXLoginViewController"];
    MXLoginViewController *modalVC = [[MXLoginViewController alloc]init];
    modalVC.modalPresentationStyle = UIModalPresentationCustom;
    [self transitionViewController:modalVC];
}
- (void)transitionViewController:(UIViewController *)modalVC
{
    // Pop Animation
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:NO] forKey:@"ZFModalTransitionAnimatorCloseKey"];
    POPSpringAnimation *logoImageSpr = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    logoImageSpr.toValue = @(46);
    logoImageSpr.springBounciness = 5;
    logoImageSpr.springSpeed = 2;
    POPBasicAnimation *logoImageBas = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    logoImageBas.toValue = [NSValue valueWithCGSize:CGSizeMake(0.8, 0.8)];
    [_logoImageView.layer pop_addAnimation:logoImageSpr forKey:nil];
    [_logoImageView pop_addAnimation:logoImageBas forKey:nil];
   // Present ViewController
    ZFModalTransitionAnimator *animator = [[ZFModalTransitionAnimator alloc] initWithModalViewController:modalVC];
    animator.delegate=self;
    animator.dragable = YES;
    animator.bounces = NO;
    animator.behindViewAlpha = 0.5f;
    animator.behindViewScale = 0.84375f;
    animator.direction = ZFModalTransitonDirectionBottom;
    modalVC.transitioningDelegate =animator;
    self.animator=animator;
    [self presentViewController:modalVC animated:YES completion:nil];
}
- (void)showLogo
{
    _logoImageView.alpha = 0;
    CGPoint point = _logoImageView.center;
    point.y +=100;
    _logoImageView.center = point;
    POPSpringAnimation *logoAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    logoAnim.beginTime = CACurrentMediaTime() +0.5;
    logoAnim.fromValue = @(_logoImageView.center.y);
    logoAnim.toValue = @(_logoImageView.center.y-100);
    logoAnim.springBounciness = 5;
    logoAnim.springSpeed = 1;
    POPBasicAnimation *baseAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    baseAnim.beginTime = CACurrentMediaTime() +0.5;
    baseAnim.fromValue = @(0);
    baseAnim.toValue = @(1);
    [_logoImageView pop_addAnimation:baseAnim forKey:nil];
    [_logoImageView.layer pop_addAnimation:logoAnim forKey:nil];
    
    _companyNameView.alpha =  0;
    CGPoint logoTitleCenter = _companyNameView.center;
    logoTitleCenter.y += 100;
    _companyNameView.center = logoTitleCenter;
    POPSpringAnimation *logoTitleSpr = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    logoTitleSpr.beginTime = CACurrentMediaTime() +0.6;
    logoTitleSpr.fromValue = @(_companyNameView.center.y);
    logoTitleSpr.toValue = @(_companyNameView.center.y-100);
    logoTitleSpr.springBounciness = 5;
    logoTitleSpr.springSpeed = 1;
    
    POPBasicAnimation *logoTitleBas = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    logoTitleBas.beginTime = CACurrentMediaTime() +0.6;
    logoTitleBas.fromValue = @(0);
    logoTitleBas.toValue = @(1);
    [_companyNameView pop_addAnimation:logoTitleBas forKey:nil];
    [_companyNameView.layer pop_addAnimation:logoTitleSpr forKey:nil];
    
    point = _registerBtn.center;
    point.y +=100;
    _registerBtn.center = point;
    POPSpringAnimation *registerBtnAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    registerBtnAnim.beginTime = CACurrentMediaTime() +1.1;
    registerBtnAnim.fromValue = @(_registerBtn.center.y);
    registerBtnAnim.toValue = @(_registerBtn.center.y-100);
    registerBtnAnim.springBounciness = 5;
    registerBtnAnim.springSpeed = 1;
    
    POPBasicAnimation *registerBas = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    registerBas.beginTime = CACurrentMediaTime() +1.1;
    registerBas.fromValue = @(0);
    registerBas.toValue = @(1);
    [_registerBtn pop_addAnimation:registerBas forKey:nil];
    [_registerBtn.layer pop_addAnimation:registerBtnAnim forKey:nil];
    
    point = _loginBtn.center;
    point.y +=100;
    _loginBtn.center = point;
    POPSpringAnimation *loginBtnAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    loginBtnAnim.beginTime = CACurrentMediaTime() +1.3;
    loginBtnAnim.fromValue = @(_loginBtn.center.y);
    loginBtnAnim.toValue = @(_loginBtn.center.y-100);
    loginBtnAnim.springBounciness = 5;
    loginBtnAnim.springSpeed = 1;
    POPBasicAnimation *loginBas = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    loginBas.beginTime = CACurrentMediaTime() +1.3;
    loginBas.fromValue = @(0);
    loginBas.toValue = @(1);
    [_loginBtn pop_addAnimation:loginBas forKey:nil];
    [_loginBtn.layer pop_addAnimation:loginBtnAnim forKey:nil];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavBarHidden:YES];
    self.view.backgroundColor=[UIColor whiteColor];
    //logo
    YLImageView *logoImageView=[[YLImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-236/2)/2.0,0,236/2,628/2.0)];
    [self.view addSubview:logoImageView];
    _logoImageView=logoImageView;
    //logoTitle
//    FLAnimatedImageView *companyNameView=[[FLAnimatedImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-58)/2,CGRectGetMaxY(logoImageView.frame)+44,58,27)];
//    companyNameView.image=[MXUtils getImageWithName:landing_name_word];
//    _companyNameView=companyNameView;
//    [self.view addSubview:companyNameView];
    // registerButton
    _registerBtn=[[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-230)/2,SCREEN_HEIGHT-108,230, 60)];
    [_registerBtn setBackgroundImage:[MXUtils getImageWithName:landing_enrol_normal] forState:UIControlStateNormal];
    [_registerBtn setBackgroundImage:[MXUtils getImageWithName:landing_enrol_highlight] forState:UIControlStateHighlighted];
    [_registerBtn addTarget:self action:@selector(registerBtnAction) forControlEvents:UIControlEventTouchUpInside];
    _registerBtn.alpha = 0;
    _registerBtn.userInteractionEnabled=YES;
    [self.view addSubview:_registerBtn];
    
    // loginButton
    _loginBtn=[[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-260)/2,SCREEN_HEIGHT-70,260,70)];
    [_loginBtn setBackgroundImage:[MXUtils getImageWithName:landing_land_normal] forState:UIControlStateNormal];
    [_loginBtn setBackgroundImage:[MXUtils getImageWithName:landing_land_highlight] forState:UIControlStateHighlighted];
    [_loginBtn addTarget:self action:@selector(loginBtnAction) forControlEvents:UIControlEventTouchUpInside];
    _loginBtn.alpha = YES;
    [self.view addSubview:_loginBtn];
    [self showLogo];
//    
//    [self performSelector:@selector(setButtonActive) withObject:nil afterDelay:((YLGIFImage*)[YLGIFImage imageNamed:@"companyMove.gif"]).totalDuration];
//
//    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
//    UILongPressGestureRecognizer *longPress=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(LongPressAction:)];
//    view.backgroundColor=[UIColor redColor];
//    [view addGestureRecognizer:longPress];
//    [self.view addSubview:view];
    
    // Do any additional setup after loading the view.
}
- (void)imageAnmoin
{
    _logoImageView.image=[YLGIFImage imageNamed:@"companyMove.gif"];
    _logoImageView.loopCountdown=1;
    [self performSelector:@selector(setButtonActive) withObject:nil afterDelay:((YLGIFImage*)[YLGIFImage imageNamed:@"companyMove.gif"]).totalDuration];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!isNotFirstLoad) {
        [self performSelector:@selector(imageAnmoin) withObject:nil afterDelay:0.4];
        isNotFirstLoad=YES;
    }
}
- (void)setButtonActive
{
//    _registerBtn.userInteractionEnabled=YES;
//    _loginBtn.userInteractionEnabled=YES;
    [_logoImageView stopAnimating];
}
- (void)LongPressAction:(UILongPressGestureRecognizer*)longPress
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *docDir = [paths objectAtIndex:0];
    if (longPress.state==UIGestureRecognizerStateBegan) {
        [[RecordAudio shareInstance] setDelegate:self];
        [[RecordAudio shareInstance] startRecord:[NSString stringWithFormat:@"%@/music.amr",docDir]];
    }
    if (longPress.state==UIGestureRecognizerStateEnded) {
        [[RecordAudio shareInstance] stopRecord];
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self setNeedsStatusBarAppearanceUpdate];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// ZFModalTransitionAnimator delegate
-(void)viewControllerDidDismiss
{
    _loginBtn.userInteractionEnabled=YES;
    _registerBtn.userInteractionEnabled=YES;
    [[UIApplication  sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [_logoImageView stopAnimating];
    POPSpringAnimation *logoImageSpr = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    logoImageSpr.toValue = @(160);
    logoImageSpr.springBounciness = 10;
    logoImageSpr.springSpeed = 5;
    POPBasicAnimation *logoImageBas = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    logoImageBas.toValue = [NSValue valueWithCGSize:CGSizeMake(1.0, 1.0)];
    [_logoImageView.layer pop_addAnimation:logoImageSpr forKey:nil];
    [_logoImageView pop_addAnimation:logoImageBas forKey:nil];
    
}
-(void)recordSuccess:(NSData *)data
{
    [[RecordAudio shareInstance] playWithData:data];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
