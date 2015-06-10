//
//  WRHttpConstants.m
//  WeRock
//
//  Created by ZYVincent on 15/4/27.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import "WRHttpConstants.h"


@implementation WRHttpConstants

+ (NSString *)requestTypeToInterface:(WRHttpRequestType)requestType
{    
    NSString *interface = nil;
    
    switch (requestType) {
            
        case WRHttpRequestTypeUserRegist:
            
            interface = @"mobileUser/register";

            break;
        
        case WRHttpRequestTypeUserLogin:
            
            interface = @"mobileUser/login";
            
            break;
            
        case WRHttpRequestTypeUserFans:
            
            interface = @"mobileUser/fans";
            
            break;
        
        case WRHttpRequestTypeUserFollow:
            
            interface = @"mobileUser/follow";
            
            break;
        case WRHttpRequestTypeUserDetail:
            
            interface = @"mobileUser/userDetailInfo";
            
            break;
        case WRHttpRequestTypeUserTopics:
            
            interface = @"mobileUser/topics";
            
            break;
        case WRHttpRequestTypeUserReply:
            
            interface = @"mobileUser/reply";
            
            break;
        case WRHttpRequestTypeUserWhisper:
            
            interface = @"mobileUser/whisper";
            
            break;
        case WRHttpRequestTypeUserRegistDevice:
            
            interface = @"mobileUser/registDevice";
            
            break;
        case WRHttpRequestTypeUserNotification:
            
            interface = @"mobileUser/notification";
            
            break;
        case WRHttpRequestTypeUserApplyLockTopic:
            
            interface = @"mobileUser/applyLockTopic";
            
            break;
        case WRHttpRequestTypeUserApplyLockAction:
            
            interface = @"mobileUser/applyLockAction";
            
            break;
        case WRHttpRequestTypeDoDeleteTopic:
            
            interface = @"mobileDo/deleteTopic";
            
            break;
        case WRHttpRequestTypeDoDeliverWhisper:
            
            interface = @"mobileDo/deliverWhisper";
            
            break;
        case WRHttpRequestTypeDoFavorTopic:
            
            interface = @"mobileDo/favorTopic";
            
            break;
        case WRHttpRequestTypeDoFollow:
            
            interface = @"mobileDo/follow";
            
            break;
        case WRHttpRequestTypeDoPostFloor:
            
            interface = @"mobileDo/postFloor";
            
            break;
        case WRHttpRequestTypeDoPostReply:
            
            interface = @"mobileDo/postReply";
            
            break;
        case WRHttpRequestTypeDoPostTopic:
            
            interface = @"mobileDo/postTopic";
            
            break;
        case WRHttpRequestTypeDoPraiseTopic:
            
            interface = @"mobileDo/praiseTopic";
            
            break;
        case WRHttpRequestTypeDoSetSign:
            
            interface = @"mobileDo/setSignature";
            
            break;
        case WRHttpRequestTypeDoSign:
            
            interface = @"mobileDo/doSign";
            
            break;
        case WRHttpRequestTypeUploadAvatar:
            
            interface = @"mobileDo/uploadAvatar";
            
            break;
        case WRHttpRequestTypeUploadHomeBackTheme:
            
            interface = @"mobileDo/uploadHomeThemeBack";
            
            break;
        case WRHttpRequestTypeUploadPicture:
            
            interface = @"mobileDo/uploadPicture";
            
            break;
        case WRHttpRequestTypeHomeGetHotTags:
            
            interface = @"mobileHome/getHotTags";
            
            break;
        case WRHttpRequestTypeHomeGetHotTopics:
            
            interface = @"mobileHome/getHotTopics";
            
            break;
            
        case WRHttpRequestTypeHomeGetReplyList:
            
            interface = @"mobileHome/getReplyList";
            
            break;
        case WRHttpRequestTypeHomeGetReplyFloorList:
            
            interface = @"mobileHome/getReplyFloorList";
            
            break;
        case WRHttpRequestTypeHomeGetTodayTopSign:
            
            interface = @"mobileHome/getTodayTopSign";
            
            break;
        case WRHttpRequestTypeHomeIndex:
            
            interface = @"mobileHome/index";
            
            break;
        case WRHttpRequestTypeHomeRead:
            
            interface = @"mobileHome/read";
            
            break;
        case WRHttpRequestTypeHomeSearch:
            
            interface = @"mobileHome/search";
            
            break;
        case WRHttpRequestTypeHomeTag:
            
            interface = @"mobileHome/tag";
            
            break;
        case WRHttpRequestTypeManagerTopTopic:
            
            interface = @"mobileManage/topTopic";
            
            break;
        case WRHttpRequestTypeManagerLockTopic:
            
            interface = @"mobileManage/lockTopic";
            
            break;
        case WRHttpRequestTypeAdminSearchUser:
            
            interface = @"mobileAdmin/searchUser";
            
            break;
        case WRHttpRequestTypeAdminLockUser:
            
            interface = @"mobileAdmin/lockUserAction";
            
            break;
        case WRHttpRequestTypeAdminTopicApplyList:
            
            interface = @"mobileAdmin/topicApplyList";
            
            break;
        case WRHttpRequestTypeAdminUserApplyList:
            
            interface = @"mobileAdmin/userApplyList";
            
            break;
        
            
        default:
            break;
    }
    
    return interface;
}

@end
