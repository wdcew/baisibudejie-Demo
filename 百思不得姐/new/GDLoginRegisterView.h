//
//  GDLoginRegisterView.h
//  百思不得姐
//
//  Created by 高冠东 on 7/15/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDLoginTextField.h"
@interface GDLoginRegisterView : UIView

@property (nonatomic,weak)MASConstraint *constraint;
@property (nonatomic, weak)UIView *registerView;
@property (nonatomic,assign)float offset;


//***快速登录按钮***/
@property (nonatomic, weak)UIButton *wbButton;
@property (nonatomic, weak)UIButton *qqButton;
@property (nonatomic, weak)UIButton *tencentButton;

//***登录，注册 Textfie的相关属性***/
@property (nonatomic, weak)GDLoginTextField *account;
@property (nonatomic, weak)GDLoginTextField *password;

@property (nonatomic, weak)GDLoginTextField *account1;
@property (nonatomic, weak)GDLoginTextField *password1;

@property (nonatomic, weak)UIImageView *signUpView;
@property (nonatomic, weak)UIImageView *signInView;
@property (nonatomic, weak)UIButton *confirmButton;
//***其他按钮***/
@property (nonatomic, weak)UIButton *dismissButton;
@property (nonatomic, weak)UIButton *switchButton;
@end
