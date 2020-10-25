#import "Tweak.h"

%hook NCNotificiationShortLookViewController 
    - (void)viewDidLoad { // viewDidLoad instead of layoutSubviews as layoutSubviews is called multiple times and logic should not be there
        %orig;
        UIView *controllerView = [self view];
        NCNotificationShortLookView *shortLookView = controllerView.subviews[0].subviews[0].subviews[0];
        // Properties
        UIView *background = shortLookView.subviews[0];
   }
%end

