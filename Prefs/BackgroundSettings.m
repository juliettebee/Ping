#import "Prefs.h"

@implementation JuliettePingBackgroundSettings 

-(void) viewDidLoad {
    [super viewDidLoad];

    // Creating an array of specifiers we will change
    self.topBottomSpecifiers = [[NSMutableArray alloc] init];
    for (PSSpecifier *specifier in [self specifiers])
        if ([[specifier propertyForKey:@"toggleable"] boolValue])
   [self.topBottomSpecifiers addObject:specifier];

    // Now we're seeing what we need to change
    preferences  = [[HBPreferences alloc] initWithIdentifier:@"page.juliette.Ping.Prefs"];

    if ([preferences boolForKey:@"topAndBottomDifferent"]) { 
        // If its true we need to hide the background color cell
        for (PSSpecifier *specifier in self.topBottomSpecifiers)
            if (![[specifier propertyForKey:@"hideOnToggle"] boolValue])
                      [self removeSpecifier:specifier];
    } else {
        for (PSSpecifier *specifier in self.topBottomSpecifiers)
            if ([[specifier propertyForKey:@"hideOnToggle"] boolValue])
                     [self removeSpecifier:specifier];
    }
}

-(void) setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier {    
 [super setPreferenceValue:value specifier:specifier];
 // First we need to check the id of the cell to see if its the cell we want
 if ([specifier.identifier isEqual:@"topAndBottomDifferent"]) {
     for (PSSpecifier *specifier in self.topBottomSpecifiers) {
         if (![[specifier propertyForKey:@"hideOnToggle"] boolValue])
             // I wish there was a toggle visibility method like UIView's setHidden: 
             if ([value boolValue])
                 [self removeSpecifier:specifier];
             else
                 [self insertSpecifier:specifier atIndex:4 animated:YES]; 
         else
             if ([value boolValue])
                 [self insertSpecifier:specifier atIndex:4 animated:YES];
             else
                 [self removeSpecifier:specifier];
     }
 }
}        

-(NSArray *) specifiers {
    if (!_specifiers)
        _specifiers = [self loadSpecifiersFromPlistName:@"backgroundPrefs" target:self];
    return _specifiers;
}
@end
