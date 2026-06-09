#import "GameLogic.h"

#pragma mark - Memory Helpers

template<typename T>
T ReadAddr(uint64_t addr) {
    if (!isVaildPtr(addr)) return T();
    return *(T*)addr;
}

// Explicit instantiation
template uint64_t ReadAddr<uint64_t>(uint64_t);
template float ReadAddr<float>(uint64_t);
template int ReadAddr<int>(uint64_t);
template PlayerID ReadAddr<PlayerID>(uint64_t);

bool isVaildPtr(uint64_t ptr) {
    return ptr > 0x10000 && ptr < 0x0000FFFFFFFFFFFF;
}

#pragma mark - Game Logic

uint64_t getMatchGame(uint64_t module_base) {
    uint64_t GameFacade_TypeInfo = ReadAddr<uint64_t>(module_base + 0x9985B70);
    uint64_t GameFacade_Static = ReadAddr<uint64_t>(GameFacade_TypeInfo + 0xB8);
    return ReadAddr<uint64_t>(GameFacade_Static + 0x0);
}

uint64_t getMatch(uint64_t matchgame) {
    // offset 0x90: m_Match (giữ nguyên)
    return ReadAddr<uint64_t>(matchgame + 0x90);
}

uint64_t CameraMain(uint64_t matchgame) {
    // offset 0xD8: m_CameraControllerManager
    uint64_t cameraControllerMgr = ReadAddr<uint64_t>(matchgame + 0xD8);
    // offset 0x28: m_MainCamera (theo bạn cung cấp)
    return ReadAddr<uint64_t>(cameraControllerMgr + 0x28);
}

float* GetViewMatrix(uint64_t camera) {
    uint64_t transform = ReadAddr<uint64_t>(camera + 0x10);
    static float matrix[16];
    for (int i = 0; i < 16; i++) {
        matrix[i] = ReadAddr<float>(transform + 0xD8 + i * 4);
    }
    return matrix;
}

uint64_t getLocalPlayer(uint64_t match) {
    // offset 0x58: m_LocalPlayer (đã xác nhận)
    return ReadAddr<uint64_t>(match + 0x58);
}

bool isLocalTeamMate(uint64_t localPlayer, uint64_t otherPlayer) {
    // offset 0x2D0: PlayerID
    uint64_t localPIDAddr = localPlayer + 0x2D0;
    uint64_t otherPIDAddr = otherPlayer + 0x2D0;
    PlayerID localPID = ReadAddr<PlayerID>(localPIDAddr);
    PlayerID otherPID = ReadAddr<PlayerID>(otherPIDAddr);
    return localPID.m_TeamID == otherPID.m_TeamID;
}

#pragma mark - HP (dùng offset trực tiếp từ dump)

int get_CurHP(uint64_t player) {
    // dump: private int m_CurHP; // 0x1B8
    return ReadAddr<int>(player + 0x1B8);
}

int get_MaxHP(uint64_t player) {
    // dump: private int m_MaxHP; // 0x1BC
    return ReadAddr<int>(player + 0x1BC);
}

#pragma mark - Bone (tạm thời trả về 0, chờ offset chính xác)

uint64_t getHead(uint64_t player) {
    // TODO: Tìm offset m_Head trong class Player
    // Ví dụ: return ReadAddr<uint64_t>(player + 0x550);
    return 0;
}

uint64_t getRightToeNode(uint64_t player) {
    // TODO: Tìm offset m_RightToeTF trong class Player
    // Có thể là 0x5A0 hoặc offset khác. Hiện tại trả về 0.
    return 0;
}
