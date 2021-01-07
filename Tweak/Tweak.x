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
        
            // ===========
            // Preferences
            // ===========
            [preferences registerBool:&mtmaterialViewBlurEnabled default:YES forKey:@"mtmaterialViewBlurEnabled"];
            [preferences registerBool:&transparentBackground default:NO forKey:@"allTransparent"];

            [preferences registerFloat:&backgroundR default:0 forKey:@"backgroundR"];
            [preferences registerFloat:&backgroundG default:0 forKey:@"backgroundG"];
            [preferences registerFloat:&backgroundB default:0 forKey:@"backgroundB"];
            [preferences registerFloat:&notificationAllRadius default:0 forKey:@"notificationAllRadius"];
            // Applying
            background.blurEnabled = mtmaterialViewBlurEnabled;
            background.backgroundColor = [UIColor colorWithRed:backgroundR green:backgroundG blue:backgroundB alpha:1];            
            self.view.layer.masksToBounds = true;
            background.hidden = transparentBackground; 
        } 
   %end
%end
%ctor {
    // Seeing if tweak is enabled
    preferences  = [[HBPreferences alloc] initWithIdentifier:@"page.juliette.Ping.Prefs"];
    BOOL enabled;
    [preferences registerBool:&enabled default:YES forKey:@"Enabled"];

    if (enabled)
        %init(Ping)
}
