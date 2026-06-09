#pragma once

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

// Định nghĩa kiểu Vector3
typedef struct Vector3 {
    float x, y, z;
} Vector3;

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
