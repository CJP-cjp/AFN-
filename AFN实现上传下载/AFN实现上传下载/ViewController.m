//
//  ViewController.m
//  AFN实现上传下载
//
//  Created by mac on 16/9/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
@interface ViewController ()

@end

@implementation ViewController
-(IBAction)post:(id)sender
{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    NSDictionary *parameters = [NSDictionary dictionaryWithObject:@"机接口能 " forKey:@"status"];
    //parameters[@"status"] = @"机接口能 ";
    //status :服务器接收文本信息的字段
    //[parameters setValue:@"机接口能 " forKey:@"status"];
    
    [manger POST:@"http://127.0.0.1/php/upload/upload-m.php" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSString *filePath = [[NSBundle mainBundle]pathForResource:@"Default@2x.png" ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        //参数1：文件的二进制
        //
        [formData appendPartWithFileData:data name:@"userfile[]" fileName:@"yao.jpg" mimeType:@"image/jpg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%f",uploadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
-(IBAction)download:(id)sender
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager]
    ;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://127.0.0.1/php/upload/upload-m.php"]];
    [[manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%f",downloadProgress.fractionCompleted);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //targetPath :AFN默认的缓存文件路径，默认自动删除
        NSLog(@"%@",targetPath);
        //这个block是又返回值得 ,返回文件缓存的路径（带协议头）
        //带协议头
      //在这个回到里面，需要自己缓存文件
        NSString *filePath = @"/Users/mac/Desktop/123.zip";
        NSURL *urlPath = [NSURL fileURLWithPath:filePath];
        //把自己选着的缓存文件的路径，剪贴到completionHandler
        return  urlPath;
        
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        //compleHamdler 里面的filePath，是destination 中定义的
        NSLog(@"%@",filePath);
        
    }]resume ];
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
