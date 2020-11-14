#import "Tweak/Tweak.h"

%group Ping
    %hook NCNotificationShortLookViewController
        -(void)viewDidLoad {
            NSLog(@"Im alive");
            %orig;         
            NCNotificationShortLookView *shortLookView = self.view.subviews[0].subviews[0].subviews[0];
            // =========
            // Variables
            // ========
        
            // Background
            MTMaterialView *background = shortLookView.subviews[0];

            // MARK: HEADER
            PLPlatterViewHeaderContentView *headerContainer = shortLookView.subviews[1];
            UILabel *appName = headerContainer.subviews[0];
            UIImage *appIcon = headerContainer.icons[1];
        } 
    %end
%end
%ctor {
    %init(Ping)
}
