//
//  ViewController.m
//  代码加固混淆
//
//  Created by XJL on 2018/9/14.
//  Copyright © 2018年 XJL. All rights reserved.
//

#import "ViewController.h"
/* 字符串混淆解密函数，将char[] 形式字符数组和 aa异或运算揭秘 */
extern char* decryptConfusionCS(char* string)
{
  char* origin_string = string;
  while(*string) {
    *string ^= 0xAA;
    string++;
  }
  return origin_string;
}

/* 解密函数，返回的是NSString类型的 */
extern NSString* decryptConstString(char* string)
{
  /* 先执行decryptConfusionString函数解密字符串 */
  char* str = decryptConfusionCS(string);
  /* 获取字符串的长度 */
  unsigned long len = strlen(str);
  NSUInteger length = [[NSString stringWithFormat:@"%lu",len] integerValue];
  NSString *resultString = [[NSString alloc]initWithBytes:str length:length encoding:NSUTF8StringEncoding];
  return resultString;
}


/*
 * 使用heyujia_confusion宏控制加密解密
 * 当heyujia_confusion宏被定义的时候，执行加密脚本，对字符串进行加密
 * 当heyujia_confusion宏被删除或为定义时，执行解密脚本，对字符串解密
 */
#define heyujia_confusion

#ifdef heyujia_confusion
/* heyujia_confusion 宏被定义，那么就进行执行解密脚本 */
/* confusion_NSSTRING宏的返回结果是NSString 类型的 */
#define confusion_NSSTRING(string) decryptConstString(string)
/* confusion_CSTRING宏的返回结果是char* 类型的 */
#define confusion_CSTRING(string) decryptConfusionCS(string)
#else
/* heyujia_confusion 宏没有被定义，那么就执行加密脚本 */
/* 加密NSString类型的 */
#define confusion_NSSTRING(string) @string
/* 加密char *类型的 */
#define confusion_CSTRING(string) string
#endif

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
 
  /* 使用confusion_NSSTRING宏包含需要加密的NSString字符串 */
  NSString *str = confusion_NSSTRING("Hello World");
  NSLog(@"%@",str);
  /* 使用confusion_NSSTRING宏包含需要加密的char*字符串 */
  char* cStr = confusion_CSTRING("Super Man");
  NSLog(@"%s",cStr);

  
 
  
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
