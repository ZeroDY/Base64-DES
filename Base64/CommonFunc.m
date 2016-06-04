//
//  CommonFunc.m
//  Base64
//
//  Created by 周德艺 on 15/7/27.
//  Copyright (c) 2015年 周德艺. All rights reserved.
//

#import "CommonFunc.h"
#import <CommonCrypto/CommonCryptor.h>

#import "GTMBase64.h"

static NSString *key = @"wang!@#$";

@implementation CommonFunc

+ (NSString *)encryptWithText:(NSString *)sText
{
    //kCCEncrypt 加密
    return [self encrypt:sText encryptOrDecrypt:kCCEncrypt key:key];
}

+ (NSString *)decryptWithText:(NSString *)sText
{
    //kCCDecrypt 解密
    return [self encrypt:sText encryptOrDecrypt:kCCDecrypt key:key];
}

+ (NSString *)encrypt:(NSString *)sText encryptOrDecrypt:(CCOperation)encryptOperation key:(NSString *)key
{
    
    
    const void *dataIn;
    size_t dataInLength;
    
    if (encryptOperation == kCCDecrypt)//传递过来的是decrypt 解码
    {
        //解码 base64
        NSData *decryptData = [GTMBase64 decodeData:[sText dataUsingEncoding:NSUTF8StringEncoding]];//转成utf-8并decode
        dataInLength = [decryptData length];
        dataIn = [decryptData bytes];
    }
    else  //encrypt
    {
        NSData* encryptData = [sText dataUsingEncoding:NSUTF8StringEncoding];
        dataInLength = [encryptData length];
        dataIn = (const void *)[encryptData bytes];
    }
    
    /*
     DES加密 ：用CCCrypt函数加密一下，然后用base64编码下，传过去
     DES解密 ：把收到的数据根据base64，decode一下，然后再用CCCrypt函数解密，得到原本的数据
     */
    CCCryptorStatus ccStatus;
    uint8_t *dataOut = NULL; //可以理解位type/typedef 的缩写（有效的维护了代码，比如：一个人用int，一个人用long。最好用typedef来定义）
    size_t dataOutAvailable = 0; //size_t  是操作符sizeof返回的结果类型
    size_t dataOutMoved = 0;
    
    dataOutAvailable = (dataInLength + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    dataOut = malloc( dataOutAvailable * sizeof(uint8_t));
    memset((void *)dataOut, 0x0, dataOutAvailable);//将已开辟内存空间buffer的首 1 个字节的值设为值 0
    
    NSString *initIv = @"12345678";
    const void *vkey = (const void *) [key UTF8String];
    const void *iv = (const void *) [initIv UTF8String];
    
    NSLog(@"+++++++++%ld",dataInLength);
    //CCCrypt函数 加密/解密
    ccStatus = CCCrypt(encryptOperation,//  加密/解密
                       kCCAlgorithmDES,//  加密根据哪个标准（des，3des，aes。。。。）
                       kCCOptionPKCS7Padding|kCCOptionECBMode,//  选项分组密码算法(des:对每块分组加一次密  3DES：对每块分组加三个不同的密)
                       vkey,  //密钥    加密和解密的密钥必须一致
                       kCCKeySizeDES,//   DES 密钥的大小（kCCKeySizeDES=8）
                       nil, //  可选的初始矢量
                       dataIn, // 数据的存储单元
                       dataInLength,// 数据的大小
                       (void *)dataOut,// 用于返回数据
                       dataOutAvailable,
                       &dataOutMoved);
    
    NSString *result = nil;
    
    if (encryptOperation == kCCDecrypt)//encryptOperation==1  解码
    {
        //得到解密出来的data数据，改变为utf-8的字符串
        result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)dataOut length:(NSUInteger)dataOutMoved] encoding:NSUTF8StringEncoding];
    }
    else //encryptOperation==0  （加密过程中，把加好密的数据转成base64的）
    {
        //编码 base64
        NSData *data = [NSData dataWithBytes:(const void *)dataOut length:(NSUInteger)dataOutMoved];
        
        NSString *str =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"data+++++++++=%@",data);
         NSLog(@"data==========%@",str);
        result = [GTMBase64 stringByEncodingData:data];
    }
    
    return result;
}


//
//+ (NSString *)encrypt:(NSString *)sText encryptOrDecrypt:(CCOperation)encryptOperation key:(NSString *)key
//
//{
//
//    const void *vplainText;
//
//    size_t plainTextBufferSize;
//
//
//
//    if (encryptOperation == kCCDecrypt)
//
//    {
//
//        NSData *decryptData = [GTMBase64 decodeData:[sText dataUsingEncoding:NSUTF8StringEncoding]];
//
//        plainTextBufferSize = [decryptData length];
//
//        vplainText = [decryptData bytes];
//
//    }
//
//    else
//
//    {
//
//        NSData* encryptData = [sText dataUsingEncoding:NSUTF8StringEncoding];
//
//        plainTextBufferSize = [encryptData length];
//
//        vplainText = (const void *)[encryptData bytes];
//
//    }
//
//
//
//    CCCryptorStatus ccStatus;
//
//    uint8_t *bufferPtr = NULL;
//
//    size_t bufferPtrSize = 0;
//
//    size_t movedBytes = 0;
//
//
//
//    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
//
//    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
//
//    memset((void *)bufferPtr, 0x0, bufferPtrSize);
//
//
//
//    NSString *initVec = @"init zhou";
//
//    const void *vkey = (const void *) [key UTF8String];
//
//    const void *vinitVec = (const void *) [initVec UTF8String];
//
//
//
//    ccStatus = CCCrypt(encryptOperation,
//
//                       kCCAlgorithmDES,
//
//                       kCCOptionPKCS7Padding,
//
//                       vkey,
//
//                       kCCKeySizeDES,
//
//                       vinitVec,
//
//                       vplainText,
//
//                       plainTextBufferSize,
//
//                       (void *)bufferPtr,
//
//                       bufferPtrSize,
//
//                       &movedBytes);
//
//
//
//    NSString *result = nil;
//
//
//
//    if (encryptOperation == kCCDecrypt)
//
//    {
//
//        result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding];
//
//    }
//
//    else
//
//    {
//
//        NSData *data = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
//
//        result = [GTMBase64 stringByEncodingData:data];
//
//    }
//
//
//
//    return result;
//
//}
//
//
//
//+ (NSString *)encryptWithText:(NSString *)sText
//
//{
//
//    return [self encrypt:sText encryptOrDecrypt:kCCEncrypt key:@"wang!@#$"];
//
//}
//
//
//
//+ (NSString *)decryptWithText:(NSString *)sText
//
//{
//
//    return [self encrypt:sText encryptOrDecrypt:kCCDecrypt key:@"wang!@#$"];
//
//}
//
@end