# * Copyright (C) 2007 - 2014 Hyperweb2 All rights reserved.
# * GNU General Public License version 3; see www.hyperweb2.com/terms/

#
# before include this library , you must load relative "core" project
#

cmake_minimum_required(VERSION 2.8.9)

if (NOT TCE_LIB_PACKETS)
  set(TCE_LIB_PACKETS ON)
else()
  return()
endif()

TCE_SET_PATH("CMAKE_TCE_LIB_PACKETS_DIR" "${CMAKE_TCECPP_LIBRARIES}/Packets")

file(GLOB_RECURSE hwc_sources_PACKETS "${CMAKE_TCE_LIB_PACKETS_DIR}/*.cpp" "${CMAKE_TCE_LIB_PACKETS_DIR}/*.h")

if (USE_COREPCH)
    set(hwc_extra_STAT_SRC
        ${hwc_extra_STAT_SRC}
        ${hwc_sources_PACKETS}
    )
    # update global 
    TCE_SET_GLOBAL("hwc_extra_STAT_SRC" "${hwc_extra_STAT_SRC}")
else()
    TCE_LOAD_INC_PATHS()

    add_library(hwc_lib_packets STATIC
      ${hwc_sources_PACKETS}
    )

    TCE_ADD_CORE_TG("hwc_lib_packets")
endif()