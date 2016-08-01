//
//  GDLoginTextField.m
//  百思不得姐
//
//  Created by 高冠东 on 7/18/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "GDLoginTextField.h"
#import <objc/runtime.h>

//通过runtime时，textField中对应 palceHolder的properpty,故使用 KVC 方法

static NSString * const PlaceholderColorKey = @"placeholderLabel.textColor";

@implementation GDLoginTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    self = [super init];
    if (self) {
        //设置光标颜色
        self.tintColor = [UIColor whiteColor];
        //设置字体颜色
        self.textColor = [UIColor whiteColor];
        self.textAlignment = NSTextAlignmentCenter;
        //必须设置为 None,否则无法使用背景图片
        self.borderStyle = UITextBorderStyleNone;
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.spellCheckingType = NO;
        //是否自动大写
        self.adjustsFontSizeToFitWidth = YES;
        self.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.autocorrectionType = UITextAutocorrectionTypeNo;
        self.keyboardAppearance = UIKeyboardAppearanceDark;
        
//        self.placeholder = @" ";
        [self changePlaceHolderColor];
//        [self setPlaceHolderStr];
        
    }
    return self;
}

/*
 *  通过监视 TextField 编辑状态（即开始编辑，或退出编辑），进而改变占位字体的颜色
 *  可通过三种方法进行监视：delegate  targe-action  notification
 */

 /***notification的方法***/
- (void)changePlaceHolderColor
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    /**
     *  addobserverBlock method 相关参数说明
     *
     *  @param Name： 观察 行为的类型
     *  @param Object：发生行为的对象，即仅该对象 发生 相关类型，才会执行该方法传递的block对象
     *  @param queue: 队列
     *  @param Block： 块对象
     *  即仅该对象（object) 发生 相关类型，才会执行该方法传递的block对象
     */
    [center addObserverForName:UITextFieldTextDidBeginEditingNotification object:self queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        //设置占位字 颜色为白色
    UILabel *label = [self valueForKeyPath:@"placeholderLabel"];
        label.textColor = GDColorA(219, 219, 219, 0.5);
    }];
 
    
    /**
     *  addobserverBlock method 相关参数说明
     *  @param observer:观察者
     *  @param selector:观察者执行的方法
     *  @param Name： 观察 行为的类型
     *  @param Object：发生行为的对象，即仅该对象 发生 相关类型，才会执行该方法传递的block对象
     *  即仅该对象（object) 发生 相关类型，会执行观察者的 SEL 方法；
     */
    [center addObserver:self selector:@selector(grayColor) name:UITextFieldTextDidEndEditingNotification object:self];
}

- (void)grayColor
{
    //设置占位字 颜色为灰色

    UILabel *label = [self valueForKeyPath:@"placeholderLabel"];
    label.textColor = [UIColor colorWithRed:0 green:0 blue:0.098 alpha:0.22];

}

- (void)dealloc
{
    //一定要手动移除观察者（释放内存）
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/** 设置Placeholder 方法一： 覆写 drawRect:(CGRect)rect method
 *  该方法相当于DrawRect，可以获得 Placeholder(内部含有一个 label)的 context
 *
 *  @param rect Placeholder在该 Filed 的位置
 */
//- (void)drawRect:(CGRect)rect
//{
//    //将 self。placheholder(string) ，通过Attributes的配置，会知道到当前上下文中，以达到修改 Placeholder 文字的颜色，样式等等效果
//    //    [self.placeholder drawInRect:rect withAttributes: nil];
//    
//}
//方法二：使用runtime,找出 Placeholder label property，在使用KVC 进行配置

- (void)setPlaceHolderStr
{
    
    unsigned int count;
    //获取该类运行时，相关的property
    Ivar *ivarList = class_copyIvarList([UITextField class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
   //通过打印可知
        NSLog(@"%s", ivar_getName(ivar));
    }
    //因为是 C语言，进行释放
    
    UILabel *label = [self valueForKeyPath:@"placeholderLabel"];
    label.textColor = [UIColor whiteColor];

}

//方法三：载入视图后，在获取label
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        UILabel *label = self.subviews.lastObject;
//        label.textColor = [UIColor whiteColor];
//    });
@end
