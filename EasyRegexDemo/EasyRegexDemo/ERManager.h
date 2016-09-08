//
//  ERManager.h
//  EasyRegexDemo
//  所谓正则，其实就是一个字符串的模具，字符串放进来契合模具，为真，反之为假。
//  正则一般分为三个部分，一个是头部，中部，尾部。每个部分都是由匹配类型和匹配次数组成。
//  例如:用户名正则的开头必须要匹配字母，结尾可以匹配任意类型，至少要匹配上5次到15次以内。
//  所以只要分别对头，中，尾，进行匹配类型设置，和匹配次数设置即可写出正则。
//  Created by shiyong on 16/8/27.
//  Copyright © 2016年 sy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ERMaker.h"
@interface ERManager : NSObject
/**
 *  正则创建
 *
 *  @param makingHandler 正则创建处理block
 *
 *  @return 正则串
 */
+(NSString *) makeRegex:(void(^)(ERMaker* regex)) makingHandler;


/**
 *  判断所传字符串是否匹配正则
 *
 *  @param matchParam 需要判断的字符串
 *  @param regex      正则
 *
 *  @return 是否匹配
 */
+(BOOL) isMatched:(NSString *) matchParam regex:(NSString*) regex;


//----------------------------常用正则
/**
 *  判断用户名或密码是否合法
 *  规则：字母开头，可以包含数字，字母，下划线，6－16位。
 *  其实不是很通用，各位可以根据具体实现来修改成自己需要的。：）
 */
+(BOOL) isUsernameOrPassword:(NSString *) userNameOrPassword;
/**
 *  判断手机号码是否合法
 */
+(BOOL) isCellPhoneNumber:(NSString *) cellphoneNumber;
/**
 *  判断身份证号是否合法
 */
+(BOOL) isIDNumber:(NSString *) idNumber;
/**
 *  判断是否是email,以qq邮箱为例，如果不满足需求，可以查看具体实现来修改。
 *  规则：邮箱名称以3-18位字母，数字，点，减号，下划线组成。
 *  感觉也不是很通用，每个邮箱的规则命名的规则都不一样，所以还是把实现代码拿出来修改比较合适。
 */
+(BOOL) isEmail:(NSString *) email;


//----------------------------不常用正则
/**
 *  判断是否是电话号码
 */
+(BOOL) isTelePhoneNumber:(NSString *) telephoneNumber;
/**
 *  判断是否是金额数, 例如:1.00 5.99 0.11
 *  判断金额应该还不错，如果不满足需要，到实现里修改下参数即可。
 */
+(BOOL) isMoney:(NSString *) number;
/**
 *  判断是否包含特殊字符（只要不是字母，数字，都是特殊字符）
 *  如果你要做一些例外操作打话，可以去实现修改相关代码。
 */
+(BOOL) ifContainSpecialChars:(NSString *) string;
/**
 *  判断是否是纯汉字
 */
+(BOOL) isChinese:(NSString *) string;
/**
 *  判断是否是url
 */
+(BOOL) isURL:(NSString *) url;
/**
 *  判断是否是qq号
 */
+(BOOL) isQQNumber:(NSString *) string;
/**
 *  判断是否是邮编
 */
+(BOOL) isPostcode:(NSString *) string;


@end
