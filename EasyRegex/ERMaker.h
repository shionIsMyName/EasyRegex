//
//  ERMaker.h
//  EasyRegexDemo
//  所谓正则，其实就是一个字符串的模具，字符串放进来契合模具，为真，反之为假。
//  正则一般分为三个部分，一个是头部，中部，尾部。每个部分都是由匹配类型和匹配次数组成。
//  例如:用户名正则的开头必须要匹配字母，结尾可以匹配任意类型，至少要匹配上5次到15次以内。
//  所以只要分别对头，中，尾，进行匹配类型设置，和匹配次数设置即可写出正则。
//  Created by shiyong on 16/8/27.
//  Copyright © 2016年 sy. All rights reserved.
//

#import <Foundation/Foundation.h>
//匹配数字
#define ERNumber                   @"[0-9]"
//匹配小写字母
#define ERLowerCase                @"[a-z]"
//匹配大写字母
#define ERCaps                     @"[A-Z]"
//匹配字母
#define ERLetter                   @"[A-Za-z]"
//匹配字母数字
#define ERNumberAndLetter          @"[A-Za-z0-9]"
//匹配字幕数字下划线
#define ERNumberLetterAndUnderLine @"\\w"
//任意匹配
#define ERAny                      @"."
//匹配数字，小数
#define ERFloat                    @"[0-9]+([.]{0,1}[0-9]+){0,1}"

@interface ERMaker : NSObject
/**
 *  单例初始化
 */
+(instancetype) sharedMaker;

/**
 *  正则的头部，既以什么开始
 */
@property (nonatomic,weak) ERMaker *begin;
/**
 *  追加正则约束（非头部，尾部）
 */
@property (nonatomic,weak) ERMaker *addRule;
/**
 *  正则的尾部，既以什么结尾
 */
@property (nonatomic,weak) ERMaker *end;
/**
 *  正则的组合，一般用在组合正则条件时
 */
@property (nonatomic,weak) ERMaker *combo;

/**
 *  组合正则条件－开始
 */
-(ERMaker*(^)(void)) startCombo;
/**
 *  组合正则条件－结束
 */
-(ERMaker*(^)(void)) endCombo;



/**
 *  以上一个正则内容限制为结尾
 */
-(ERMaker*(^)(void)) endAsLastRule;



/**
 *  设置操作用字符串
 *
 *  @param operatingStr 操作用字符串
 */
-(void) setOperatingString:(NSMutableString *) operatingStr;
/**
 *  获取正则串
 *
 *
 *  @return 正则串
 */
-(NSString*) getRegex;



/**
 *  正则匹配类型的约束，单参，例如@"a",@"123",纯数字，纯字母等。
 */
-(ERMaker*(^)(NSString* type)) is;
/**
 *  正则匹配类型的约束，多参，例如@"a"或@"1"，纯数字或纯字母等其中之一。
 */
-(ERMaker*(^)(NSString* type,...)) maybe;


/**
 *  正则匹配字符长度(出现次数)设置
 */
-(ERMaker*(^)(NSInteger length)) length;
/**
 *  正则匹配字符长度(出现次数)范围设置
 */
-(ERMaker*(^)(NSInteger min,NSInteger max)) lengthRange;
/**
 *  正则匹配字符长度(出现次数)至少有多少
 */
-(ERMaker*(^)(NSInteger min)) atLest;
/**
 *  正则匹配字符长度(出现次数)最多有多少,注意从0开始
 */
-(ERMaker*(^)(NSInteger max)) atMost;






@end
