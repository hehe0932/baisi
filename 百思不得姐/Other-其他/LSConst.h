
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,TopicType){
    topicTypeAll = 1,
    topicTypePicture = 10,
    topicTypeVoice = 31,
    topicTypeVideo = 41,
    topicTypeWord = 29
};
/** 精华-顶部标题的高度*/
UIKIT_EXTERN CGFloat const titlesViewH;
/** 精华-顶部标题的Y*/
UIKIT_EXTERN CGFloat const titlesViewY;

/** 精华-cell里的间距*/
UIKIT_EXTERN CGFloat const topicCellMargin;
/** 精华-cell里文字内容Y*/
UIKIT_EXTERN CGFloat const topicCellTextY;
/** 精华-cell-底部工具条的高度*/
UIKIT_EXTERN CGFloat const topicCellBottomBarH;
/** 精华-cell-图片帖子的最大高度*/
UIKIT_EXTERN CGFloat const topicCellPictureMaxH;
/** 精华-cell-图片帖子一旦超过高度,就使用BreakH*/
UIKIT_EXTERN CGFloat const topicCellPictureBreakH;

/** LSUser模型-性别属性*/
UIKIT_EXTERN NSString * const LSUserSexMale;
UIKIT_EXTERN NSString * const LSUserSexFemale;

/** 精华-cell-最热评论标题的高度*/
UIKIT_EXTERN CGFloat const LSTopicCellTopCmtTitleH;
