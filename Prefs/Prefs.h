#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>
#import <Cephei/HBPreferences.h>	
#import <Cephei/HBRespringController.h>
#import <CepheiPrefs/HBRootListController.h>
#import <CepheiPrefs/HBAppearanceSettings.h>


@interface JuliettePingPreferences : HBRootListController 
- (void) tweakStatus:(id)sender;
- (void) respringAction;
@end

@interface JuliettePingBackgroundSettings : PSListController
@property (retain, nonatomic) NSMutableArray *topBottomSpecifiers;
-(void) setPreferenceValue:(id)value forSpecifier:(PSSpecifier*)specifier;
@end

@interface JuliettePingActionSettings : PSListController
@end

HBPreferences *preferences;
