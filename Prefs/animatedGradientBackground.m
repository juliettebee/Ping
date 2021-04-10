#import "Prefs.h"

@implementation JAnimatedGradientBackground 

    - (instancetype) initWithFrame:(CGRect)frame {
        self = [super initWithFrame:frame]; 
        if (self) {
            UIColor *topColor = [UIColor colorWithRed: 0.65 green: 0.52 blue: 0.89 alpha: 1.00];
            UIColor *bottomColor = [UIColor colorWithRed: 1.00 green: 0.67 blue: 0.88 alpha: 1.00];

            self.gradient = [CAGradientLayer layer];
            self.gradient.frame = self.layer.bounds;
            self.gradient.colors = @[
                (id)topColor.CGColor,
                (id)bottomColor.CGColor,
            ];
            self.gradient.locations = @[
                [NSNumber numberWithFloat:0.0f],
                [NSNumber numberWithFloat:1.0f],
            ];

            // Animation!!
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"locations"];
            animation.fromValue = self.gradient.locations;
            animation.toValue = @[@0.75, @1.0];
            animation.duration = 40.0;
            animation.autoreverses = YES;
            animation.repeatCount = INFINITY;
            [self.gradient addAnimation:animation forKey:nil];

            [self.layer insertSublayer:self.gradient atIndex:0];
        }
        return self;
    } 

    // Update size base upon constraints
    - (void) layoutSubviews {
        [super layoutSubviews];
        self.gradient.frame = self.bounds;
    }
@end
