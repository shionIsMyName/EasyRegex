//
//  ViewController.m
//  EasyRegexDemo
//
//  Created by shiyong on 16/8/27.
//  Copyright © 2016年 sy. All rights reserved.
//

#import "ViewController.h"
#import "EasyRegex.h"


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    /**
     *  所谓正则，其实就是一个字符串的模具，字符串放进来吻合模具，为真，反之为假。
     *  正则一般分为三个部分，一个是头部，中部，尾部。每个部分都是由匹配类型和匹配次数组成。
     *  例如:用户名正则的开头必须要匹配字母，中部，结尾可以匹配任意类型，至少要匹配上5次到15次以内。
     *  所以只要分别对头，中，尾，进行匹配类型设置，和匹配次数设置即可写出正则。
     */
    //验证用户名或密码
    [self validateUsnAPsd];
    
    //验证手机号码
//    [self validateCellphoneNumber];
    
    //验证身份证号
//    [self validateIDNumber];
    
    //验证邮箱
//    [self validateEmail];
    
    //验证电话号码
//    [self validateTelePhoneNumber];
    
    //判断是否包含特殊字符
//    [self containSpecialChars];
    
    //判断是否是纯汉字
//    [self validateChinese];
    
    //判断是否是url
//    [self validateURL];
    
    //判断是否是qq号
//    [self validateQQNumber];
    
    //判断是否是邮政编码
//    [self validatePostcode];
    
    
}

-(void) validateUsnAPsd{
    NSString *matchParam = @"asdfg_";
    BOOL result = [ERManager isUsernameOrPassword:matchParam];
    
    NSLog(@"结果为=>%@",result>0?@"真":@"假");
}

-(void) validateTelePhoneNumber{
    //参数参数
    NSString *matchParam = @"0222-5678262";
    BOOL result = [ERManager isTelePhoneNumber:matchParam];
    
    NSLog(@"结果为=>%@",result>0?@"真":@"假");
}


-(void) validateCellphoneNumber{
    //参数参数
    NSString *matchParam = @"18626899532";
    BOOL result = [ERManager isCellPhoneNumber:matchParam];
    
    NSLog(@"结果为=>%@",result>0?@"真":@"假");
}


-(void) validateIDNumber{
    //参数参数
    NSString *matchParam = @"340404201601012111";
    BOOL result = [ERManager isIDNumber:matchParam];
    
    NSLog(@"结果为=>%@",result>0?@"真":@"假");
}

-(void) validateEmail{
    NSString *email = @"619023485@qq.com";
    BOOL result = [ERManager isEmail:email];
    NSLog(@"结果为=>%@",result>0?@"真":@"假");
}



-(void) containSpecialChars{
    NSString *textStr = @"1asdjlkjasdfa$";
    BOOL result = [ERManager ifContainSpecialChars:textStr];
    NSLog(@"结果为=>%@",result>0?@"真":@"假");
}

-(void) validateChinese{
    NSString *textStr = @"是对方";
    BOOL result = [ERManager isChinese:textStr];
    NSLog(@"结果为=>%@",result>0?@"真":@"假");
}

-(void) validateURL{
    NSString *textStr = @"https://www.baidu.com";
    BOOL result = [ERManager isURL:textStr];
    NSLog(@"结果为=>%@",result>0?@"真":@"假");
}

-(void) validateQQNumber{
    NSString *textStr = @"619023485";
    BOOL result = [ERManager isQQNumber:textStr];
    NSLog(@"结果为=>%@",result>0?@"真":@"假");
}
-(void) validatePostcode{
    NSString *textStr = @"15003";
    BOOL result = [ERManager isPostcode:textStr];
    NSLog(@"结果为=>%@",result>0?@"真":@"假");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
