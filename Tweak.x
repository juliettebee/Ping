#import "Tweak.h"

%hook NCNotificationViewController
    - (void)viewDidLoad {
        %orig;
    }
%end
