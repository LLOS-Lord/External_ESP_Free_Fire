#import "esp.h"

// Stub: trả về base address của module (cần cài đặt thực tế)
uint64_t GetGameModule_Base(const char* moduleName) {
    // TODO: thay bằng code đọc /proc/pid/maps hoặc dùng dlsym, mach-o...
    return 0x100000000;  // địa chỉ tạm để qua linker
}

// Stub: chuyển đổi tọa độ World -> Screen
Vector3 WorldToScreen(Vector3 worldPos, float* matrix, int width, int height) {
    Vector3 screen = {0.0f, 0.0f, 0.0f};
    // TODO: áp dụng phép biến đổi view-projection matrix
    return screen;
}
