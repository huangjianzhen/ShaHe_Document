//
//  Util.h
//  沙盒操作Demo
//
//  Created by zk on 16/1/4.
//  Copyright © 2016年 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject

+(Util *)getInstance;

-(void)copyField:(NSString *)name : (NSString *)type :(NSString *)path;  //拷贝文件

-(BOOL)copyMissingFild:(NSString *)sourcePath toPath : (NSString *)toPath;//是否拷贝了文件

-(void)createFolder:(NSString *)createDir;//创建文件夹

-(NSArray *)getAllFileNames:(NSString *)dirName; //得到所有沙盒的东西

@end
