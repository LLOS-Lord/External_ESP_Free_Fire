#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

// Định nghĩa Vector3 (vì file này dùng nhưng chưa có)
#ifndef Vector3
#define Vector3
typedef struct Vector3 {
    float x, y, z;
} Vector3;
#endif

#import "../Core/GameLogic.h"

struct ESPBox {
    Vector3 pos;
    CGFloat width;
    CGFloat height;
};

@interface ESP_View : UIView

- (instancetype)initWithFrame:(CGRect)frame;
- (void)setBoxes:(NSArray<NSValue *> *)boxes;
- (void)updateBoxes;
- (void)update_data;

@end
