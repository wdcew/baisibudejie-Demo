//
//  GDLoginRegisterView.m
//  百思不得姐
//
//  Created by 高冠东 on 7/15/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "GDLoginRegisterView.h"
#import "GDCustomButton.h"
@interface GDLoginRegisterView()
@end

@implementation GDLoginRegisterView
#pragma mark initialization method

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    /***Loginview的背景图片***/
        UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
        backgroundView.contentMode = UIViewContentModeScaleToFill;
        backgroundView.image = [UIImage imageNamed:@"login_register_background"];
        [self addSubview:backgroundView];
        
        //***添加登录，注册 界面的 View***/
          //1.添加 Main View
        UIView *registerView = [[UIView alloc] init];
        [self addSubview:registerView];
        self.registerView = registerView;
          //2.添加SignUpView
        [self addsignUp];
          //3.添加 SignInView
        [self addSignIn];
        
        /***添加快速登录方式的button***/
        [self addQuickLoginButton];
        /***添加其他button ***/
        [self addOtherButton];
        
        /***添加登录，注册 Main VIew 的 的约束***/
        [self registerConstraint];
        /***添加快速登录方式 Button 的约束***/
        [self loginButtonConstraint];
        
    }
    return self;
}


- (void)addsignUp
{
    
    //2.添加放置 singnUPTexeField的 View
    UIImageView *signUpView = [[UIImageView alloc] init];
    signUpView.image = [UIImage imageNamed:@"login_rgister_textfield_bg"];
    //很重要
    signUpView.userInteractionEnabled = YES;
    signUpView.contentMode = UIViewContentModeScaleToFill;
    [self.registerView addSubview:signUpView];
    self.signUpView = signUpView;
    
    //2.添加account Textfield
    GDLoginTextField *account = [[GDLoginTextField alloc] init];
    account.placeholder = @"账号";
    account.keyboardType = UIKeyboardTypeEmailAddress;
    [self.signUpView addSubview:account];
    self.account1 = account;
    
    //3.添加password TextField
    GDLoginTextField *password= [[GDLoginTextField alloc] init];
    password.placeholder = @"密码";
    password.secureTextEntry = YES;
    password.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [self.signUpView addSubview:password];
    self.password1 = password;
    
    //4.添加 确认登录 Button
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"login_register_button"] forState:UIControlStateNormal];
    [confirmButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.registerView addSubview:confirmButton];
    self.confirmButton = confirmButton;
    
    [self.confirmButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(account);
        make.height.equalTo(self.mas_height).multipliedBy(40.0 / 667);
        make.centerX.equalTo(signUpView.mas_centerX);
        make.bottom.equalTo(self.registerView.mas_bottom);
    }];
}

- (void)addSignIn
{
    
    //2.添加放置 singnUPTexeField的 View
    UIImageView *signInView = [[UIImageView alloc] init];
    signInView.image = [UIImage imageNamed:@"login_rgister_textfield_bg"];
    //很重要
    signInView.userInteractionEnabled = YES;
    signInView.contentMode = UIViewContentModeScaleToFill;
    [self.registerView addSubview:signInView];
    self.signInView = signInView;
    
    //2.添加account Textfield
    GDLoginTextField *account = [[GDLoginTextField alloc] init];
    account.placeholder = @"账号";
    account.keyboardType = UIKeyboardTypeEmailAddress;
    
    [self.signInView addSubview:account];
    self.account = account;
    
    //3.添加password Textfield
    GDLoginTextField *password= [[GDLoginTextField alloc] init];
    password.placeholder = @"密码";
    password.secureTextEntry = YES;
    password.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [self.signInView addSubview:password];
    self.password = password;
    
    //4.添加确认注册 Button
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"login_register_button"] forState:UIControlStateNormal];
    [confirmButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.registerView addSubview:confirmButton];
    
    [confirmButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.account);
        make.height.equalTo(self.mas_height).multipliedBy(40.0 / 667);
        make.centerX.equalTo(self.signInView.mas_centerX);
        make.bottom.equalTo(self.registerView.mas_bottom);
    }];
}

- (void)addOtherButton
{
    UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [dismissButton setImage:[UIImage imageNamed:@"login_close_icon"] forState:UIControlStateNormal];
    self.dismissButton = dismissButton;
    [self addSubview:dismissButton];
    
    [dismissButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(self.mas_top).offset(50);
    }];
    
    
    UIButton *switchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [switchButton setTitle:@"注册账号" forState:UIControlStateNormal];
    self.switchButton = switchButton;
    [self addSubview:switchButton];
    
    [switchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(- 10);
        make.top.equalTo(self.mas_top).offset(50);
    }];
}


- (void)addPromptLabel {
    UILabel *quick = [[UILabel alloc] init];
    quick.text = @"快速登录";
    [quick sizeToFit];
    quick.textColor = [UIColor whiteColor];
    [self addSubview:quick];
    
    [quick mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.wbButton.mas_top).offset(-15);
    }];
    
}

- (void)addQuickLoginButton
{
    /***添加其他登录方式的button***/
        GDCustomButton *wbButton = [GDCustomButton buttonWithType:UIButtonTypeCustom];
        [wbButton setImage:[UIImage imageNamed:@"login_sina_icon"] forState:UIControlStateNormal];
        [wbButton setImage:[UIImage imageNamed:@"login_sina_icon_click"] forState:UIControlStateHighlighted];
        [wbButton setTitle:@"微博" forState:UIControlStateNormal];
        [self addSubview:wbButton];
        self.wbButton = wbButton;
        
        GDCustomButton *qqButton = [GDCustomButton buttonWithType:UIButtonTypeCustom];
        [qqButton setImage:[UIImage imageNamed:@"login_QQ_icon"] forState:UIControlStateNormal];
        [qqButton setImage:[UIImage imageNamed:@"login_QQ_icon_click"] forState:UIControlStateHighlighted];
        [qqButton setTitle:@"QQ" forState:UIControlStateNormal];
        [self addSubview:qqButton];
        self.qqButton = qqButton;
        
        GDCustomButton *tencentButton = [GDCustomButton buttonWithType:UIButtonTypeCustom];
        [tencentButton setImage:[UIImage imageNamed:@"login_tecent_icon"] forState:UIControlStateNormal];
        [tencentButton setImage:[UIImage imageNamed:@"login_tecent_icon_click"] forState:UIControlStateHighlighted];
        [tencentButton setTitle:@"腾讯" forState:UIControlStateNormal];
        [self addSubview:tencentButton];
        self.tencentButton = tencentButton;
    
    /***添加 提示label***/
        [self addPromptLabel];
}

#pragma mark layoutMethod
+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}
//在此建立在APP 运行过程中会发生改变的 Constraints;
- (void)updateConstraints
{
    //移动registerView,以达到切换登录与注册界面的效果
    [self.registerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(- self.offset);
        make.top.equalTo(@160);
        make.height.equalTo(self.mas_height).multipliedBy((96.0 + 40 + 30) / 667);
        make.width.equalTo(self.mas_width).multipliedBy(2);
        
    }];
    
    
    [super updateConstraints];
}

- (void)registerConstraint
{
     [self.signInView mas_remakeConstraints:^(MASConstraintMaker *make) {
         make.centerX.mas_equalTo(self.registerView.mas_centerX).multipliedBy(0.5);
         make.top.equalTo(self.registerView.mas_top);
         make.width.equalTo(self.mas_width).multipliedBy(266.0 / 375);
         make.height.equalTo(self.mas_height).multipliedBy(96.0 / 667);
    }];
    [self.signUpView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.registerView.mas_centerX).multipliedBy(1.5);
         make.top.equalTo(self.registerView.mas_top);
         make.width.equalTo(self.mas_width).multipliedBy(266.0 / 375);
         make.height.equalTo(self.mas_height).multipliedBy(96.0 / 667);
    }];
    
    
    [self.account mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.signInView.mas_top);
        make.left.equalTo(self.signInView.mas_left);
        make.width.equalTo(self.signInView.mas_width);
        make.height.equalTo(self.signInView.mas_height).multipliedBy(0.5);
        
    }];
    [self.password mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.signInView.mas_bottom);
        make.left.equalTo(self.signInView.mas_left);
        make.width.equalTo(self.signInView.mas_width);
        make.height.equalTo(self.signInView.mas_height).multipliedBy(0.5);
       
    }];
    
    [self.account1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.signUpView.mas_top);
        make.left.equalTo(self.signUpView.mas_left);
        make.width.equalTo(self.signUpView.mas_width);
        make.height.equalTo(self.signUpView.mas_height).multipliedBy(0.5);
        
    }];
    [self.password1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.signUpView.mas_bottom);
        make.left.equalTo(self.signUpView.mas_left);
        make.width.equalTo(self.signUpView.mas_width);
        make.height.equalTo(self.signUpView.mas_height).multipliedBy(0.5);
       
    }];
}

- (void)loginButtonConstraint
{
    
    [self.wbButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom).with.offset(-20);
        make.width.equalTo(@(self.GD_width / 3));
        make.height.mas_equalTo(self.GD_width * 100/375);
        
    }];

    [self.qqButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.wbButton.mas_top);
        make.left.equalTo(self.wbButton.mas_right);
        make.width.equalTo(self.wbButton.mas_width);
        make.height.equalTo(self.wbButton.mas_height);
    }];
    
    [self.tencentButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.wbButton.mas_top);
        make.left.equalTo(self.qqButton.mas_right);
        make.width.equalTo(self.wbButton.mas_width);
        make.height.equalTo(self.wbButton.mas_height);
    }];
}
@end
