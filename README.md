# Base64+DES加密

## 使用

1. 修改CommonFunc.h中 key 值
2. 

```objc
NSString *str1 = @"q12344444444444444444444444444444444444k";
NSLog(@"加密========%@",[CommonFunc encryptWithText:str1]);
NSLog(@"解密=========%@",[CommonFunc decryptWithText:@"GSTgig0ueNheMcXaPZTvEV4xxdo9lO8RXjHF2j2U7xFbrraIgprLzUoQ4SOIL9DH"]);

```