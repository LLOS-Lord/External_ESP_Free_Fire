#pragma once
#include <stdint.h>

struct PlayerID {
    uint64_t m_PlayerID;  // 0x00
    int m_TeamID;         // 0x08
};

uint64_t getMatchGame(uint64_t module_base);
uint64_t getMatch(uint64_t matchgame);
uint64_t CameraMain(uint64_t matchgame);
float* GetViewMatrix(uint64_t camera);
uint64_t getLocalPlayer(uint64_t match);
bool isLocalTeamMate(uint64_t localPlayer, uint64_t otherPlayer);

// HP (trực tiếp từ dump)
int get_CurHP(uint64_t player);
int get_MaxHP(uint64_t player);

// Bone (cần cập nhật offset chính xác khi có)
uint64_t getHead(uint64_t player);
uint64_t getRightToeNode(uint64_t player);

// Memory helpers
template<typename T>
T ReadAddr(uint64_t addr);
bool isVaildPtr(uint64_t ptr);
