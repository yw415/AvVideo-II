//
//  NSString+MD5Encrypt.h
//  Smile
//
//  Created by 周 敏 on 12-11-24.

//

#import <CommonCrypto/CommonDigest.h>

@interface NSString (MD5)

- (NSString *)md5Encrypt;

@end
