//
//  GJCFDiskCache.h
//  GJCommonFoundation
//  硬盘缓存管理
//  Created by liyi on 14-10-20.
//  Copyright (c) 2014年 ganji.com. All rights reserved.
//
//  注意：所有异步block返回的数据都是基于异步线程，而不是从你所在的线程返回，请自行使用你当前环境的线程处理数据
//
#import <Foundation/Foundation.h>

@class GJCFDiskCache;



typedef void (^GJCFDiskCacheObjectBlock)(GJCFDiskCache *cache, NSString *key, id <NSCoding> object, NSString *filePath);
typedef void (^GJCFDiskCacheBlock)(GJCFDiskCache *cache);
typedef void (^GJCFDiskCacheErrorBlock)(GJCFDiskCache *cache, NSError *error);


@interface GJCFDiskCache : NSObject

/**
 *  字节数
 */
@property (readonly)    int byteCount;
/**
 *  字节数限制
 */
@property (assign)      int byteLimit;

/**
 *  缓存名称
 */
@property (readonly)    NSString *cacheName;
/**
 *  缓存文件夹根路径
 */
@property (readonly)    NSString *cacheRootPath;


/**
 *  持久化缓存单例
 *
 *  @return 返回持久化缓存管理类实例
 */
+ (instancetype)shareCache;

/**
 *  持久化缓存串行队列单例
 *
 *  @return 持久化缓存串行队列
 */
+ (dispatch_queue_t)sharedQueue;

/**
 *  初始化持久化缓存实例（按名称）
 *
 *  @param name 实例显示名称
 *
 *  @return 返回以默认rootpath/name/为路径的持久化缓存管理类实例
 */
- (instancetype)initWithName:(NSString *)name;

/**
 *  初始化持久化缓存实例（按名称，和路径）
 *
 *  @param name  实例显示名称
 *  @param rootPath 路径
 *
 *  @return 返回以rootpath为路径的缓存持久化实例
 */
- (instancetype)initWithName:(NSString *)name rootPath:(NSString *)rootPath;

/**
 *  异步设置缓存对象(过期时间为默认的一天)
 *
 *  @param object       对象
 *  @param key          键
 *  @param successblock 成功的block
 *  @param failBlock    失败的block
 */
- (void)setObject:(id <NSCoding>)object forKey:(NSString *)key successBlock:(GJCFDiskCacheObjectBlock)successblock  failBlock:(GJCFDiskCacheErrorBlock)failBlock;

/**
 *  异步设置缓存对象
 *
 *  @param object       对象
 *  @param key          键
 *  @param expire       过期时间
 *  @param successblock 成功的block
 *  @param failBlock    失败的block
 */
- (void)setObject:(id <NSCoding>)object forKey:(NSString *)key  expire:(int)expire successBlock:(GJCFDiskCacheObjectBlock)successblock failBlock:(GJCFDiskCacheErrorBlock)failBlock;

/**
 *  异步获取对象（默认考虑过期时间）
 *
 *  @param key          键
 *  @param successBlock 成功的block
 *  @param failBlock    失败的block
 */
- (void)getObject:(NSString *)key successBlock:(GJCFDiskCacheObjectBlock)successBlock failBlock:(GJCFDiskCacheErrorBlock)failBlock;

/**
 *  异步获取对象
 *
 *  @param key          键
 *  @param isCareExpire 是否考虑过期时间
 *  @param successBlock 成功的block
 *  @param failBlock    失败的block
 */
- (void)getObject:(NSString *)key isCareExpire:(BOOL)isCareExpire successBlock:(GJCFDiskCacheObjectBlock)successBlock failBlock:(GJCFDiskCacheErrorBlock)failBlock;

/**
 *  同步获取对象（线程安全）
 *
 *  @param key 键
 *
 *  @return 返回以key为键的对象
 */
- (id<NSCoding>)getObjectForKey:(NSString *)key;

/**
 *  删除对象
 *
 *  @param key          键
 *  @param successblock 成功的block
 *  @param failBlock    失败的block
 */
- (void)removeObjectForKey:(NSString *)key successBlock:(GJCFDiskCacheBlock)successblock  failBlock:(GJCFDiskCacheErrorBlock)failBlock;

/**
 *  删除所有对象
 *
 *  @param successblock 成功的block
 *  @param failBlock    失败的block
 */
- (void)removeAllObjects:(GJCFDiskCacheBlock)successblock  failBlock:(GJCFDiskCacheErrorBlock)failBlock;


/**
 *  将某个时间之前保存的文件缓存都删除(线程安全)
 *
 *  @param date         指定时间
 *  @param successblock 成功的block
 *  @param failBlock    失败的block
 */
- (void)trimToDate:(NSDate *)date successBlock:(GJCFDiskCacheBlock)successblock  failBlock:(GJCFDiskCacheErrorBlock)failBlock;

/**
 *  按照文件大小，由大大小依次删除文件缓存，知道当前缓存实例占有本地缓存大小为指定大小
 *
 *  @param trimbyteCount 指定大小
 *  @param successblock  成功的block
 *  @param failBlock     失败的block
 */
- (void)trimToSize:(NSUInteger)trimbyteCount successBlock:(GJCFDiskCacheBlock)successblock  failBlock:(GJCFDiskCacheErrorBlock)failBlock;

@end
