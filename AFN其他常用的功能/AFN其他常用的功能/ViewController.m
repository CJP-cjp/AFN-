//
//  ViewController.m
//  AFN其他常用的功能
//
//  Created by mac on 16/9/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
@interface ViewController ()

@end

@implementation ViewController
-(IBAction)baseURL:(id)sender
{
//提示：相对路径后面的'/',建议带上
    NSURL *baseURL = [NSURL URLWithString:@"http://localhost/"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithBaseURL:baseURL];
    [manager GET:@"demo.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@-%@",[responseObject class],responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
-(IBAction)HTTPS:(id)sender
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //不做域名的验证
    manager.securityPolicy.validatesDomainName = NO;
    //增加AFN支持的文本类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/plain", nil];
    //告诉AFN返回原始的二进制数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

        [manager GET:@"http://mail.qq.com" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           NSLog(@"%@-%@",[responseObject class],responseObject);
            NSString *htmlStr = [[NSString alloc]initWithData:responseObject
                                                     encoding:NSUTF8StringEncoding];
            NSLog(@"%@",htmlStr);

            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"%@",error);
        }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
