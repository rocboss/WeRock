//
//  WRTopicCell.m
//  WeRock
//
//  Created by ZYVincent on 15/4/30.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import "WRTopicCell.h"
#import "GJCFCachePathManager.h"

#define WRTopicCellBaseImageViewTag 987900

@interface WRTopicCell ()

@property (nonatomic,strong)UIImageView *backgroundImageView;

@property (nonatomic,strong)GJCFCoreTextContentView *titleLabel;

@property (nonatomic,strong)GJCFCoreTextContentView *timeLabel;

@property (nonatomic,strong)GJCFCoreTextContentView *summaryLabel;

@property (nonatomic,strong)GJCFCoreTextContentView *commentCountLabel;

@property (nonatomic,strong)GJCFCoreTextContentView *nameLabel;

@property (nonatomic,strong)UIImageView *isTopTagView;

@property (nonatomic,strong)WRHeadView *headView;

@property (nonatomic,assign)CGFloat cellBoardMargin;

@property (nonatomic,assign)CGFloat contentInnerMargin;

@property (nonatomic,assign)CGFloat headContentMargin;

@property (nonatomic,assign)CGFloat headViewWidth;

@property (nonatomic,assign)CGFloat contentViewWidth;

@property (nonatomic,assign)CGFloat summaryMaxHeight;

@property (nonatomic,assign)CGFloat contentImageMargin;

@end

@implementation WRTopicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.cellBoardMargin = 8.f;
        self.contentInnerMargin = 11.f;
        self.headContentMargin = 8.f;
        self.headViewWidth = 35;
        self.summaryMaxHeight = 40;
        self.contentImageMargin = 5.f;
        
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CGFloat titleContentMaxWidth = GJCFSystemScreenWidth - 2*self.cellBoardMargin - 2*self.contentInnerMargin;
        CGFloat summaryContentMaxWidth = titleContentMaxWidth;
        self.contentViewWidth = (summaryContentMaxWidth - 2*self.contentImageMargin)/3;
        
        self.backgroundImageView = [[UIImageView alloc]init];
        self.backgroundImageView.gjcf_width = GJCFSystemScreenWidth - 2*self.cellBoardMargin;
        self.backgroundImageView.gjcf_top = self.cellBoardMargin;
        self.backgroundImageView.gjcf_left = self.cellBoardMargin;
        self.backgroundImageView.userInteractionEnabled = YES;
        UIImage *normalBack = [UIImage imageNamed:@"cell_n"];
        CGFloat width = normalBack.size.width;
        CGFloat height = normalBack.size.height;
        self.backgroundImageView.image = GJCFImageResize(normalBack,height/2-1, height/2+1, width/2-1, width/2+1);
        self.backgroundImageView.highlightedImage = GJCFImageResize([UIImage imageNamed:@"cell_s"], height/2-1, height/2+1, width/2-1, width/2+1);
        [self.contentView addSubview:self.backgroundImageView];
        
        self.titleLabel = [[GJCFCoreTextContentView alloc]init];
        self.titleLabel.contentBaseSize = CGSizeMake(titleContentMaxWidth, 20);
        [self.backgroundImageView addSubview:self.titleLabel];
        
        self.timeLabel = [[GJCFCoreTextContentView alloc]init];
        self.timeLabel.contentBaseSize = CGSizeMake(titleContentMaxWidth - 2*self.headContentMargin - self.headViewWidth, 10);
        [self.backgroundImageView addSubview:self.timeLabel];
        
        self.headView = [[WRHeadView alloc]init];
        self.headView.gjcf_left = self.contentInnerMargin;
        self.headView.gjcf_top = self.headContentMargin;
        self.headView.gjcf_width = self.headViewWidth;
        self.headView.gjcf_height = self.headViewWidth;
        self.headView.layer.cornerRadius = 5.f;
        self.headView.layer.masksToBounds = YES;
        [self.backgroundImageView addSubview:self.headView];
        
        self.nameLabel = [[GJCFCoreTextContentView alloc]init];
        self.nameLabel.contentBaseSize = CGSizeMake(titleContentMaxWidth - 2*self.headContentMargin - self.headViewWidth - 64,20);
        [self.backgroundImageView addSubview:self.nameLabel];
        
        self.summaryLabel = [[GJCFCoreTextContentView alloc]init];
        self.summaryLabel.gjcf_size = CGSizeMake(summaryContentMaxWidth, self.summaryMaxHeight);
        self.summaryLabel.contentBaseSize = CGSizeMake(summaryContentMaxWidth, self.summaryMaxHeight);
        [self.backgroundImageView addSubview:self.summaryLabel];
        
        self.commentCountLabel = [[GJCFCoreTextContentView alloc]init];
        self.commentCountLabel.contentBaseSize = self.timeLabel.contentBaseSize;
        [self.backgroundImageView addSubview:self.commentCountLabel];
        
        self.isTopTagView = [[UIImageView alloc]init];
        [self.backgroundImageView addSubview:self.isTopTagView];
        
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    
    [self.backgroundImageView setHighlighted:highlighted];
}

- (void)setcontentModel:(WRTopicContentModel *)topic
{
    [self.headView setHeadUrl:topic.headUrl];
    
    CGSize nameSize = [GJCFCoreTextContentView contentSuggestSizeWithAttributedString:topic.nameString forBaseContentSize:self.nameLabel.contentBaseSize];
    self.nameLabel.gjcf_size = nameSize;
    self.nameLabel.gjcf_top = self.headView.gjcf_top + 1.5f;
    self.nameLabel.gjcf_left = self.headView.gjcf_right + self.headContentMargin;
    self.nameLabel.contentAttributedString = topic.nameString;
    
    CGSize timeSize = [GJCFCoreTextContentView contentSuggestSizeWithAttributedString:topic.timeString forBaseContentSize:self.timeLabel.contentBaseSize];
    self.timeLabel.gjcf_size = timeSize;
    self.timeLabel.contentAttributedString = topic.timeString;
    self.timeLabel.gjcf_left = self.nameLabel.gjcf_left;
    self.timeLabel.gjcf_bottom = self.headView.gjcf_bottom;

    NSLog(@"timeSize :%@",NSStringFromCGSize(timeSize));

    CGSize titleSize = [GJCFCoreTextContentView contentSuggestSizeWithAttributedString:topic.titleString forBaseContentSize:self.titleLabel.contentBaseSize];
    self.titleLabel.gjcf_size = titleSize;
    self.titleLabel.gjcf_left = self.headView.gjcf_left;
    self.titleLabel.gjcf_top = self.headView.gjcf_bottom + self.contentInnerMargin;
    self.titleLabel.contentAttributedString = topic.titleString;

    CGSize summarySize = [GJCFCoreTextContentView contentSuggestSizeWithAttributedString:topic.summaryString forBaseContentSize:self.summaryLabel.contentBaseSize];
    self.summaryLabel.gjcf_size = CGSizeMake(self.summaryLabel.gjcf_width, MIN(summarySize.height, self.summaryMaxHeight));
    self.summaryLabel.gjcf_left = self.titleLabel.gjcf_left;
    self.summaryLabel.gjcf_top = self.titleLabel.gjcf_bottom + self.headContentMargin;
    self.summaryLabel.contentAttributedString = topic.summaryString;
    
    CGFloat contentImageBottom = self.summaryLabel.gjcf_bottom;
    if (topic.picArray.count > 0 ) {
        
        for (NSInteger index = 0 ; index < MIN(topic.picArray.count, 3); index++) {
            
            GJCUAsyncImageView *imageView = (GJCUAsyncImageView *)[self.backgroundImageView viewWithTag:WRTopicCellBaseImageViewTag + index];
            
            if (!imageView) {
                imageView = [[GJCUAsyncImageView alloc]init];
                imageView.gjcf_size = CGSizeMake(self.contentViewWidth, self.contentViewWidth);
                imageView.tag = WRTopicCellBaseImageViewTag + index;
                [self.backgroundImageView addSubview:imageView];
                imageView.contentMode = UIViewContentModeScaleAspectFill;
                imageView.clipsToBounds = YES;
            }
            imageView.image = [UIImage imageNamed:@"image_hold"];
            imageView.gjcf_left = self.titleLabel.gjcf_left + self.contentViewWidth * index + self.contentImageMargin*index;
            imageView.gjcf_top = self.summaryLabel.gjcf_bottom + self.headContentMargin;
            contentImageBottom = imageView.gjcf_bottom;
            
            //有缓存图片就显示
            BOOL isCached = [[GJCFCachePathManager shareManager] mainImageCacheFileIsExistForUrl:[topic.picArray objectAtIndex:index]];
            if (isCached) {
                [imageView setUrl:[topic.picArray objectAtIndex:index]];
            }
        }
        
        //隐藏用不上的
        if (topic.picArray.count < 3) {
            
            for (GJCUAsyncImageView *imageView in self.backgroundImageView.subviews) {
                
                if ([imageView.class isSubclassOfClass:[GJCUAsyncImageView class]]) {
                    
                    if (imageView.tag > WRTopicCellBaseImageViewTag+topic.picArray.count-1) {
                        
                        imageView.hidden = YES;
                    }
                }
            }
        }
    }else{
        
        for (NSInteger index = 0 ; index < MIN(topic.picArray.count, 3); index++) {

            GJCUAsyncImageView *imageView = (GJCUAsyncImageView *)[self.backgroundImageView viewWithTag:WRTopicCellBaseImageViewTag + index];
            imageView.hidden = YES;
        }
    }
    
    CGSize replyCountSize = [GJCFCoreTextContentView contentSuggestSizeWithAttributedString:topic.replyCountString forBaseContentSize:self.commentCountLabel.contentBaseSize];
    
    self.commentCountLabel.gjcf_top = self.headView.gjcf_top;
    self.commentCountLabel.gjcf_size = replyCountSize;
    self.commentCountLabel.gjcf_right = self.backgroundImageView.gjcf_width - self.contentInnerMargin;
    self.commentCountLabel.contentAttributedString = topic.replyCountString;
    
    self.backgroundImageView.gjcf_height = contentImageBottom + self.headContentMargin;
}

- (CGFloat)contentHeight
{
    return self.backgroundImageView.gjcf_bottom;
}

- (void)downloadImage:(NSArray *)imageUrls
{
    for (NSInteger index = 0 ; index < imageUrls.count; index++) {
        
        GJCUAsyncImageView *imageView = (GJCUAsyncImageView *)[self.backgroundImageView viewWithTag:WRTopicCellBaseImageViewTag + index];
        
        [imageView setUrl:imageUrls[index]];
    }
}

@end
