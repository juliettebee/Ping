#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>
#import <Cephei/HBPreferences.h>	

@interface JuliettePingPreferences : PSListController
@end

@interface JuliettePingBackgroundSettings : PSListController
@end

@interface JuliettePingActionSettings : PSListController
    -(void)addSpecalCells;
    -(void)removeSpecialCells;
@end

HBPreferences *preferences;
