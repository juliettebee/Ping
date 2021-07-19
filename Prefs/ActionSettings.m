#import "Prefs.h"

@implementation JuliettePingActionSettings
-(NSArray *) specifiers {
    if (!_specifiers)
        _specifiers = [self loadSpecifiersFromPlistName:@"actionSettings" target:self];
    return _specifiers;
}
@end
