#import "FLBatteryLevelIndicatorView.h"

static const CGFloat FLBatteryLevelIndicatorViewBatteryLevelZeroWidth = 9.0;
static const CGFloat FLBatteryLevelIndicatorViewBatteryLevelMaxWidth = 27.0;

@interface FLBatteryLevelIndicatorView ()

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *fillImageView;

@end

@implementation FLBatteryLevelIndicatorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        [self configureViewForContent];
    }
    return self;
}

- (void)setup
{
    [self setupBackgroundColor];

    [self setupBackgroundImageView];
    [self setupFillImageView];
}

- (void)setupBackgroundColor
{
    self.backgroundColor = [UIColor clearColor];
}

- (void)setupBackgroundImageView
{
    if (self.backgroundImageView) {
        [self.backgroundImageView removeFromSuperview];
    }
    
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 27.0, 11.0)];
    if (self.style == FLBatteryLevelIndicatorViewStyleDark) {
        view.image = [UIImage imageNamed:@"battery_background_dark"];
    }
    else {
        view.image = [UIImage imageNamed:@"battery_background_light"];
    }
    [self addSubview:view];
    
    self.backgroundImageView = view;
}

- (void)setupFillImageView
{
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 27.0, 11.0)];
    UIEdgeInsets insets = UIEdgeInsetsMake(0.0, 3.0, 0.0, 6.0);
    UIImage *resizableImage = [[UIImage imageNamed:@"battery_fill"] resizableImageWithCapInsets:insets];
    view.image = resizableImage;
    [self addSubview:view];
    
    self.fillImageView = view;
}

- (void)setLevel:(double)level
{
//    BOOL isLevelBetweenZeroAndOne = level >= 0.0 && level <= 1.0;
//    NSAssert(isLevelBetweenZeroAndOne, @"battery level must be a value between zero (0%%) and 1.0 (100%%)");
    
    // Clamp level between 0.0 and 1.0 just in case something goes haywire in production (e.g. some weird value comes back from the API, etc.
    double clampedLevel = MAX(0.0, MIN(1.0, level));
    
    _level = clampedLevel;
    
    [self configureViewForContent];
}

- (void)setStyle:(FLBatteryLevelIndicatorViewStyle)style {
    if (_style != style) {f
        _style = style;
        
        [self setupBackgroundImageView];
    }
}

- (void)configureViewForContent {
    [self configureBatteryLevelView];
}

- (void)configureBatteryLevelView {
    CGFloat displayWidth = FLBatteryLevelIndicatorViewBatteryLevelZeroWidth + (FLBatteryLevelIndicatorViewBatteryLevelMaxWidth - FLBatteryLevelIndicatorViewBatteryLevelZeroWidth) * self.level;
    
    self.fillImageView.frame = CGRectMake(self.fillImageView.frame.origin.x,
                                          self.fillImageView.frame.origin.y,
                                          displayWidth,
                                          self.fillImageView.frame.size.height);
}

@end
