#import "Tweak/Tweak.h"

%group Ping
    %hook NCNotificationShortLookViewController
        -(void)viewDidLoad {
            %orig;         
            NCNotificationShortLookView *shortLookView = self.view.subviews[0].subviews[0].subviews[0];
            // MARK: Properties
            UIView *background = shortLookView.subviews[0];
            // Header
            
            
        }
    %end
%end
%ctor {
    %init(Ping)
}
