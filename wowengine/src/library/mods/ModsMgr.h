/*
 * Copyright (C) 2007 - 2015 Hyperweb2 All rights reserved.
 * GNU General Public License version 3; see www.hyperweb2.com/terms/
 */

#ifndef MODSMGR_H
#define	MODSMGR_H

#include "Common/Common.h"

class ModsMgr {
private:
    ModsMgr();
    ~ModsMgr();
public: /* singleton init */

    static ModsMgr* instance() {
        static ModsMgr instance;
        return &instance;
    }

    void Initialization();
};

#define sModsMgr ModsMgr::instance()

#endif	/* MODSMGR_H */

