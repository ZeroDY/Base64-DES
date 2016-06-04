//
//  ViewController.m
//  Base64
//
//  Created by 周德艺 on 15/7/27.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import "ViewController.h"
#import "CommonFunc.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *str1 = @"q12344444444444444444444444444444444444k";//AWhdCwTZLyaRDt6Er8mbWQ==
    NSLog(@"解密=========%@",[CommonFunc decryptWithText:@"GSTgig0ueNheMcXaPZTvEV4xxdo9lO8RXjHF2j2U7xFbrraIgprLzUoQ4SOIL9DH"]);
    NSLog(@"加密========%@",[CommonFunc encryptWithText:str1]);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
