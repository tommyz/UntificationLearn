//
//  ViewController.m
//  com.hwabao.transaction
//
//  Created by Neo on 2016/12/9.
//  Copyright © 2016年 ToukerApp. All rights reserved.
//

#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)local:(UIButton *)sender {
    [self timeLoaclWithGif];
}
-(void)timeLoaclWithImage{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"\"Fly to the moon\"";
    content.subtitle = @"by Neo";
    content.body = @"the wonderful song with you~🌑";
    content.badge = @0;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"image1" ofType:@"png"];
    NSError *error = nil;
    UNNotificationAttachment *img_attachment = [UNNotificationAttachment attachmentWithIdentifier:@"att1" URL:[NSURL fileURLWithPath:path] options:nil error:&error];
    if (error) {
        NSLog(@"%@", error);
    }
    content.attachments = @[img_attachment];
    //设置为@""以后，进入app将没有启动页
    content.launchImageName = @"";
    UNNotificationSound *sound = [UNNotificationSound defaultSound];
    content.sound = sound;
    
    UNTimeIntervalNotificationTrigger *time_trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
    NSString *requestIdentifer = @"time interval request";
    content.categoryIdentifier = @"seeCategory1";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifer content:content trigger:time_trigger];
    
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"%@",error);
    }];
}
-(void)timeLoaclWithGif{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:@"http://ww3.sinaimg.cn/large/006y8lVagw1faknzht671g30b408c1l2.gif"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"tmp/%@att.%@",@([NSDate date].timeIntervalSince1970),@"gif"]];
            NSError *err = nil;
            [data writeToFile:path atomically:YES];
            UNNotificationAttachment *gif_attachment = [UNNotificationAttachment attachmentWithIdentifier:@"attachment" URL:[NSURL fileURLWithPath:path] options:@{UNNotificationAttachmentOptionsThumbnailClippingRectKey:[NSValue valueWithCGRect:CGRectMake(0, 0, 1, 1)]} error:&err];
            UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
            content.title = @"\"Fly to the moon\"";
            content.subtitle = @"by Neo";
            content.body = @"the wonderful song with you~🌑";
            content.badge = @0;
            NSError *error = nil;
            if (gif_attachment) {
                content.attachments = @[gif_attachment];
            }
            if (error) {
                NSLog(@"%@", error);
            }
            //设置为@""以后，进入app将没有启动页
            content.launchImageName = @"";
            UNNotificationSound *sound = [UNNotificationSound defaultSound];
            content.sound = sound;
            
            UNTimeIntervalNotificationTrigger *time_trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1 repeats:NO];
            NSString *requestIdentifer = @"time interval request";
            content.categoryIdentifier = @"seeCategory1";
            UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifer content:content trigger:time_trigger];
            [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
                NSLog(@"%@",error);
            }];
        }
    }];
    [task resume];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
