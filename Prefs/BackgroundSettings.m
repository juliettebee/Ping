#import "Prefs.h"

@implementation JuliettePingBackgroundSettings 

    -(void) viewDidLoad {
        [super viewDidLoad]; 
        // Creating an array of specifiers we will change
        self.topBottomSpecifiers = [[NSMutableArray alloc] init];
        //NSArray *ids = @[@"normalBackgroundColorSetter", @"topBackgroundColor", @"bottomBackgroundColor", @"topLeftRadius", @"topRightRadius", @"bottomLeftRadius", @"bottomRightRadius", @"notificationAllRadius"];
        NSArray *ids = @[@"normalBackgroundColorSetter", @"topBackgroundColor", @"bottomBackgroundColor"];
        for (PSSpecifier *specifier in [self specifiers])
            if ([ids containsObject:specifier.identifier])
                [self.topBottomSpecifiers addObject:specifier];

        // Now we're seeing what we need to change
        preferences  = [[HBPreferences alloc] initWithIdentifier:@"page.juliette.Ping.Prefs"];
        if ([preferences boolForKey:@"topAndBottomDifferent"]) 
            // If its true we need to hide the background color cell
            [self removeSpecifier:self.topBottomSpecifiers[2]];
        else {
            [self removeSpecifier:self.topBottomSpecifiers[0]];
            [self removeSpecifier:self.topBottomSpecifiers[1]];
        }
        // Radius toggles
        /*
        if ([preferences boolForKey:@"customSideRadius"])
            [self removeSpecifier:self.topBottomSpecifiers[7]];
        else {
            [self removeSpecifier:self.topBottomSpecifiers[3]];
            [self removeSpecifier:self.topBottomSpecifiers[4]];
            [self removeSpecifier:self.topBottomSpecifiers[5]];
            [self removeSpecifier:self.topBottomSpecifiers[6]];
        }
        */
    }

    -(NSArray *) specifiers {
        if (!_specifiers)
            _specifiers = [self loadSpecifiersFromPlistName:@"backgroundPrefs" target:self];
        return _specifiers;
    }
    
    // This method gets called every time a value is changed so we can use it to toggle the cells
    -(void) setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier {    
        [super setPreferenceValue:value specifier:specifier];
        // First we need to check the id of the cell to see if its the cell we want
        if ([specifier.identifier isEqual:@"topAndBottomDifferent"]) {
            if ([value boolValue]) {
                [self removeSpecifier:self.topBottomSpecifiers[2] animated:YES];
                [self insertSpecifier:self.topBottomSpecifiers[0] atIndex:4 animated:YES];
                [self insertSpecifier:self.topBottomSpecifiers[1] atIndex:5 animated:YES];
            } else {
                [self removeSpecifier:self.topBottomSpecifiers[0] animated:YES];
                [self removeSpecifier:self.topBottomSpecifiers[1] animated:YES];
                [self insertSpecifier:self.topBottomSpecifiers[2] atIndex:4 animated:YES];
            }
        }
        // Radius
        /*
        if ([specifier.identifier isEqual:@"customSideRadius"]) {
            if ([value boolValue]) {
                [self removeSpecifier:self.topBottomSpecifiers[7] animated:YES];
                [self insertSpecifier:self.topBottomSpecifiers[3] atIndex:7 animated:YES];
                [self insertSpecifier:self.topBottomSpecifiers[4] atIndex:8 animated:YES];
                [self insertSpecifier:self.topBottomSpecifiers[5] atIndex:9 animated:YES];
                [self insertSpecifier:self.topBottomSpecifiers[6] atIndex:10 animated:YES];
            } else {
                [self removeSpecifier:self.topBottomSpecifiers[3] animated:YES];
                [self removeSpecifier:self.topBottomSpecifiers[4] animated:YES];
                [self removeSpecifier:self.topBottomSpecifiers[5] animated:YES];
                [self removeSpecifier:self.topBottomSpecifiers[6] animated:YES];
                [self insertSpecifier:self.topBottomSpecifiers[7] atIndex:7 animated:YES];
            }
        }
        */
    }


@end
