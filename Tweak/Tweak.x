#import "Tweak/Tweak.h"

%group Ping
    %hook NCNotificationShortLookViewController
        -(void)viewDidLoad {
            NSLog(@"Im alive");
            %orig;         
            // Get prefs
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
            background.blurEnabled = mtmaterialViewBlurEnabled;

            // Testing
            [header.titleLabel setHidden:YES];
            [header.dateLabel setHidden:YES];
            [content.primaryLabel setHidden:YES];
            [content.primarySubtitleLabel setHidden:YES];
            [content.summaryLabel setHidden:YES];
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
