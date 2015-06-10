//
//  WRTopicReplyFloorCell.m
//  WeRock
//
//  Created by ZYVincent on 15/5/4.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import "WRTopicReplyFloorCell.h"

@interface WRTopicReplyFloorCell ()

@property (nonatomic,strong)GJCFCoreTextContentView *contentLabel;

@property (nonatomic,assign)CGFloat contentInnerMargin;

@property (nonatomic,assign)CGFloat headContentMargin;

@property (nonatomic,assign)CGFloat headViewWidth;

@end

@implementation WRTopicReplyFloorCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentInnerMargin = 13.f;
        self.headViewWidth = 35.f;
        self.headContentMargin = 8.f;
        
        
        CGFloat contentMaxWidth = GJCFSystemScreenWidth - self.headContentMargin - self.headViewWidth - 2*self.contentInnerMargin;
        CGFloat leftMargin = self.headViewWidth + self.contentInnerMargin + self.headContentMargin;

        self.contentLabel = [[GJCFCoreTextContentView alloc]init];
        self.contentLabel.gjcf_top = self.headContentMargin;
        self.contentLabel.contentBaseWidth = contentMaxWidth;
        self.contentLabel.contentBaseHeight = 10;
        self.contentLabel.gjcf_left = leftMargin;
        [self.contentView addSubview:self.contentLabel];
        
    }
    return self;
}

- (void)setFloor:(WRTopicReplyFloorContentModel *)contentModel
{
    
    CGSize floorSize = [GJCFCoreTextContentView contentSuggestSizeWithAttributedString:contentModel.contentString forBaseContentSize:self.contentLabel.contentBaseSize];
    self.contentLabel.gjcf_size = floorSize;
    self.contentLabel.contentAttributedString = contentModel.contentString;

}

- (CGFloat)contentHeight
{
    return self.contentLabel.gjcf_bottom + self.headContentMargin;
}

@end
