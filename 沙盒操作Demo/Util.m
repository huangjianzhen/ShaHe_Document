


//
//  Util.m
//  沙盒操作Demo
//
//  Created by zk on 16/1/4.
//  Copyright © 2016年 zhu. All rights reserved.
//

#import "Util.h"

@implementation Util

static Util *util = nil;

+(Util *)getInstance{
 
    @synchronized(self) {
        
        if(util == nil){
         
            util = [[Util alloc]init];
        }
    }
    return util;
}


-(void)copyField:(NSString *)name :(NSString *)type :(NSString *)path{
 
    //文件类型
    
    NSString *docPath = [[NSBundle mainBundle]pathForResource:name ofType:type];
#warning 这里不用了这些了,就先用了创建文件夹的方法,其他的大家可以试一试呀
    
//    //沙盒的Document目录
//    
//    NSString *appDir = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) lastObject];
//    
//    //沙盒Libary目录
//    
//    NSString *appDir2 = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
//    
//    //appLib Libary/Caches //目录
//    
//    NSString *appLib = [appDir2 stringByAppendingString:@"/Caches"];
//    
//    BOOL filePrsenet = [self copyMissingFild:docPath toPath:appLib];
//    
//    if(filePrsenet){
//     
//        NSLog(@"已经存在该文件");
//        
//    }else{
//     
//        NSLog(@"不存在该文件");
//    }
//    
    //创建文件夹
    
    NSString *creaDir = [NSHomeDirectory() stringByAppendingString:path];

    NSLog(@"path:%@",creaDir);
    
    [self createFolder:creaDir];

    
    //把文件拷贝到文件夹里面
    
    BOOL filesPrsent1 = [self copyMissingFild:docPath toPath:creaDir];
    
    if(filesPrsent1){
     
        NSLog(@"已经存在了");
    }else{
     
        NSLog(@"不存在");
    }

}


//判断文件在不在
-(BOOL)copyMissingFild:(NSString *)sourcePath toPath : (NSString *)toPath
{
    BOOL retVal = YES; // If the file already exists, we'll return success…
    NSString * finalLocation = [toPath stringByAppendingPathComponent:[sourcePath lastPathComponent]];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:finalLocation])
    {
        retVal = [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:finalLocation error:NULL];
    }
    return retVal;
}

//创建文件夹
-(void)createFolder:(NSString *)createDir{

    BOOL isDir = NO;
    
    NSFileManager *fileManger = [NSFileManager defaultManager];

    BOOL existed = [fileManger fileExistsAtPath:createDir isDirectory:&isDir];
    
    if(!(isDir == YES && existed == YES)){
    
     
        [fileManger createDirectoryAtPath:createDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

//得到沙盒的东西
-(NSArray *)getAllFileNames:(NSString *)dirName{

    //    //沙盒的Document目录
    //
    //    NSString *appDir = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) lastObject];
    //
    //    //沙盒Libary目录
    //
    //    NSString *appDir2 = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    //
    //    //appLib Libary/Caches //目录
    
    NSString *path = NSHomeDirectory();

    
    NSString *fileDirectory = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",dirName]];
    
    NSArray *files = [[NSFileManager defaultManager]subpathsOfDirectoryAtPath:fileDirectory error:nil];
    
    NSLog(@"files:%@",files);
    
    return files;
    
}
@end
