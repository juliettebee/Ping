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
            
            MTMaterialView *background = shortLookView.subviews[0];
            // Header
            PLPlatterHeaderContentView *header = shortLookView.subviews[1];  
            // Content
            NCNotificationContentView *content = shortLookView.subviews[2].subviews[0];
        
            // Testing
            [header.titleLabel setHidden:YES];
            [header.dateLabel setHidden:YES];
            [content.primaryLabel setHidden:YES];
            [content.primarySubtitleLabel setHidden:YES];
            [content.summaryLabel setHidden:YES];
            background.blurEnabled = NO;
        } 
    %end
%end
%ctor {
    %init(Ping)
}
