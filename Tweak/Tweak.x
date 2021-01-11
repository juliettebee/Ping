#import "Tweak.h"

%group Ping
    %hook NCNotificationShortLookViewController
        -(void)viewDidLoad {
            NSLog(@"Im alive");
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
            background.backgroundColor = [UIColor colorWithRed:backgroundR green:backgroundG blue:backgroundB alpha:1];            
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

    [preferences registerFloat:&backgroundR default:0 forKey:@"backgroundR"];
    [preferences registerFloat:&backgroundG default:0 forKey:@"backgroundG"];
    [preferences registerFloat:&backgroundB default:0 forKey:@"backgroundB"];
    [preferences registerFloat:&notificationAllRadius default:0 forKey:@"notificationAllRadius"];
    if (enabled)
        %init(Ping)
}
