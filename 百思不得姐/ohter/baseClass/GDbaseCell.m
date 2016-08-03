//
//  GDbaseCell.m
//  百思不得姐
//
//  Created by 高冠东 on 8/2/16.
//  Copyright © 2016 高冠东. All rights reserved.
//
static NSArray *formatTypes;
static NSDateFormatter *formatter;
static NSCalendar *calendar;

#import "GDbaseCell.h"
@implementation GDbaseCell

- (void)configurationForItem:(id)item;
{
    //什么也不做，交给子类进行覆写
}

- (void)ImageForView:(UIImageView *)imageView WithUrlStr:(NSString *)urlStr
{
    NSURL *url = [NSURL URLWithString:urlStr];
    [imageView sd_setImageWithURL:url placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            GDNSLog(@"cellType:%@,erroDoman:%@,errorCode:%ld",NSStringFromClass([self class]),error.domain,(long)error.code);
        }
    }];
}

- (void)translateDateForLabel:(UILabel *)label WithObject:(id)obj
{
    //对该静态obj进行初始化，只执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        calendar = [NSCalendar currentCalendar];
        formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        //str ->date 支持的格式
       formatTypes = @[@"yyyy-MM-dd HH:mm:ss",@"EEE MMM dd HH:mm:ss Z yyyy"];
    });
    
    //1.进行转化
    __block NSDate *date;
    if ([obj isKindOfClass:[NSDate class]]) { //若传入对象为date，不需转化;
        date = obj;
    } else { //obj为str, str ->date
        NSString *dateStr = obj;
        [formatTypes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            formatter.dateFormat = obj;
            date = [formatter dateFromString:dateStr];
            if (date) {
                *stop = YES;
            }
        }];
        NSAssert(date != nil, @"转化失败，请检查obj或 format 是否正确");
    }
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    //2.进行比较
        //获取date 的components
    NSDateComponents *cmps = [calendar components:unit  fromDate:date];
        //date与 current date 比较后的 components
    NSDateComponents *compareCpms = [calendar components:unit fromDate:date toDate:[NSDate date] options:0];
    
    NSString *strDate;
    if (compareCpms.year < 1) {//今年以内
        if ([calendar isDateInToday:date]) {//今天
            if (compareCpms.hour > 1) {//一个小时以后 今天 %ld:%ld:%ld
            strDate = [NSString stringWithFormat:@"今天 %.2ld:%.2ld",cmps.hour,cmps.minute];
            } else if (compareCpms.minute > 1) {//一分钟之后：%ld分钟前
                strDate = [NSString stringWithFormat:@"%ld分钟前",compareCpms.minute];
            } else { //一分钟 之前
                strDate  = [NSString stringWithFormat:@"刚刚"];
            }
                
        } else if([calendar isDateInYesterday:date]) { //昨天 %ld:%ld
            strDate = [NSString stringWithFormat:@"昨天 %.2ld:%.2ld",cmps.hour,cmps.minute];
        } else  {//其他情况  MM-DD HH:MM
            strDate = [NSString stringWithFormat:@"%.2ld-%.2ld %.2ld:%.2ld",cmps.month,cmps.day,cmps.hour,cmps.minute];
        }
    } else { // YYYY-MM-DD HH:MM:SS 今年以外
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat =@"yyyy-MM-dd HH:mm:ss";
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        strDate = [formatter stringFromDate:date];
    }
    
    //3.将转化后的 date显示在label中
    label.text = strDate;
//    GDNSLog(@"%@",strDate);
}

@end
