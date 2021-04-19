#include "Tweak.h"

@implementation JuliettePingHelperClass 
    - (void) reloadPrefs {
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
        [preferences registerBool:&headerShowTitle default:YES forKey:@"headerShowTitle"];
        [preferences registerBool:&headerShowDate default:YES forKey:@"headerShowDate"];

    }
@end
