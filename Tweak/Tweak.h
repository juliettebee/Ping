#import <UIKit/UIKit.h>

@interface NCNotificationShortLookViewController : UIViewController 
@end

@interface NCNotificationShortLookView : UIView
    @property (nonatomic,copy) NSString * title;
    @property (nonatomic,copy) NSString * primaryText;
    @property (nonatomic,copy) NSString * primarySubtitleText;
    @property (nonatomic,copy) NSString * secondaryText;
@end


