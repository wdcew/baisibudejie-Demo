//
//  GDTitleView.m
//  百思不得姐
//
//  Created by 高冠东 on 7/27/16.
//  Copyright © 2016 高冠东. All rights reserved.
//

#import "GDTitleView.h"
#define ButtonCount 5

@interface GDTitleView ()
@property (nonatomic, weak) UIView *indicatorView;
@property (nonatomic, weak) GDCustomButton *lastButton;
@property (nonatomic,strong) NSMutableArray<GDCustomButton *> *buttons;
//@property (nonatomic,
@end

@implementation GDTitleView
- (NSMutableArray *)butttons
{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
        [self SetupTitleButton];
        [self setupIndicatorView];
    }
    return self;
}

- (void)SetupTitleButton
{
    //创建相应的button
    [self createButtonWithTitle:@"全部" Tag:0];
    [self createButtonWithTitle:@"视频" Tag:1];
    [self createButtonWithTitle:@"声音" Tag:2];
    [self createButtonWithTitle:@"图片" Tag:3];
    [self createButtonWithTitle:@"文字" Tag:4];
    
}

- (void)setupIndicatorView
{
    
    //创建 indicatorView
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    //设置高度 和 Y
    CGFloat margin = 2;
    indicatorView.GD_height = 1;
    indicatorView.GD_y = self.GD_height - indicatorView.GD_height - margin;
    
    self.indicatorView  = indicatorView;
    [self addSubview:indicatorView];
}

- (void)createButtonWithTitle:(NSString *)title Tag:(NSUInteger)tag
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState: UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    button.titleLabel.contentMode = UIViewContentModeCenter;
    [button.titleLabel sizeToFit];
    
    //    [button addTarget:self action:@selector(adjustIndicatorView:) forControlEvents:UIControlEventTouchDown];
    button.tag = tag;
    [self.butttons addObject:button];
    
    //使用 interactive method 无法触发 disabled 状态，只有 enabled method 可以
    [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
    button.frame = CGRectMake(self.GD_width / ButtonCount * tag, 0, self.GD_width / ButtonCount, self.GD_height);
    [self addSubview:button];
}

- (void)adjustIndicatorView:(id)sender
{
    NSInteger index ;
    GDCustomButton *button;
    if ([sender isKindOfClass:[GDCustomButton class]]) {//传递的参数为button
        button = sender;
        index = button.tag;
    } else {//传递的参数为index
        index = [sender integerValue];
        button = self.butttons[index];
    }
    //方法一：通过计算 attributeString 的size，与 width 一致
    //    CGSize strSize = [button.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:button.titleLabel.font}];
    //    
    //    [UIView animateWithDuration:0.2 animations:^{
    //    self.indicatorView.GD_x =button.GD_width *index + button.titleLabel.GD_x + (button.titleLabel.GD_width - strSize.width) / 2;
    //    self.indicatorView.GD_width = strSize.width;
    //    }];
    
    //    方法二：width 与 uibutton的 label 一致(前提是 label 的 frame 与StrText的 frame 一致）
    [UIView animateWithDuration:0.2 animations:^{
        self.indicatorView.GD_x =button.GD_width *index + button.titleLabel.GD_x;
        self.indicatorView.GD_width = button.titleLabel.GD_width;
    }];
    
    if (button != self.lastButton) {
        button.enabled = NO;
        self.lastButton.enabled = YES;
        self.lastButton = button;
    };
}

- (void)addTarget:(id)target action:(SEL)selector forControlEvents:(UIControlEvents)event
{
    for (UIView *button in self.subviews) {
        if ([button isKindOfClass:[UIButton class]] ) {
            [(GDCustomButton *)button addTarget:target action:selector forControlEvents:event];
        }
    }
}


@end
