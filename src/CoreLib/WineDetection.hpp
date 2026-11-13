/*
 * Copyright (C) 2026 Smirnov Vladimir / mapron1@gmail.com
 * Copyright (C) 2026 Bertus Steenberg / bertus.steenberg@gmail.com
 * SPDX-License-Identifier: BSL-1.0
 * See LICENSE file for details.
 */
#pragma once

#include "ModgenCoreExport.hpp"

#include "MernelPlatform/FsUtils.hpp"

#include <string>
#include <vector>

namespace D2ModGen {

enum class GameKind
{
    Resurrected,
    Legacy,
};

struct WineGameMatch {
    Mernel::std_path prefix;      // Wine prefix (holds system.reg)
    Mernel::std_path installPath; // game dir, validated
    Mernel::std_path userHome;    // prefix user dir, <prefix>/drive_c/users/<user>/
    bool             hasSavedGames      = false;
    bool             hasBattleNetConfig = false; // always false for Legacy
};

/// Every Wine prefix under homeDir (plus winePrefixEnv) that holds the game, best first.
MODGENCORE_EXPORT std::vector<WineGameMatch> findWineGames(GameKind kind, const Mernel::std_path& homeDir, const std::string& winePrefixEnv);

}
