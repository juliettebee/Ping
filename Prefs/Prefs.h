#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>
#import <Cephei/HBPreferences.h>	

@interface JuliettePingPreferences : PSListController
@end

@interface JuliettePingBackgroundSettings : PSListController
@property (retain, nonatomic) NSMutableArray *topBottomSpecifiers;
-(void) setPreferenceValue:(id)value forSpecifier:(PSSpecifier*)specifier;
@end

@interface JuliettePingActionSettings : PSListController
@end

HBPreferences *preferences;
