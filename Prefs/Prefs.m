#import "Prefs.h"

@implementation JuliettePingPreferences
    // Switch to enable/disable tweak
    -(instancetype)init {
        self = [super init];
        
        if (self) {
            UISwitch *enableTweak = [[UISwitch alloc] init];
            enableTweak.onTintColor = [UIColor colorWithRed: 0.99 green: 0.81 blue: 0.87 alpha: 1.00];
            // Seeing if tweak is on so we can set the status of the switch correctly
            preferences  = [[HBPreferences alloc] initWithIdentifier:@"page.juliette.Ping.Prefs"];
            BOOL enabled;
            [preferences registerBool:&enabled default:YES forKey:@"Enabled"];
            [enableTweak setOn:enabled animated:NO];
            // Setup for response to switch update
            [enableTweak addTarget:self action:@selector(tweakStatus:) forControlEvents:UIControlEventValueChanged];
            UIBarButtonItem* switchAsAnUIBarButtonItemBecauseThatsANeededThingAndCausesCrashesIfItIsntLikeThis= [[UIBarButtonItem alloc] initWithCustomView: enableTweak];
            self.navigationItem.rightBarButtonItem = switchAsAnUIBarButtonItemBecauseThatsANeededThingAndCausesCrashesIfItIsntLikeThis;
            // Colors!
            HBAppearanceSettings *appearanceSettings = [[HBAppearanceSettings alloc] init];
            appearanceSettings.tintColor = [UIColor colorWithRed: 0.99 green: 0.81 blue: 0.87 alpha: 1.00];
            self.hb_appearanceSettings = appearanceSettings;
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
        preferences  = [[HBPreferences alloc] initWithIdentifier:@"page.juliette.Ping.Prefs"];
        [preferences setBool:state forKey:@"Enabled"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"page.juliette.Ping.Prefs/reloadprefs" object:nil];
    }

    - (void) respringAction {
        [HBRespringController respring];
    }

    
@end
