#pragma once

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

// Include GameLogic.h - đã có getHead, getRightToeNode, get_CurHP, get_MaxHP, ...
#include "../Core/GameLogic.h"

// Định nghĩa Vector3 nếu GameLogic.h chưa có
#ifndef VECTOR3_DEFINED
#define VECTOR3_DEFINED
struct Vector3 {
    float x, y, z;
    
    static float Distance(const Vector3& a, const Vector3& b) {
        float dx = a.x - b.x;
        float dy = a.y - b.y;
        float dz = a.z - b.z;
        return sqrtf(dx*dx + dy*dy + dz*dz);
    }
};
#endif

// Forward declare các hàm không có trong GameLogic.h
uint64_t GetGameModule_Base(const char* moduleName);
Vector3  getPositionExt(uint64_t transform);
NSString* GetNickName(uint64_t PawnObject);   // Trả về NSString*, không phải void*
Vector3  WorldToScreen(Vector3 worldPos, float* matrix, int width, int height);

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
