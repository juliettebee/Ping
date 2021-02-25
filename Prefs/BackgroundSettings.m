#import "Prefs.h"

@implementation JuliettePingBackgroundSettings 
    -(NSArray *) specifiers {
        if (!_specifiers)
            _specifiers = [self loadSpecifiersFromPlistName:@"backgroundPrefs" target:self];
        return _specifiers;
    }
@end
