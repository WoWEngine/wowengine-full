# * Copyright (C) 2007 - 2014 Hyperweb2 All rights reserved.
# * GNU General Public License version 3; see www.hyperweb2.com/terms/

#
# before include this library , you must load relative "core" project
#

if (NOT TCE_LIB_DEBUGGING)
  set(TCE_LIB_DEBUGGING ON)
else()
  return()
endif()

TCE_SET_PATH("CMAKE_TCE_LIB_DEBUGGING_DIR" "${CMAKE_TCECPP_LIBRARIES}/Debugging")

# Manually set sources for Debugging directory as we don't want to include WheatyExceptionReport in shared project
# It needs to be included both in authserver and worldserver for the static global variable to be properly initialized
# and to handle crash logs on windows
set(hwc_sources_DEBUGGING "${CMAKE_TCE_LIB_DEBUGGING_DIR}/Errors.cpp" "${CMAKE_TCE_LIB_DEBUGGING_DIR}/Errors.h")

if (USE_COREPCH)
    set(hwc_extra_STAT_SRC
        ${hwc_extra_STAT_SRC}
        ${hwc_sources_DEBUGGING}
    )
    # update global 
    TCE_SET_GLOBAL("hwc_extra_STAT_SRC" "${hwc_extra_STAT_SRC}")
else()
    TCE_LOAD_INC_PATHS()

    add_library(hwc_lib_debugging STATIC
      ${hwc_sources_DEBUGGING}
    )

    TCE_ADD_CORE_TG("hwc_lib_debugging")
endif()