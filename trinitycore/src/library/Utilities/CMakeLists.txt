# * Copyright (C) 2007 - 2014 Hyperweb2 All rights reserved.
# * GNU General Public License version 3; see www.hyperweb2.com/terms/

#
# before include this library , you must load relative "core" project
#

if (NOT TCE_LIB_UTILITIES)
  set(TCE_LIB_UTILITIES ON)
else()
  return()
endif()

TCE_SET_PATH("CMAKE_TCE_LIB_UTILITIES_DIR" "${CMAKE_TCECPP_LIBRARIES}/Utilities")

file(GLOB_RECURSE tce_sources_UTILITIES "${CMAKE_TCE_LIB_UTILITIES_DIR}/*.cpp" "${CMAKE_TCE_LIB_UTILITIES_DIR}/*.h")

if (USE_COREPCH)
    set(tce_extra_STAT_SRC
        ${tce_extra_STAT_SRC}
        ${tce_sources_UTILITIES}
    )
    # update global 
    TCE_SET_GLOBAL("tce_extra_STAT_SRC" "${tce_extra_STAT_SRC}")
else()
    TCE_LOAD_INC_PATHS()

    add_library(tce_lib_utilities STATIC
      ${tce_sources_UTILITIES}
    )

    TCE_ADD_CORE_TG("tce_lib_utilities")
endif()