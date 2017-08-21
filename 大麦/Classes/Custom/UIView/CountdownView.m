//
//  CountdownView.m
//  大麦
//
//  Created by 洪欣 on 17/1/14.
//  Copyright © 2017年 洪欣. All rights reserved.
//

#import "CountdownView.h"

@interface CountdownView ()
{
    dispatch_source_t _timer;
}
@property (weak, nonatomic) UILabel *hoursLb;
@property (weak, nonatomic) UILabel *minutesLb;
@property (weak, nonatomic) UILabel *secondsLb;
@property (weak, nonatomic) UILabel *intervalOLb;
@property (weak, nonatomic) UILabel *intervalTLb;
@end

@implementation CountdownView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (UILabel *)timeLb
{
    UILabel *timeLb = [[UILabel alloc] init];
    timeLb.textColor = [UIColor blackColor];
    timeLb.font = [UIFont boldSystemFontOfSize:17];
    timeLb.textAlignment = NSTextAlignmentCenter;
    timeLb.layer.masksToBounds = YES;
    timeLb.layer.cornerRadius = 1;
    timeLb.layer.borderColor = [UIColor colorWithHexString:@"#999999"].CGColor;
    timeLb.layer.borderWidth = 0.5f;
    timeLb.width = 27;
    timeLb.height = 27;
    return timeLb;
}

- (UILabel *)label
{
    UILabel *label = [[UILabel alloc] init];
    label.text = @":";
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:17];
    label.width = 15;
    label.height = 27;
    return label;
}

- (void)setup
{
    UILabel *titleLb = [[UILabel alloc] init];
    titleLb.text = @"距离开始时间";
    titleLb.textColor = [UIColor colorWithHexString:@"#777777"];
    titleLb.font = [UIFont systemFontOfSize:12];
    titleLb.height = 13;
    titleLb.width = [titleLb getTextWidth];
    titleLb.x = 0;
    titleLb.y = 0;
    [self addSubview:titleLb];
    
    UILabel *hoursLb = [self timeLb];
    hoursLb.x = 0;
    hoursLb.y = CGRectGetMaxY(titleLb.frame) + 10;
    [self addSubview:hoursLb];
    self.hoursLb = hoursLb;
    
    UILabel *intervalOLb = [self label];
    intervalOLb.x = CGRectGetMaxX(hoursLb.frame);
    intervalOLb.y = hoursLb.y;
    [self addSubview:intervalOLb];
    self.intervalOLb = intervalOLb;
    
    UILabel *minutesLb = [self timeLb];
    minutesLb.x = CGRectGetMaxX(intervalOLb.frame);
    minutesLb.y = hoursLb.y;
    [self addSubview:minutesLb];
    self.minutesLb = minutesLb;
    
    UILabel *intervalTLb = [self label];
    intervalTLb.x = CGRectGetMaxX(minutesLb.frame);
    intervalTLb.y = hoursLb.y;
    [self addSubview:intervalTLb];
    self.intervalTLb = intervalTLb;
    
    UILabel *secondsLb = [self timeLb];
    secondsLb.x = CGRectGetMaxX(intervalTLb.frame);
    secondsLb.y = hoursLb.y;
    [self addSubview:secondsLb];
    self.secondsLb = secondsLb;
}

- (void)setTimeStr:(NSString *)timeStr
{
    _timeStr = timeStr;
    _timer = nil;
    [self startTimer];
}

- (void)startTimer
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *endDate_tomorrow = [dateFormatter dateFromString:self.timeStr];
    NSDate *startDate = [NSDate date];
    NSTimeInterval timeInterval =[endDate_tomorrow timeIntervalSinceDate:startDate];
    
    if (_timer==nil) {
        __block int timeout = timeInterval; //倒计时时间
        
        if (timeout!=0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    _timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.hoursLb.text = @"00";
                        self.minutesLb.text = @"00";
                        self.secondsLb.text = @"00";
                        if ([self.delegate respondsToSelector:@selector(countdownComplete)]) {
                            [self.delegate countdownComplete];
                        }
                    });
                }else{
                    int hours = (int)(timeout/3600);
                    int minute = (int)(timeout-hours*3600)/60;
                    int second = timeout-hours*3600-minute*60;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (hours<10) {
                            self.hoursLb.text = [NSString stringWithFormat:@"0%d",hours];
                        }else{
                            self.hoursLb.text = [NSString stringWithFormat:@"%d",hours];
                        }
                        if (minute<10) {
                            self.minutesLb.text = [NSString stringWithFormat:@"0%d",minute];
                        }else{
                            self.minutesLb.text = [NSString stringWithFormat:@"%d",minute];
                        }
                        if (second<10) {
                            self.secondsLb.text = [NSString stringWithFormat:@"0%d",second];
                        }else{
                            self.secondsLb.text = [NSString stringWithFormat:@"%d",second];
                        }
                        
                    });
                    timeout--;
                }
            });
            dispatch_resume(_timer);
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.height = CGRectGetMaxY(self.hoursLb.frame);
}

@end
