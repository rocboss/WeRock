//
//  GJCFFileStorage.h
//  GJCommonFoundation
//  对象归档处理帮助类
//  Created by liyi on 14-10-20.
//  Copyright (c) 2014年 ganji.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GJCFFileStorage : NSObject

/**
 *  保存图片
 *
 *  @param imgObj 图片对象
 *  @param filePath  文件路径
 */

/**
 *  保存图片
 *
 *  @param imgObj   图片对象
 *  @param filePath 文件路径
 *
 *  @return 是否保存成功
 */
+ (BOOL)saveImage:(UIImage *)imgObj FilePath:(NSString *)filePath;

/**
 *  保存字典
 *
 *  @param dictObj 字典（这个字典里面的对象，必须实现了序列化和反序列化，否则崩溃）
 *  @param filePath   文件路径
 *
 *  @return 是否保存成功
 */
+ (BOOL)saveDict:(NSDictionary *)dictObj FilePath:(NSString *)filePath;


/**
 *  保存对象
 *
 *  @param obj      实现NSCoding协议的对象
 *  @param filePath 文件路径
 *
 *  @return 是否成功
 */
+ (BOOL)saveObject:(id<NSCoding>)obj FilePath:(NSString *)filePath;

/**
 *  删除文件
 *
 *  @param filePath 文件路径
 *
 *  @return 是否删除成功
 */
+ (BOOL)deleteFile:(NSString *)filePath;

/**
 *  获取本地图片文件
 *
 *  @param filePath 文件路径
 *
 *  @return 图片对象(如果图片不存在，可能为nil)
 */
+ (UIImage *)getImage:(NSString *)filePath;

/**
 *  获取本地字典对象
 *
 *  @param filePath 文件路径
 *
 *  @return 字典对象(如果文件不存在，返回无值的NSdictionary)
 */
+ (NSDictionary *)getDictObj:(NSString *)filePath;

/**
 *  获取实现了NSCoding的对象
 *
 *  @param filePath 文件路径（不可为空）
 *
 *  @return 对象（如果不存在，返回nil）
 */
+ (id<NSCoding>)getObjcet:(NSString *)filePath;
/**
 *  获取文件大小
 *
 *  @param filePath 文件路径（不可为空）
 *  @param error    返回的引用错误对象
 *
 *  @return 文件大小
 */
+ (NSNumber *)getFileSize:(NSString *)filePath Error:(__autoreleasing NSError **)error;

/**
 *  获取文件的修改时间
 *
 *  @param filePath 文件路径（不可为空）
 *  @param error    返回的引用错误对象
 *
 *  @return 文件的修改时间
 */
+ (NSDate *)getFileModDate:(NSString *)filePath Error:(__autoreleasing NSError **)error;

/**
 *  获取该目录下的所有非隐藏文件的地址
 *
 *  @param dirPath 目录路径
 *  @param error   返回的引用错误对象
 *
 *  @return 文件地址数组
 */
+ (NSArray *)getDirFileNames:(NSString *)dirPath Error:(__autoreleasing NSError **)error;

/**
 *  生成目录
 *
 *  @param path 目录路径
 */
+ (void)createDirectory:(NSString *)path;

/**
 *  是否存在这个文件
 *
 *  @param filePath 文件路径
 *
 *  @return 返回状态
 */
+ (BOOL)isExitFile:(NSString *)filePath;

/**
 *  根据文件地址，生成文件所在的目录
 *
 *  @param path 文件地址
 */
+ (void)createLastDirectory:(NSString *)path;

@end
