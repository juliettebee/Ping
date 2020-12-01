#import "Prefs.h"

@implementation JuliettePingPreferences
    // Switch to enable/disable tweak
    -(instancetype)init {
        self = [super init];
        
        if (self) {
            UISwitch *enableTweak = [[UISwitch alloc] init];
            enableTweak.onTintColor = [UIColor colorWithRed: 0.99 green: 0.81 blue: 0.87 alpha: 1.00];
            [enableTweak setOn:true animated:NO];
            // Setup for response to switch update
            [enableTweak addTarget:self action:@selector(tweakStatus:) forControlEvents:UIControlEventValueChanged];
            UIBarButtonItem* switchAsAnUIBarButtonItemBecauseThatsANeededThingAndCausesCrashesIfItIsntLikeThis= [[UIBarButtonItem alloc] initWithCustomView: enableTweak];
            self.navigationItem.rightBarButtonItem = switchAsAnUIBarButtonItemBecauseThatsANeededThingAndCausesCrashesIfItIsntLikeThis;
        }
        return self;
    }

    - (NSArray *)specifiers {
        if (!_specifiers)
            _specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
        return _specifiers;
    }

    -(void)tweakStatus:(id)sender {
        BOOL state = [sender isOn];
        // Disable tweak
        HBPreferences *preferences  = [[HBPreferences alloc] initWithIdentifier:@"page.juliette.Ping.Prefs"];
        [preferences registerDefaults:@{
            @"Enabled": @(state),
        }];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"page.juliette.Ping.Prefs/reloadprefs" object:nil];
    }
@end
