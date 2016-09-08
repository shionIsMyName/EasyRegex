//
//  ERManager.m
//  EasyRegexDemo
//
//  Created by shiyong on 16/8/27.
//  Copyright © 2016年 sy. All rights reserved.
//

#import "ERManager.h"

@implementation ERManager

+(NSString *) makeRegex:(void(^)(ERMaker* regex)) makingHandler{
    //创建正则制造器
    ERMaker *regexMaker=  [ERMaker sharedMaker];
    //初始化空操作用字符串
    [regexMaker setOperatingString:[[NSMutableString alloc] initWithString:@""]];
    //调用创建block
    makingHandler(regexMaker);
    //返回正则串
    return [regexMaker getRegex];
}


+(BOOL) isMatched:(NSString *) matchParam regex:(NSString*) regex{
    //创建谓语对象
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    //判断
    return  [predicate evaluateWithObject:matchParam];
}

+(BOOL) isUsernameOrPassword:(NSString *) userNameOrPassword{
    //验证用户名或密码
    //规则:字母开头，可以输入字母数字下划线，长度为6到16位
    //原生:”^[a-zA-Z]\w{5,15}$”
    NSString *regexStr = [ERManager makeRegex:^(ERMaker *regex) {
        //正则头部，匹配数字，匹配数量为1
        regex.begin.is(ERLetter); //等于 ^[a-zA-Z]
        //正则中部, 匹配字母数字下划线，匹配数量为5到15之间
        regex.addRule.is(ERNumberLetterAndUnderLine).lengthRange(5,15);//等于 \w{5,15}
        //正则尾部，以上一个规则结束
        regex.endAsLastRule();//等于 $
    }];
    
    NSLog(@"regexStr=>%@",regexStr);
    
    //参数参数
    BOOL result = [ERManager isMatched:userNameOrPassword regex:regexStr];
    return result;
}
+(BOOL) isTelePhoneNumber:(NSString *) telephoneNumber{
    //验证电话号码
    //规则：数字开头，3到4位，中间以横岗隔开,数字结尾长度7到8位
    //原生：^(\\d{3,4}-)\\d{7,8}$
    NSString *regexStr = [ERManager makeRegex:^(ERMaker *regex) {
        //正则头部，匹配数字，匹配3到4个
        regex.begin.is(ERNumber).lengthRange(3,4);//等于 ^(\\d{3,4}-)
        //正则中部，匹配 － ，匹配1个
        regex.addRule.is(@"-");//等于 -
        //正则尾部，匹配数字，匹配7到8个
        regex.end.is(ERNumber).lengthRange(7,8);//等于 \\d{7,8}$
    }];
   
    
    BOOL result = [ERManager isMatched:telephoneNumber regex:regexStr];
    return result;
}
+(BOOL) isCellPhoneNumber:(NSString *) cellphoneNumber{
    //验证手机号码
    //规则：数字1开头，第二位可能是3，4，5，7，8，第三位任意。以数字结尾，长度为8。
    //原生：^1[3|4|5|7|8][0-9]\\d{8}$”
    NSString *regexStr = [ERManager makeRegex:^(ERMaker *regex) {
        //正则头部，匹配字符串1,匹配1个
        regex.begin.is(@"1");//等于 ^1
        //正则中部，匹配字符串3，或4，或5，或7，或8，匹配1个
        regex.addRule.maybe(@"3",@"4",@"5",@"7",@"8",nil);//等于 [3|4|5|7|8]
        //正则中部，再匹配一个数字，1个
        regex.addRule.is(ERNumber);//等于 [0-9]
        //正则尾部，匹配一个数字，匹配8个
        regex.end.is(ERNumber).length(8);//等于 \\d{8}$
    }];
    
    BOOL result = [ERManager isMatched:cellphoneNumber regex:regexStr];
    return result;
}

+(BOOL) isIDNumber:(NSString *) idNumber{
    //验证身份证号
    //规则：数字开头，14位。数字结尾，或（数字和xX）结尾1到4位。
    //原生：@"\\d{14}[[0-9],0-9xX]{1,4}" (根本就没法用)
    
    //校验15位用
    NSString *regexStrA= [ERManager makeRegex:^(ERMaker *regex) {
        //正则头部约束，匹配数字，长度15个
        regex.begin.is(ERNumber).length(15);
    }];
    
    //校验18位用
    NSString *regexStrB= [ERManager makeRegex:^(ERMaker *regex) {
        //正则头部约束，匹配数字，长度17个
        regex.begin.is(ERNumber).length(17);
        //正则中部约束，匹配数字或大小写x，长度1个
        regex.addRule.maybe(ERNumber,@"xX",nil);
    }];
    
    BOOL resultA = [ERManager isMatched:idNumber regex:regexStrA];
    BOOL resultB = [ERManager isMatched:idNumber regex:regexStrB];
    //满足一个条件既为真
    BOOL final  = resultA||resultB;
    return final;
}


+(BOOL) isEmail:(NSString *) email{
    //验证邮箱
    //规则：3-18位字母，数字，点，减号，下划线组成。
    NSString *regexStr = [ERManager makeRegex:^(ERMaker *regex) {
        //正则约束，匹配字母数字下划线，或.,或-,匹配3到18个
        regex.addRule.maybe(ERNumberLetterAndUnderLine,@".",@"-",nil).lengthRange(3,18);
        //追加约束，匹配字符@，匹配1个
        regex.addRule.is(@"@");
        //追加约束，匹配数字字母，匹配2到63范围内的个数
        regex.addRule.is(ERNumberAndLetter).lengthRange(2,63);
        //追加约束，匹配字符.，匹配1个
        regex.addRule.is(@".");
        //结尾约束，匹配小写字母，长度2到6范围内的个数
        regex.end.addRule.is(ERLowerCase).lengthRange(2,6);
    }];
    
    
    BOOL result = [ERManager isMatched:email regex:regexStr];
    return result;
}




+(BOOL) isMoney:(NSString *) number{
    //判断是否是保留两位小数点的数字
    //原生：^[0-9]+(.[0-9]{2})?$
    NSString *regexStr = [ERManager makeRegex:^(ERMaker *regex) {
        //正则头部约束，匹配数字，匹配1到无限大个
        regex.begin.is(ERNumber).atLest(1);//等于 ^[0-9]+
        
        //组合正则约束开始
        regex.startCombo(); //等于 (
        //追加正则约束，匹配字符.，匹配1个
        regex.addRule.is(@".");//等于 .
        //追加正则约束，匹配数字，匹配2个
        regex.addRule.is(ERNumber).length(2);//等于 [0-9]{2}
        //组合正则约束结束
        regex.endCombo();//等于 )
        //组合正则，最少匹配0个，最多匹配1个
        regex.combo.atMost(1);//等于 ?
        
        //正则尾部以上一个约束的类型结尾
        regex.endAsLastRule();//等于 $
    }];
    
    
    
    BOOL result = [ERManager isMatched:number regex:regexStr];
    return result;
}

+(BOOL) ifContainSpecialChars:(NSString *) string{
    //判断是否包含特殊字符
    NSString *regexStr = [ERManager makeRegex:^(ERMaker *regex) {
        //正则约束，匹配字母数字，匹配最少1个最多无限大
        regex.addRule.is(ERNumberAndLetter).atLest(1);
    }];
    
    BOOL result = [ERManager isMatched:string regex:regexStr];
    return !result;
}
+(BOOL) isChinese:(NSString *)string{
    //判断是否是汉字
    NSString *regexStr = @"^[\u4e00-\u9fa5]{1,}$";
    BOOL result = [ERManager isMatched:string regex:regexStr];
    return result;
}
+(BOOL) isURL:(NSString *) url{
    //判断是否是url
    NSString *regexStr = @"^http[s]{0,1}://([\\w-]+\\.)+[\\w-]+(/[\\w-./?%&=]*)?$";
    BOOL result = [ERManager isMatched:url regex:regexStr];
    return result;
}
+(BOOL) isQQNumber:(NSString *) string{
    //判断是否是qq号
    NSString *regexStr = [ERManager makeRegex:^(ERMaker *regex) {
        //正则头部约束，匹配1到9之间的某个数，匹配1个
        regex.begin.is(@"[1-9]");
        //追加正则约束，匹配数字，匹配至少4个最多无限大
        regex.addRule.is(ERNumber).atLest(4);
        //正则以上一个类型约束为结尾约束
        regex.endAsLastRule();
    }];
    
    BOOL result = [ERManager isMatched:string  regex:regexStr];
    return result;
}
+(BOOL) isPostcode:(NSString *) string{
    //判断是否是邮编  
    NSString *regexStr = [ERManager makeRegex:^(ERMaker *regex) {
        regex.begin.is(@"[1-9]");
        regex.addRule.is(ERNumber).length(5);
        
        regex.startCombo();
        regex.addRule.is(@"?!");
        regex.addRule.is(ERNumber);
        regex.endCombo();
    }];
    BOOL result = [ERManager isMatched:string regex:regexStr];
    return result;
}



@end
