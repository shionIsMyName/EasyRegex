//
//  EasyRegex.h
//  EasyRegexDemo
//
//  Created by shiyong on 16/8/27.
//  Copyright © 2016年 sy. All rights reserved.
//

#ifndef EasyRegex_h
#define EasyRegex_h
/**
 *  所谓正则，其实就是一个字符串的模具，字符串放进来契合模具，为真，反之为假。
 *  正则一般分为三个部分，一个是头部，中部，尾部。每个部分都是由匹配类型和匹配次数组成。
 *  例如:用户名正则的开头必须要匹配字母，结尾可以匹配任意类型，至少要匹配上5次到15次以内。
 *  所以只要分别对头，中，尾，进行匹配类型设置，和匹配次数设置即可写出正则。
 */
#import "ERMaker.h"
#import "ERManager.h"

#endif /* EasyRegex_h */
