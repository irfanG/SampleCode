
#import <UIKit/UIKit.h>

typedef enum {
    FLBatteryLevelIndicatorViewStyleLight,
    FLBatteryLevelIndicatorViewStyleDark
} FLBatteryLevelIndicatorViewStyle;

@interface FLBatteryLevelIndicatorView : UIView

@property (nonatomic, assign) FLBatteryLevelIndicatorViewStyle style; // defaults to FLBatteryLevelIndicatorViewStyleLight
@property (nonatomic, assign) double level; // double value between 0 and 1.

@end
