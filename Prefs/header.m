#import "Prefs.h"

@implementation JuliettePingHeaderSettings
    -(NSArray *) specifiers {
        if (!_specifiers)
            _specifiers = [self loadSpecifiersFromPlistName:@"header" target:self];
        return _specifiers;
    }
@end
