//
//  GDLoginRegisterViewController.m
//  百思不得姐
//
//  Created by 高冠东 on 7/15/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "GDLoginRegisterViewController.h"
#import "GDLoginRegisterView.h"
#import "GDLoginTextField.h"
@interface GDLoginRegisterViewController()<UITextFieldDelegate>
@property (nonatomic, strong) GDLoginRegisterView *rootView;
@property (nonatomic,weak)GDLoginTextField *responderField;

@end

@implementation GDLoginRegisterViewController

-(void)loadView
{
    [super loadView];
    
    self.rootView = [[GDLoginRegisterView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view = self.rootView;
    
    
}

#pragma mark setup method
- (void)viewDidLoad
{
    [self setUp];
}

//将StatusBar 设为高亮
- (UIStatusBarStyle)preferredStatusBarStyle
{
    
    return UIStatusBarStyleLightContent;
}

- (void)setUp
{
    self.rootView.account.delegate = self;
    self.rootView.password.delegate = self;
    
    //设置切换注册 BUtton 和关闭loginRegisterController
    [self.rootView.dismissButton addTarget:self action:@selector(dismissController:) forControlEvents:UIControlEventTouchDown];
    [self.rootView.switchButton addTarget:self action:@selector(switchInterface:) forControlEvents:UIControlEventTouchDown];
}

#pragma mark TexetField Delegate


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.responderField = (GDLoginTextField *)textField;
}

// called when 'return' key pressed.
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.responderField resignFirstResponder];
    
    return NO;
}

#pragma mark target-action method
- (void)dismissController:(UIButton *)sender
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)switchInterface:(UIButton *)sender
{
    
    /***以下代码主要使用constraint 切换登录TextField 与 注册 TextField***/
    static int flag= 0;
    if (0 == flag) {
        //偏移一个屏幕的宽度,以便显示 注册界面
        self.rootView.offset = self.view.GD_width;
        flag = 1;
    } else {
        //切换到 登录界面
        self.rootView.offset = 0;
        flag = 0;
    }
    
    //以下3个方法 必须都有，才会有 调整constrains的动画
    [self.rootView setNeedsUpdateConstraints];

    // update constraints now so we can animate the change
    [self.rootView updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.25 animations:^{
    // tell constraints they need updating
        
        [self.rootView.registerView layoutIfNeeded];
    }];
  
    NSLog(@"%@",NSStringFromCGRect(self.rootView.registerView.frame));
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //当点击 除了 Button ，TextField 以外的 View 时，Textfield 放弃成为 first responder.
    [self.responderField resignFirstResponder];
}

@end
