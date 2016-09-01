//
//  ViewController.m
//  AFN使用注意点
//
//  Created by mac on 16/9/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[self loadHTML];
    [self postJSon];
}
#pragma mark - ANF的反序列化
/*1.AFN 默认支持JSON数据
 解决：可以设置AFN，让AFN可以接受多一点的文件类型
 2.AFN默认把所有的数据都当做JSON来解析
 解决，
 3.如果只需要加载简单的网络数据，使用NSURLSession能加载更快，简单如html 
 如果需要加载JSON数据，建议使用AFN，因为AFN默认会对JSON进行反序列化，
 */
-(void)loadHTML
{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manger GET:@"http://www.baidu.com" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@--%@",[responseObject class],responseObject);
        NSString *htmlStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",htmlStr);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark - AFN的序列化
//AFN默认只支持向服务器发送普通的二进制数据；（JSON、XML.HTML 格式的二进制数据，AFN觉得不普通，以上数据的二进制AFN不支持
//解决办法：告诉AFN，让AFN支持JSON数据额发送
-(void)postJSon
{
    //plain
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/plain", nil];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    //manger.responseSerializer = [];
   // manger.requestSerializer =[AFHTTPRequestSerializer serializer];
    //告诉AFN，要发送JSON格式的二进制数据，你帮搞一下
    manger.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *jsonDict = [NSDictionary dictionaryWithObject:@"zan" forKey:@"name"];
//    [manger POST:@"http://localhost/php/upload/postjson.php" parameters:jsonDict constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//         //NSLog(@"%@--%@",[responseObject class],responseObject);
//        NSString *htmlStr = [[NSString alloc]initWithData:responseObject
//    encoding:NSUTF8StringEncoding];
//        NSLog(@"%@",htmlStr);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
//    }];
    [manger POST:@"http://localhost/php/upload/postjson.php" parameters:jsonDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *htmlStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",htmlStr);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
