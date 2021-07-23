#import "Tweak.h"

%group Ping

%hook NCNotificationShortLookView 
%property(nonatomic, retain)UIView* pingView;
%property int minutesSincePublish;
%property(nonatomic, retain)NSDate *publishedDate;
%property(nonatomic, retain)UILabel *dateLabel;
-(void) didMoveToWindow {
    %orig;         

    for (UIView* subview in [self subviews]) {
        if (subview == self.pingView) continue;
        [subview removeFromSuperview];
    }

    if (!self.pingView) {
        self.pingView = [[UIView alloc] init];

        [self addSubview:self.pingView];

        [self.pingView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [NSLayoutConstraint activateConstraints:@[
            [self.pingView.topAnchor constraintEqualToAnchor:self.topAnchor],
            [self.pingView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
            [self.pingView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
            [self.pingView.heightAnchor constraintEqualToAnchor:self.heightAnchor],
        ]];
    }

    CGFloat height = 40;
    CGFloat radius = 15;
    
    self.minutesSincePublish = 0;
    self.publishedDate = [NSDate now];
    
    // Background
    // Change this to MTMaterialView
    UIView *background = [[UIView alloc] init];
    background.backgroundColor = UIColor.blackColor;
    background.layer.cornerRadius = radius;
    [self.pingView addSubview:background];
    
    background.translatesAutoresizingMaskIntoConstraints = false;
    [NSLayoutConstraint activateConstraints:@[
        [background.leadingAnchor constraintEqualToAnchor:self.pingView.leadingAnchor],
        [background.trailingAnchor constraintEqualToAnchor:self.pingView.trailingAnchor],
        [background.topAnchor constraintEqualToAnchor:self.pingView.topAnchor],
        [background.bottomAnchor constraintEqualToAnchor:self.pingView.bottomAnchor]
    ]];
    
    // Header
    // Icon - if there is one
    UIImageView *icon = [[UIImageView alloc] init];
    [icon setImage:[self.icons objectAtIndex:0]];
    [self.pingView addSubview:icon];
    
    icon.translatesAutoresizingMaskIntoConstraints = false;
    [NSLayoutConstraint activateConstraints:@[
        [icon.leadingAnchor constraintEqualToAnchor:self.pingView.leadingAnchor constant:10],
        [icon.topAnchor constraintEqualToAnchor:self.pingView.topAnchor constant: 10],
        [icon.heightAnchor constraintEqualToConstant:height - 18],
        [icon.widthAnchor constraintEqualToConstant:height - 18]
    ]];
    
    
    // App name
    UILabel *appName = [[UILabel alloc] init];
    appName.text = [self title];
    appName.textColor = UIColor.whiteColor;
    appName.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
    [appName sizeToFit];
    [self.pingView addSubview:appName];
    
    appName.translatesAutoresizingMaskIntoConstraints = false;
    [NSLayoutConstraint activateConstraints:@[
        [appName.leadingAnchor constraintEqualToAnchor:self.pingView.leadingAnchor constant:10],
        [appName.centerYAnchor constraintEqualToAnchor:icon.centerYAnchor]
    ]];
    
    // Date label
    self.dateLabel = [[UILabel alloc] init];
    self.dateLabel.text = @"now"; // TODO: localize this
    self.dateLabel.textColor = UIColor.whiteColor;
    self.dateLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
    [self.dateLabel sizeToFit];
    [self.pingView addSubview:self.dateLabel];
    
    self.dateLabel.translatesAutoresizingMaskIntoConstraints = false;
    [NSLayoutConstraint activateConstraints:@[
        [self.dateLabel.trailingAnchor constraintEqualToAnchor:self.pingView.trailingAnchor constant:-10],
        [self.dateLabel.centerYAnchor constraintEqualToAnchor:appName.centerYAnchor]
    ]];
    
    // Content section
    // Notification title - if there is one
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = [self primaryText];
    titleLabel.textColor = UIColor.whiteColor;
    titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightSemibold];
    [titleLabel sizeToFit];
    [self.pingView addSubview:titleLabel];
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false;
    [NSLayoutConstraint activateConstraints:@[
        [titleLabel.topAnchor constraintEqualToAnchor:appName.bottomAnchor constant:5],
        [titleLabel.leadingAnchor constraintEqualToAnchor:self.pingView.leadingAnchor constant:10]
    ]];
    
    // Notification content
    UILabel *content = [[UILabel alloc] init];
    content.text = [self secondaryText];
    content.textColor = UIColor.whiteColor;
    content.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    [content sizeToFit];
    [self.pingView addSubview:content];
    
    content.translatesAutoresizingMaskIntoConstraints = false;
    [NSLayoutConstraint activateConstraints:@[
        [content.topAnchor constraintEqualToAnchor:titleLabel.bottomAnchor constant:1],
        [content.leadingAnchor constraintEqualToAnchor:self.pingView.leadingAnchor constant:10]
    ]];
    
    // Timer to auto update date label
    [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(updateRelativeTime:) userInfo:nil repeats:YES];
}
%new
-(void) updateRelativeTime:(NSTimer *)timer {
    self.minutesSincePublish++;
    // If its been more than an hour but less than a day
    if (self.minutesSincePublish >= 60 && self.minutesSincePublish < 1440) {
        NSRelativeDateTimeFormatter *dateFormatter = [[NSRelativeDateTimeFormatter alloc] init];
        dateFormatter.unitsStyle = NSRelativeDateTimeFormatterUnitsStyleShort;
        [self.dateLabel setText:[dateFormatter localizedStringForDate:self.publishedDate relativeToDate:[NSDate now]]];
        // If its been more than a day
    } else if (self.minutesSincePublish >= 1440) {
        NSRelativeDateTimeFormatter *dateFormatter = [[NSRelativeDateTimeFormatter alloc] init];
        dateFormatter.unitsStyle = NSRelativeDateTimeFormatterUnitsStyleShort;
        [self.dateLabel setText:[dateFormatter localizedStringForDate:self.publishedDate relativeToDate:[NSDate now]]];
        // If its not that then use minutes as long as its not 0
    } else if (self.minutesSincePublish != 0){
        NSRelativeDateTimeFormatter *dateFormatter = [[NSRelativeDateTimeFormatter alloc] init];
        dateFormatter.unitsStyle = NSRelativeDateTimeFormatterUnitsStyleShort;
        [self.dateLabel setText:[dateFormatter localizedStringForDate:self.publishedDate relativeToDate:[NSDate now]]];
    }
}
%end
%end

%ctor {
    // Seeing if tweak is enabled
    preferences  = [[HBPreferences alloc] initWithIdentifier:@"page.juliette.Ping.Prefs"];
    BOOL enabled;
    [preferences registerBool:&enabled default:YES forKey:@"Enabled"];
    if (!enabled)
        return;

    [preferences registerObject:&backgroundColor default:@"" forKey:@"backgroundColor"];
    [preferences registerObject:&actionBackgroundColor default:@"" forKey:@"actionBackGroundColor"];
    [preferences registerObject:&topBackgroundColor default:@"" forKey:@"topBackgroundColor"];
    [preferences registerObject:&bottomBackgroundColor default:@"" forKey:@"bottomBackgroundColor"];
    [preferences registerObject:&borderColor default:@"" forKey:@"borderColor"];
    [preferences registerObject:&headerColor default:@"" forKey:@"headerLabelTextColorTitle"];
    [preferences registerObject:&headerLabelTextColorAll default:@"" forKey:@"headerLabelTextColorAll"];
    [preferences registerObject:&notificationTextColor default:@"" forKey:@"headerLabelTextColorMessage"];
//    [preferences registerObject:&dateColor default:@"" forKey:@"headerLabelTextColorDate"];
//    [preferences registerObject:&appNameColor default:@"" forKey:@"headerLabelTextColorAppName"];
    [preferences registerBool:&mtmaterialViewBlurEnabled default:YES forKey:@"mtmaterialViewBlurEnabled"];
    [preferences registerBool:&actionMtmaterialViewBlurEnabled default:YES forKey:@"actionMtmaterialViewBlurEnabled"];
    [preferences registerBool:&transparentBackground default:NO forKey:@"allTransparent"];
    [preferences registerBool:&topAndBottomDifferent default:NO forKey:@"topAndBottomDifferent"];
    [preferences registerBool:&customSideRadius default:NO forKey:@"customSideRadius"];
    [preferences registerBool:&actionTransparentBackground default:NO forKey:@"actionTransparentBackground"];
    [preferences registerBool:&headerShowTitle default:YES forKey:@"headerShowTitle"];
    [preferences registerBool:&headerShowDate default:YES forKey:@"headerShowDate"];
    [preferences registerBool:&headerHideIcon default:YES forKey:@"headerHideIcon"];
    [preferences registerBool:&headerLabelUniqueColor default:NO forKey:@"headerLabelUniqueColor"];
    [preferences registerFloat:&notificationAllRadius default:0 forKey:@"notificationAllRadius"];
    [preferences registerInteger:&borderWidth default:0 forKey:@"borderWidth"];

    if (enabled)
        %init(Ping)
}
