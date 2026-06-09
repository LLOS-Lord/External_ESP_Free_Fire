#pragma once

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

// Include file gốc – nó có thể đã định nghĩa Vector3 và các hàm cần thiết
#import "../Core/GameLogic.h"

// Nếu GameLogic.h chưa định nghĩa Vector3, ta tự định nghĩa một struct đầy đủ
// (chỉ dùng khi chưa có, đảm bảo tương thích với code gốc)
#ifndef VECTOR3_DEFINED
#define VECTOR3_DEFINED
struct Vector3 {
    float x, y, z;
    
    // Static method để tính khoảng cách (dùng trong esp.mm)
    static float Distance(const Vector3& a, const Vector3& b) {
        float dx = a.x - b.x;
        float dy = a.y - b.y;
        float dz = a.z - b.z;
        return sqrtf(dx*dx + dy*dy + dz*dz);
    }
};
#endif

// Forward declarations cho các hàm dùng trong esp.mm
// (nếu GameLogic.h đã có thì không ảnh hưởng)
extern "C" {
    uint64_t GetGameModule_Base(const char *moduleName);
    Vector3  getPositionExt(uint64_t transform);
    void*    GetNickName(uint64_t PawnObject);   // trả về NSString* hoặc id
    Vector3  WorldToScreen(Vector3 worldPos, float* matrix, int width, int height);
    uint64_t getHead(uint64_t PawnObject);
    uint64_t getRightToeNode(uint64_t PawnObject);
}

// Cấu trúc ESPBox dùng Vector3 ở trên
struct ESPBox {
    Vector3 pos;
    CGFloat width;
    CGFloat height;
};

// Giao diện ESP_View
@interface ESP_View : UIView

- (instancetype)initWithFrame:(CGRect)frame;
- (void)setBoxes:(NSArray<NSValue *> *)boxes;
- (void)updateBoxes;
- (void)update_data;

@end
