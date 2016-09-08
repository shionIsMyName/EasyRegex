//
//  ERMaker.m
//  EasyRegexDemo
//
//  Created by shiyong on 16/8/27.
//  Copyright © 2016年 sy. All rights reserved.
//

#import "ERMaker.h"
@interface ERMaker()
//要操作的字符串
@property (nonatomic,strong) NSMutableString* operatingStr;
//是否限定正则结尾
@property (nonatomic,assign) BOOL hasEnd;

@end

@implementation ERMaker

+(instancetype) sharedMaker{
    static ERMaker *maker = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        maker = [[self alloc] init];
    });
    return maker;
}



-(void) setOperatingString:(NSMutableString *) operatingStr{
    _operatingStr = operatingStr;
}


-(NSString*) getRegex{
    if (_hasEnd) {
        [_operatingStr appendString:@"$"];
        _hasEnd = NO;
    }
    return _operatingStr;
}

-(ERMaker *) begin{
    [_operatingStr appendString:@"^"];
    return self;
}

-(ERMaker *) addRule{
    return self;
}

-(ERMaker *) end{
    _hasEnd=YES;
    return self;
}
-(ERMaker *) combo{
    return self;
}

-(ERMaker*(^)(void)) startCombo{
    return ^(void){
        [_operatingStr appendString:@"("];
        return self;
    };
}

-(ERMaker*(^)(void)) endCombo{
    return ^(void){
        [_operatingStr appendString:@")"];
        return self;
    };
}

-(ERMaker*(^)(void)) endAsLastRule{
    return ^(void){
        _hasEnd=YES;
        return self;
    };
}

-(ERMaker*(^)(NSString* type)) is{
    return ^(NSString* type){
        [_operatingStr appendString:type];
        return self;
    };
}

-(ERMaker*(^)(NSString* type,...)) maybe{
    return ^(NSString* type,...){
        va_list args;
        va_start(args, type);
        //拼接所有类型参数
        if (type){
             [_operatingStr appendString:[NSString stringWithFormat:@"[%@",type]];
            NSString *nextType;
            while ((nextType = va_arg(args, NSString *)))
            {
                [_operatingStr appendString:[NSString stringWithFormat:@"%@",nextType]];
            }
        }  
        va_end(args);
        
        [_operatingStr appendString:@"]"];
        return self;
    };
}


-(ERMaker*(^)(long length)) length{
    return ^(long length){
        [_operatingStr appendString:[NSString stringWithFormat:@"{%ld}",length]];
        return self;
    };
}

-(ERMaker*(^)(long min,long max)) lengthRange{
    return ^(long min,long max){
        [_operatingStr appendString:[NSString stringWithFormat:@"{%ld,%ld}",min,max]];
        return self;
    };
}

-(ERMaker*(^)(long min)) atLest{
    return ^(long min){
        [_operatingStr appendString:[NSString stringWithFormat:@"{%ld,}",min]];
        return self;
    };
}

-(ERMaker*(^)(long max)) atMost{
    return ^(long max){
        [_operatingStr appendString:[NSString stringWithFormat:@"{0,%ld}",max]];
        return self;
    };
}


@end
