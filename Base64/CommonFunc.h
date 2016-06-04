//
//  CommonFunc.h
//  Base64
//
//  Created by 周德艺 on 15/7/27.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonFunc : NSObject

+ (NSString *)encryptWithText:(NSString *)sText;//加密
+ (NSString *)decryptWithText:(NSString *)sText;//解密

@end
