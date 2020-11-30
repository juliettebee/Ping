#import <UIKit/UIKit.h>

@interface NCNotificationShortLookViewController : UIViewController 
@end

@interface NCNotificationShortLookView : UIView
    @property (nonatomic,copy) NSString * title;
    @property (nonatomic,copy) NSString * primaryText;
    @property (nonatomic,copy) NSString * primarySubtitleText;
    @property (nonatomic,copy) NSString * secondaryText;
@end

// TODO: Check out this class
// https://developer.limneos.net/index.php?ios=13.1.3&framework=MaterialKit.framework&header=MTMaterialView.h
@interface MTMaterialView : UIView
@property (assign,getter=isBlurEnabled,nonatomic) BOOL blurEnabled; 
@end

@interface PLPlatterHeaderContentView : UIView 
@property (getter=_titleLabel,nonatomic,readonly) UILabel * titleLabel; 
@property (getter=_dateLabel,nonatomic,readonly) UILabel * dateLabel; 
@property (nonatomic,readonly) NSArray * iconButtons; // [0] is the app icon - if there is one 
@property (nonatomic,copy) NSString * title; // App name
@end

@interface BSUIEmojiLabelView : UIView 
@end

@interface NCNotificationContentView : UIView
@property (setter=_setPrimaryLabel:,getter=_primaryLabel,nonatomic,retain) UILabel * primaryLabel;  // Alert title
@property (setter=_setPrimarySubtitleLabel:,getter=_primarySubtitleLabel,nonatomic,retain) UILabel * primarySubtitleLabel;  // Unknown
@property (setter=_setSummaryLabel:,getter=_summaryLabel,nonatomic,retain) BSUIEmojiLabelView * summaryLabel;                           //The X amount of notifications from this app label
// TODO: Secondary label
@end

