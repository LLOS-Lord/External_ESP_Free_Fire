#include <stdint.h>

// Giả sử bạn có hàm đọc bộ nhớ an toàn
template<typename T>
T ReadAddr(uint64_t addr);

bool isVaildPtr(uint64_t ptr) { return ptr != 0 && ptr > 0x10000; }

// Định nghĩa struct PlayerID (IHAAMHPPLMG) dựa theo dump
struct PlayerID {
    uint64_t m_PlayerID;  // 0x00
    int m_TeamID;         // 0x08
    // padding? không quan trọng
};

#pragma mark - Function Game

// Lấy MatchGame từ GameFacade (offset tĩnh cũ, giữ nguyên)
uint64_t getMatchGame(uint64_t module_base) {
    uint64_t GameFacade_TypeInfo = ReadAddr<uint64_t>(module_base + 0x9985B70);
    uint64_t GameFacade_Static = ReadAddr<uint64_t>(GameFacade_TypeInfo + 0xB8);
    return ReadAddr<uint64_t>(GameFacade_Static + 0x0);
}

// Lấy đối tượng Match (NFJPHMKKEBF) từ MatchGame
uint64_t getMatch(uint64_t matchgame) {
    // offset 0x90: field m_Match trong MatchGame
    return ReadAddr<uint64_t>(matchgame + 0x90);
}

// Lấy Camera chính (dùng để lấy ma trận view)
uint64_t CameraMain(uint64_t matchgame) {
    // offset 0xD8: m_CameraControllerManager (theo bạn cung cấp)
    uint64_t cameraControllerMgr = ReadAddr<uint64_t>(matchgame + 0xD8);
    // offset 0x28: m_MainCamera trong CameraControllerManager (bạn cung cấp)
    return ReadAddr<uint64_t>(cameraControllerMgr + 0x28);
}

// Lấy ma trận View từ Camera (Unity: Transform component tại offset 0x10, matrix tại 0xD8)
float* GetViewMatrix(uint64_t camera) {
    uint64_t transform = ReadAddr<uint64_t>(camera + 0x10);
    static float matrix[16];
    for (int i = 0; i < 16; i++) {
        matrix[i] = ReadAddr<float>(transform + 0xD8 + i * 4);
    }
    return matrix;
}

// Lấy LocalPlayer từ Match
uint64_t getLocalPlayer(uint64_t match) {
    // offset 0x58: m_LocalPlayer (xác nhận từ dump)
    return ReadAddr<uint64_t>(match + 0x58);
}

// Kiểm tra có phải đồng đội không (dựa vào TeamID trong PlayerID)
bool isLocalTeamMate(uint64_t localPlayer, uint64_t otherPlayer) {
    // PlayerID field nằm tại offset 0x2D0 trong class Player
    uint64_t localPIDAddr = localPlayer + 0x2D0;
    uint64_t otherPIDAddr = otherPlayer + 0x2D0;
    
    // Đọc trực tiếp struct PlayerID (8 byte ID + 4 byte TeamID)
    PlayerID localPID = ReadAddr<PlayerID>(localPIDAddr);
    PlayerID otherPID = ReadAddr<PlayerID>(otherPIDAddr);
    
    return localPID.m_TeamID == otherPID.m_TeamID;
}
