//
//  GJCFFileStorage.m
//  GJCommonFoundation
//  对象归档处理帮助类
//  Created by liyi on 14-10-20.
//  Copyright (c) 2014年 ganji.com. All rights reserved.
//

#import "GJCFFileStorage.h"

@implementation GJCFFileStorage

/**
 *  保存图片
 *
 *  @param imgObj 图片对象
 *  @param filePath  文件路径
 */
+ (BOOL)saveImage:(UIImage *)imgObj FilePath:(NSString *)filePath
{
    
    [GJCFFileStorage createLastDirectory:filePath];
    return [NSKeyedArchiver archiveRootObject:imgObj toFile:filePath];
}

/**
 *  保存字典
 *
 *  @param dictObj 字典
 *  @param filePath   文件路径
 */
+ (BOOL)saveDict:(NSDictionary *)dictObj FilePath:(NSString *)filePath
{
    [GJCFFileStorage createLastDirectory:filePath];
    return [NSKeyedArchiver archiveRootObject:dictObj toFile:filePath];
}

/**
 *  保存对象
 *
 *  @param obj      实现NSCoding协议的对象
 *  @param filePath 文件路径
 *
 *  @return 是否成功
 */
+ (BOOL)saveObject:(id<NSCoding>)obj FilePath:(NSString *)filePath
{
    [GJCFFileStorage createLastDirectory:filePath];
    return [NSKeyedArchiver archiveRootObject:obj toFile:filePath];
}
/**
 *  删除文件
 *
 *  @param filePath 文件路径
 */
+ (BOOL)deleteFile:(NSString *)filePath
{
    NSError *error = nil;
    BOOL isSuccess = [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
    if (!isSuccess) {
        return NO;
    }
    return YES;
    
}

/**
 *  获取本地图片文件
 *
 *  @param filePath 文件路径
 *
 *  @return 图片对象
 */
+ (UIImage *)getImage:(NSString *)filePath
{
    
    id imgObj = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    if (imgObj && [[imgObj class] isSubclassOfClass:[UIImage class]]) {
        return  (UIImage *)imgObj;
    }
    return nil;
}

/**
 *  获取本地字典对象
 *
 *  @param filePath 文件路径
 *
 *  @return 字典对象
 */
+ (NSDictionary *)getDictObj:(NSString *)filePath
{
    id dictObj = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    if (dictObj && [[dictObj class] isSubclassOfClass:[NSDictionary class]]) {
        return  (NSDictionary *)dictObj;
    }
    return [NSDictionary dictionary];
}


/**
 *  获取实现了NSCopying的对象
 *
 *  @param filePath 文件路径（不可为空）
 *
 *  @return 对象（如果不存在，返回nil）
 */
+ (id<NSCoding>)getObjcet:(NSString *)filePath
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}


+ (NSNumber *)getFileSize:(NSString *)filePath Error:(__autoreleasing NSError **)error
{
    NSArray *keys = @[NSURLTotalFileAllocatedSizeKey ];
    
    if (!filePath||filePath.length == 0) {
        
        *error = [NSError errorWithDomain:@"filePath is nil" code:1001 userInfo:nil];
        return [NSNumber numberWithInt:-1];
    }
    
    NSDictionary *valuesDict = [[NSURL fileURLWithPath:filePath] resourceValuesForKeys:keys error:error];
    
    return [valuesDict objectForKey:NSURLTotalFileAllocatedSizeKey];
    
    
}

+ (NSDate *)getFileModDate:(NSString *)filePath Error:(__autoreleasing NSError **)error
{
    NSArray *keys = @[NSURLAttributeModificationDateKey ];
    
    if (!filePath||filePath.length == 0) {
        
        *error = [NSError errorWithDomain:@"filePath is nil" code:1001 userInfo:nil];
        return nil;
    }
    
    NSDictionary *valuesDict = [[NSURL fileURLWithPath:filePath] resourceValuesForKeys:keys error:error];
    
    return [valuesDict objectForKey:NSURLAttributeModificationDateKey];
}

+ (NSArray *)getDirFileNames:(NSString *)dirPath Error:(__autoreleasing NSError **)error
{
    if (!dirPath||dirPath.length == 0) {
        
        *error = [NSError errorWithDomain:@"dirPath is nil" code:1001 userInfo:nil];
        return nil;
    }
    
    NSArray *arrTemp = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:[NSURL fileURLWithPath:dirPath] includingPropertiesForKeys:@[NSURLNameKey] options:NSDirectoryEnumerationSkipsHiddenFiles error:error];
    
    if ([arrTemp count] == 0) {
        return arrTemp;
    }
    
    NSMutableArray *arr = [NSMutableArray array];
    for (NSURL * fileNameUrl in arrTemp) {
        NSString *fileName = [fileNameUrl relativePath];
        [arr addObject:fileName];
    }
    
    return arr;
}

+ (void)createDirectory:(NSString *)path
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:nil]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil];
    }
}

+ (BOOL)isExitFile:(NSString *)filePath
{
    return [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:nil];
}

#pragma mark private methods


/**
 *  生成路径中除了文件名以外的目录
 *
 *  @param path 路径（包括文件名）
 */
+ (void)createLastDirectory:(NSString *)path
{
    NSString *lastDir = [path stringByDeletingLastPathComponent];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:lastDir isDirectory:nil]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:lastDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    
}


@end
