//
//  GJCFDiskCache.m
//  GJCommonFoundation
//
//  Created by liyi on 14-10-20.
//  Copyright (c) 2014年 ganji.com. All rights reserved.
//

#import "GJCFDiskCache.h"
#import "GJCFFileStorage.h"

/**
 *  默认磁盘缓存字节数限制
 */
static const long long gjcf_defaultByteLimit = 100000 * 1024 *1024;
/**
 *  默认磁盘缓存过期时间
 */
static const NSInteger gjcf_defaultExpireTime = 60 * 60 * 24;
/**
 *  默认磁盘缓存名称
 */
static const NSString *gjcf_defaultDiskCacheName = @"com.ganji.commonfoundation.diskCache";
/**
 *  过期时间文件名
 */
static const NSString *gjcf_expireFileName = @".cacheExpires";

#define GJCFDefaultDiskCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]


@interface GJCFDiskCache()

@property (nonatomic,assign) dispatch_queue_t mainQueue;
@property (nonatomic,strong) NSMutableDictionary *mainDates;
@property (nonatomic,strong) NSMutableDictionary *mainSizes;
@property (nonatomic,strong) NSMutableDictionary *mainExpires;


- (BOOL)trimDiskToSize:(NSUInteger)trimbyteCount;
- (BOOL)trimDiskToDate:(NSDate *)trimDate;
- (BOOL)deleteObjectCache:(NSString *)keyPath;
- (BOOL)saveExpire;

@end

@implementation GJCFDiskCache
@synthesize cacheName;
@synthesize byteCount;
@synthesize byteLimit;
@synthesize mainQueue;
@synthesize cacheRootPath;
@synthesize mainDates;
@synthesize mainSizes;
@synthesize mainExpires;

+ (instancetype)shareCache
{
    static GJCFDiskCache *share;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        
        share = [[GJCFDiskCache alloc] initWithName:(NSString *)gjcf_defaultDiskCacheName rootPath:[NSString stringWithFormat:@"%@/%@/",GJCFDefaultDiskCachePath,(NSString *)gjcf_defaultDiskCacheName]];
    });
    
    return share;
}
+ (dispatch_queue_t)sharedQueue
{
    static dispatch_queue_t queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create([(NSString *)gjcf_defaultDiskCacheName UTF8String], DISPATCH_QUEUE_SERIAL);
    });
    
    return queue;
}
- (instancetype)initWithName:(NSString *)name
{
    return [[GJCFDiskCache alloc] initWithName:name rootPath:[NSString stringWithFormat:@"%@/%@",GJCFDefaultDiskCachePath,name]];
}
- (instancetype)initWithName:(NSString *)name rootPath:(NSString *)rootPath
{
    
    if (!name || !rootPath) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        cacheName = [name copy];
        cacheRootPath = [rootPath copy];
        
        
        [GJCFFileStorage createDirectory:rootPath];
        
        
        byteLimit = gjcf_defaultByteLimit;
        
        mainQueue = [GJCFDiskCache sharedQueue];
        
        mainSizes = [NSMutableDictionary dictionary];
        mainDates = [NSMutableDictionary dictionary];
        
        NSString *cacheExpirePath = [NSString stringWithFormat:@"%@/%@",rootPath,gjcf_expireFileName];
        
        if ([GJCFFileStorage isExitFile:cacheExpirePath]) {
            mainExpires = [NSMutableDictionary dictionaryWithDictionary:[GJCFFileStorage getDictObj:cacheExpirePath]] ;
        }
        else
        {
            mainExpires = [NSMutableDictionary dictionary];
            [GJCFFileStorage saveDict:mainExpires FilePath:cacheExpirePath];
        }
        
        NSError *error = nil;
        NSArray *keys  = [GJCFFileStorage getDirFileNames:rootPath Error:&error];
        if (error == nil && [keys count] > 0) {
            for (NSString *keyPath in keys) {
                
                NSString *subKeyPath = [keyPath lastPathComponent];
                
                NSError *errorKey = nil;
                NSNumber *sizeNum = [GJCFFileStorage getFileSize:keyPath Error:&errorKey];
                if (!errorKey && [sizeNum intValue] != -1) {
                    [mainSizes setObject:sizeNum forKey:subKeyPath];
                    byteCount += [sizeNum intValue];
                }
                
                errorKey = nil;
                NSDate *modifyDate = [GJCFFileStorage getFileModDate:keyPath Error:&errorKey];
                
                if (!errorKey && modifyDate) {
                    [mainDates setObject:modifyDate forKey:subKeyPath];
                }
                
                
            }
        }
        
    }
    return self;
}


- (void)setObject:(id <NSCoding>)object forKey:(NSString *)key successBlock:(GJCFDiskCacheObjectBlock)successblock  failBlock:(GJCFDiskCacheErrorBlock)failBlock
{
    [self setObject:object forKey:key expire:gjcf_defaultByteLimit successBlock:successblock failBlock:failBlock];
}

- (void)setObject:(id <NSCoding>)object forKey:(NSString *)key  expire:(int)expire successBlock:(GJCFDiskCacheObjectBlock)successblock failBlock:(GJCFDiskCacheErrorBlock)failBlock
{
    if (!object || !key || key.length == 0 || expire < 0) {
        
        NSError *error = [NSError errorWithDomain:@"参数有误" code:1001 userInfo:nil];
        
        if (failBlock) {
            failBlock(self,error);
            return;
        }
    }
    
    
    __weak GJCFDiskCache *weakSelf = self;
    dispatch_async(mainQueue, ^{
        
        __strong GJCFDiskCache *strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        
        
        NSString *keyPath = [NSString stringWithFormat:@"%@/%@",cacheRootPath,key];
        
        BOOL isWrite = [GJCFFileStorage saveObject:object FilePath:keyPath];
        
        
        
        if (isWrite) {
            
            NSString *subKeyPath = [keyPath lastPathComponent];
            
            NSError *errorKey = nil;
            NSNumber *sizeNum = [GJCFFileStorage getFileSize:keyPath Error:&errorKey];
            if (!errorKey && [sizeNum intValue] != -1) {
                [strongSelf->mainSizes setObject:sizeNum forKey:subKeyPath];
                strongSelf->byteCount += [sizeNum intValue];
            }
            else
            {
                NSLog(@"%s %d read file size fail ",__FUNCTION__,__LINE__);
            }
            
            
            errorKey = nil;
            NSDate *modifyDate = [GJCFFileStorage getFileModDate:keyPath Error:&errorKey];
            
            if (!errorKey && modifyDate) {
                [strongSelf->mainDates setObject:modifyDate forKey:subKeyPath];
            }
            else
            {
                NSLog(@"%s %d read file modifyDate fail error %@",__FUNCTION__,__LINE__,errorKey.userInfo);
            }
            
            [mainExpires setObject:[NSNumber numberWithInt:expire] forKey:subKeyPath];
            [strongSelf saveExpire];
            [strongSelf trimDiskToSize:byteLimit];
            
            if (successblock) {
                successblock(strongSelf,key,object,keyPath);
            }
            
        }
        else
        {
            if (failBlock) {
                
                NSError *error = [NSError errorWithDomain:@"save file fail" code:1002 userInfo:nil];
                failBlock(strongSelf,error);
            }
        }
    });
}

- (void)getObject:(NSString *)key successBlock:(GJCFDiskCacheObjectBlock)successBlock failBlock:(GJCFDiskCacheErrorBlock)failBlock
{
    
    
    [self getObject:key isCareExpire:YES successBlock:successBlock failBlock:failBlock];
    
    
}


- (void)getObject:(NSString *)key isCareExpire:(BOOL)isCareExpire successBlock:(GJCFDiskCacheObjectBlock)successBlock failBlock:(GJCFDiskCacheErrorBlock)failBlock
{
    __weak GJCFDiskCache *weakSelf = self;
    dispatch_async(mainQueue, ^{
        
        __strong GJCFDiskCache *strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        
        NSString *keyPath = [NSString stringWithFormat:@"%@/%@",cacheRootPath,key];
        NSString *subKeyPath = [keyPath lastPathComponent];
        id obj = [GJCFFileStorage getObjcet:keyPath];
        if (obj) {
            NSNumber *expireNum = [mainExpires objectForKey:subKeyPath];
            NSDate *dateMod = [mainDates objectForKey:subKeyPath];
            if (expireNum || dateMod) {
                NSDate *now = [NSDate date];
                NSDate *expireDate = [dateMod dateByAddingTimeInterval:[expireNum intValue]];
                
                // 当前时间，晚于 过期时间，则文件过期
                if ([now compare:expireDate] == NSOrderedDescending && isCareExpire) {
                    
                    [mainDates removeObjectForKey:subKeyPath];
                    [mainExpires removeObjectForKey:subKeyPath];
                    [strongSelf saveExpire];
                    
                    if (failBlock) {
                        failBlock(strongSelf,nil);
                    }
                    
                }
                else
                {
                    if (successBlock) {
                        successBlock(strongSelf,key,obj,keyPath);
                    }
                }
                
            }
            else
            {
                if (failBlock) {
                    failBlock(strongSelf,nil);
                }
            }
            
        }
        else
        {
            if (failBlock) {
                failBlock(strongSelf,nil);
            }
        }
        
    });
    
}

- (id<NSCoding>)getObjectForKey:(NSString *)key
{
    
    __block id<NSCoding> obj = nil;
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    [self getObject:key successBlock:^(GJCFDiskCache *cache, NSString *key, id<NSCoding> object, NSString *filePath) {
        obj = object;
        dispatch_semaphore_signal(semaphore);
    } failBlock:^(GJCFDiskCache *cache, NSError *error) {
        dispatch_semaphore_signal(semaphore);
    }];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
#if !OS_OBJECT_USE_OBJC
    dispatch_release(semaphore);
#endif
    
    
    return obj;
}

- (void)removeObjectForKey:(NSString *)key successBlock:(GJCFDiskCacheBlock)successblock  failBlock:(GJCFDiskCacheErrorBlock)failBlock
{
    
    __weak GJCFDiskCache *weakSelf = self;
    dispatch_async(mainQueue, ^{
        __strong GJCFDiskCache *strongSelf = weakSelf;
        NSString *keyPath = [NSString stringWithFormat:@"%@/%@",cacheRootPath,key];
        if ([strongSelf deleteObjectCache:keyPath]) {
            if (successblock) {
                successblock(strongSelf);
            }
        }
        else
        {
            if (failBlock) {
                NSError *error= [NSError errorWithDomain:@"delete fill error" code:1003 userInfo:nil];
                failBlock(strongSelf,error);
            }
        }
    });
    
}

- (void)removeAllObjects:(GJCFDiskCacheBlock)successblock  failBlock:(GJCFDiskCacheErrorBlock)failBlock
{
    __weak GJCFDiskCache *weakSelf = self;
    dispatch_async(mainQueue, ^{
        __strong GJCFDiskCache *strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        
        
        
        BOOL isDelete = [GJCFFileStorage deleteFile:cacheRootPath];
        if (isDelete) {
            
            [GJCFFileStorage createDirectory:cacheRootPath];
            
            strongSelf->byteCount = 0;
            [strongSelf->mainDates removeAllObjects];
            [strongSelf->mainSizes removeAllObjects];
            
            [strongSelf->mainExpires removeAllObjects];
            
            [strongSelf saveExpire];
            
            if (successblock) {
                successblock(strongSelf);
            }
        }
        else
        {
            if (failBlock) {
                NSError *error= [NSError errorWithDomain:@"delete fill error" code:1003 userInfo:nil];
                failBlock(strongSelf,error);
            }
        }
    });
}

- (void)trimToDate:(NSDate *)date successBlock:(GJCFDiskCacheBlock)successblock  failBlock:(GJCFDiskCacheErrorBlock)failBlock
{
    __weak GJCFDiskCache *weakSelf = self;
    dispatch_async(mainQueue, ^{
        __strong GJCFDiskCache *strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        
        if ([strongSelf trimDiskToDate:date]) {
            if (successblock) {
                successblock(strongSelf);
            }
        }
        else
        {
            if (failBlock) {
                NSError *error= [NSError errorWithDomain:@"delete fill error" code:1003 userInfo:nil];
                failBlock(strongSelf,error);
            }
        }
    });
    
}
- (void)trimToSize:(NSUInteger)trimbyteCount successBlock:(GJCFDiskCacheBlock)successblock  failBlock:(GJCFDiskCacheErrorBlock)failBlock
{
    
    
    __weak GJCFDiskCache *weakSelf = self;
    dispatch_async(mainQueue, ^{
        __strong GJCFDiskCache *strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        
        if ([strongSelf trimDiskToSize:trimbyteCount]) {
            if (successblock) {
                successblock(strongSelf);
            }
            
        }
        else
        {
            if (failBlock) {
                NSError *error= [NSError errorWithDomain:@"delete fill error" code:1003 userInfo:nil];
                failBlock(strongSelf,error);
            }
        }
    });
}

/**
 *  按照文件大小，由大大小依次删除文件缓存，知道当前缓存实例占有本地缓存大小为指定大小（线程不安全）
 *
 *  @param trimbyteCount 指定大小
 *
 *  @return 返回是否成功
 */
- (BOOL)trimDiskToSize:(NSUInteger)trimbyteCount
{
    
    if (byteCount <= trimbyteCount) {
        return YES;
    }
    
    NSArray *keysSortedBySize = [mainSizes keysSortedByValueUsingSelector:@selector(compare:)];
    for (NSString *key in [keysSortedBySize reverseObjectEnumerator]) {
        
        
        NSString *keyPath = [NSString stringWithFormat:@"%@/%@",cacheRootPath,key];
        
        [self deleteObjectCache:keyPath];
        
        if (byteCount <= trimbyteCount) {
            break;
        }
    }
    
    return YES;
}

/**
 *  将某个时间之前保存的文件缓存都删除（线程不安全）
 *
 *  @param trimDate 指定时间
 *
 *  @return 删除之前是否成功
 */
- (BOOL)trimDiskToDate:(NSDate *)trimDate
{
    NSArray *keysSortedByDate = [mainDates keysSortedByValueUsingSelector:@selector(compare:)];
    
    for (NSString *key in [keysSortedByDate reverseObjectEnumerator]) { // oldest files first
        NSDate *accessDate = [mainDates objectForKey:key];
        if (!accessDate)
            continue;
        
        if ([accessDate compare:trimDate] == NSOrderedAscending) { // older than trim date
            
            
            NSString *keyPath = [NSString stringWithFormat:@"%@/%@",cacheRootPath,key];
            
            [self deleteObjectCache:keyPath];
        }
        else
        {
            break;
        }
    }
    
    return YES;
}

/**
 *  删除某个key所有的持久化缓存内存（包括过期时间，本地文件，文件大小等）
 *
 *  @param keyPath 缓存路径
 *
 *  @return 返回是否删除成功
 */
- (BOOL)deleteObjectCache:(NSString *)keyPath
{
    BOOL isDelete = [GJCFFileStorage deleteFile:keyPath];
    if (isDelete) {
        
        NSString *subKeyPath = [keyPath lastPathComponent];
        
        [mainDates removeObjectForKey:subKeyPath];
        NSNumber *sizeNum = [mainSizes objectForKey:subKeyPath];
        byteCount -= [sizeNum intValue];
        [mainSizes removeObjectForKey:subKeyPath];
//        [UDStorageHelper deleteObj:keyPath];
        [mainExpires removeObjectForKey:subKeyPath];
        
        [self saveExpire];
        return YES;
    }
    else
    {
        NSLog(@"%s %d read file modifyDate fail : %@",__FUNCTION__,__LINE__,keyPath);
        
        return NO;
    }
}

/**
 *  持久化过期时间字典
 *
 *  @return 返回是否成功
 */
- (BOOL)saveExpire
{
    NSString *cacheExpirePath = [NSString stringWithFormat:@"%@/%@",self.cacheRootPath,gjcf_expireFileName];
    BOOL isSaveExpire = [GJCFFileStorage saveDict:mainExpires FilePath:cacheExpirePath];
    if (!isSaveExpire) {
        NSLog(@"%s %d save expires fail expireUrl : %@",__FUNCTION__,__LINE__,cacheExpirePath);
        return NO;
    }
    return YES;
}

@end
