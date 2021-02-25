#import <UIKit/UIKit.h>
#import <Cephei/HBPreferences.h>	
#import <Cephei/UIColor+HBAdditions.h>

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

@interface NCNotificationListCellActionButton : UIView 
@property (nonatomic,retain) MTMaterialView * backgroundView;  
@property (nonatomic,retain) UILabel * titleLabel;
@end

HBPreferences *preferences;
BOOL mtmaterialViewBlurEnabled;
CGFloat notificationAllRadius;
NSString *backgroundColor;
BOOL transparentBackground;
BOOL customSideRadius; 
BOOL actionMtmaterialViewBlurEnabled;  
NSString *actionBackgroundColor;
