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
            if (![backgroundColor isEqual:@""]) // Only setting color if theres a value 
                background.backgroundColor = [UIColor hb_colorWithPropertyListValue:backgroundColor];
            
            if (transparentBackground)
                background.backgroundColor = [UIColor clearColor];

            self.view.layer.masksToBounds = true; // This is needed for custom radius
            if (!customSideRadius) 
                // Only apply radius to all the sides
                self.view.layer.cornerRadius = notificationAllRadius; 
            
            if (topAndBottomDifferent) {
                // So the problem with this approach is that radius no longer works & icon location is a bit weird but it works! 
                background.opaque = NO; 
                header.backgroundColor = [UIColor hb_colorWithPropertyListValue:topBackgroundColor];
                content.backgroundColor = [UIColor hb_colorWithPropertyListValue:bottomBackgroundColor];
            }
    
            // Setting border 
            background.layer.borderColor = [[UIColor hb_colorWithPropertyListValue:borderColor] CGColor];
            background.layer.borderWidth = borderWidth;

        } 
    %end
    %hook NCNotificationListCellActionButton 
        -(void)didMoveToWindow { // I would prefer to use a UIViewController instead of an UIView, but there is no UIViewControl that makes sense to use :(
            MTMaterialView *background = self.backgroundView;
            background.blurEnabled = actionMtmaterialViewBlurEnabled;
            background.hidden = actionTransparentBackground;
            if (![actionBackgroundColor isEqual:@""]) {
                // We need to hide the background view in order to use our custom background color
                background.hidden = YES;
                self.backgroundColor = [UIColor hb_colorWithPropertyListValue:actionBackgroundColor];
            }
            %orig;
        }
    %end
%end
%ctor {
    // Seeing if tweak is enabled
    preferences  = [[HBPreferences alloc] initWithIdentifier:@"page.juliette.Ping.Prefs"];
    BOOL enabled;
    [preferences registerBool:&enabled default:YES forKey:@"Enabled"];
    if (!enabled)
        return;
    // ===========
    // Preferences
    // ===========
    [preferences registerBool:&mtmaterialViewBlurEnabled default:YES forKey:@"mtmaterialViewBlurEnabled"];
    [preferences registerBool:&actionMtmaterialViewBlurEnabled default:YES forKey:@"actionMtmaterialViewBlurEnabled"];
    [preferences registerBool:&transparentBackground default:NO forKey:@"allTransparent"];
    [preferences registerObject:&backgroundColor default:@"" forKey:@"backgroundColor"];
    [preferences registerObject:&actionBackgroundColor default:@"" forKey:@"actionBackGroundColor"];
    [preferences registerObject:&topBackgroundColor default:@"" forKey:@"topBackgroundColor"];
    [preferences registerObject:&bottomBackgroundColor default:@"" forKey:@"bottomBackgroundColor"];
    [preferences registerBool:&topAndBottomDifferent default:NO forKey:@"topAndBottomDifferent"];
    [preferences registerFloat:&notificationAllRadius default:0 forKey:@"notificationAllRadius"];
    [preferences registerBool:&customSideRadius default:NO forKey:@"customSideRadius"];
    [preferences registerObject:&borderColor default:@"" forKey:@"borderColor"];
    [preferences registerInteger:&borderWidth default:0 forKey:@"borderWidth"];
    [preferences registerBool:&actionTransparentBackground default:NO forKey:@"actionTransparentBackground"];

    if (enabled)
        %init(Ping)
}
