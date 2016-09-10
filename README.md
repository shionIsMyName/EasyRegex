# EasyRegex
一个可提供最便捷的方式生成正则表达式，且包含常用ios应用开发正则的第三方库(Objective-C)。

# 前言
每当你把一个注册界面搭建完毕，数据跑通的时候，总有一个令人恶心的问题会出现，那就是用户名密码等表单项的校验。接下来你需要去百度温习下正则
，还需要去了解下oc下如何实现正则校验，然后你还有自己亲自测试等等。有时候一个小小的表单校验可能会花去比界面搭建和网络数据处理更多的时间。如果你有同感，那么这个库将会给你提供很大的便利。
在使用本库过程中，你可能会感觉该库的使用方式类似于代码约束库"masonry",是的，改库就是模仿了masonry的编码方式，因为我们的出发点都是变复杂繁琐为简单易用。


## EasyRegex可以帮你做什么？
用最简单的方式来实现正则校验。


## EasyRegex怎么用?
1,EasyRegex分两部分，第二部分封装了一些常用的正则，你可以直接通过类方法来使用，有些是通用的，比如说电话号码校验，身份证校验等等。你只需要调取类方法即可。</br>

例1:校验用户名和密码是否符合由字母数字下划线组成，字母开头，总长度总长度6-16位。</br>

`NSString *username = @"asdf1234_";`<br>
`BOOL result = [ERManager isUsernameOrPassword:username];`<br>

例2:校验手机号码<br>
`NSString *cellphoneNum =@"18612344213";`<br>
`BOOL result = [ERManager isCellPhoneNumber:cellphoneNum];`<br>


2,EasyRegex第二部分是通过block方式来生成正则。<br>
ERManager类除了包含了很多常用的正则校验类方法外，同时，他还可以用来使用block方式来创建正则。<br>
就像这样：</br>
`NSString *regexStr = [ERManager makeRegex:^(ERMaker *regex) {`</br>
`        regex.begin.is(ERLetter);` </br>
`        regex.addRule.is(ERNumberLetterAndUnderLine).lengthRange(5,15);`</br>
`        regex.endAsLastRule();`</br>
`}];`</br>
    
有了正则传后，你还可以通过，ERManager的判断方法来判断所传字符串是否匹配你所编写的正则串。<br>
`BOOL result = [ERManager isMatched:userNameOrPassword regex:regexStr];`<br>
这样你就生成了一个用来校验用户名或密码的正则，他的规则是字母开头，由字母数字下划线组成，长度在6-16个字符之间。<br>

下面，我们来分析下这个代码。<br>
//下面这句话的意思是调用ERManager的创建正则方法，来获取正则制造器，就是获取regex对象。</r>
`NSString *regexStr = [ERManager makeRegex:^(ERMaker *regex) {`</br>

//下面这句话的意思是对正则头部进行约束，约束他只能匹配数字，且匹配数量为1，也就是说正则的头部必须是一个字母。</br>
`regex.begin.is(ERLetter); `<br>

//下面这句话的意思是对正则中部进行约束(正则可以很多中部，但只能有一个头部和尾部), 约束他只能匹配字母数字下划线，且匹配数量为5到15之间，第一个字母后必须是字母数字下划线，必须在5到15个字符之间。</br> 
`regex.addRule.is(ERNumberLetterAndUnderLine).lengthRange(5,15)`;

//下面这句话的意思是对正则尾部进行约束，以上一个规则结束，正则的结尾必须是前一个正则约束的类型，也就是字母数字下划线结尾</br>
`regex.endAsLastRule();`</br>


##EasyRegex的建议使用方式
首先，先看demo!先看demo!先看demo!重要的事情说3遍。
如果你对上述描述还不是太懂的话，建议可以在ERManager中找到自带的正则校验方法进行修改。
比如说ERManager中提供的用户名密码正则的校验是，字母数字下划线组成，字母开头，长度6到16位。而你的需求是开头没有限制，由字母数字下划线组成，长度8到18位。
那么你可以将用户名密码校验的正则block复制出来进行修改。<br>
例：<br>
修改前<br>
`NSString *regexStr = [ERManager makeRegex:^(ERMaker *regex) {`</br>
`        regex.begin.is(ERLetter);` </br>
`        regex.addRule.is(ERNumberLetterAndUnderLine).lengthRange(5,15);`</br>
`        regex.endAsLastRule();`</br>
`}];`</br>
修改后<br>
`NSString *regexStr = [ERManager makeRegex:^(ERMaker *regex) {`</br>
`        regex.addRule.is(ERNumberLetterAndUnderLine).lengthRange(8,18);`</br>
`        regex.endAsLastRule();`</br>
`}];`</br>

##注
如果还有不明白的地方，可以加qq群：574566866咨询。

    






