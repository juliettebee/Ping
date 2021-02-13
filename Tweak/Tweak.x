#import "Tweak.h"

%group Ping
    %hook NCNotificationShortLookViewController
        -(void)viewDidLoad {
            %orig;         
            NCNotificationShortLookView *shortLookView = self.view.subviews[0].subviews[0].subviews[0];
            // =========
            // Variables
            // ======== 
            
            MTMaterialView *background = shortLookView.subviews[0];
            // Header
            PLPlatterHeaderContentView *header = shortLookView.subviews[1];  
            // Content
            NCNotificationContentView *content = shortLookView.subviews[2].subviews[0];
        
            // Applying
            background.blurEnabled = mtmaterialViewBlurEnabled;
            if (![backgroundColor isEqual:@""])                 
                background.backgroundColor = [UIColor hb_colorWithPropertyListValue:backgroundColor];
            background.hidden = transparentBackground; 
            self.view.layer.masksToBounds = true; // This is needed for custom radius
        } 
  %end
%end
%ctor {
// Seeing if tweak is enabled
    preferences  = [[HBPreferences alloc] initWithIdentifier:@"page.juliette.Ping.Prefs"];
    BOOL enabled;
    [preferences registerBool:&enabled default:YES forKey:@"Enabled"];

    // ===========
    // Preferences
    // ===========
    [preferences registerBool:&mtmaterialViewBlurEnabled default:YES forKey:@"mtmaterialViewBlurEnabled"];
    [preferences registerBool:&transparentBackground default:NO forKey:@"allTransparent"];
    [preferences registerObject:&backgroundColor default:@"" forKey:@"backgroundColor"];
    [preferences registerFloat:&notificationAllRadius default:0 forKey:@"notificationAllRadius"];
    if (enabled)
        %init(Ping)
}
