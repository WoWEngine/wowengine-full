# * Copyright (C) 2007 - 2014 Hyperweb2 All rights reserved.
# * GNU General Public License version 3; see www.hyperweb2.com/terms/

#
# before include this library , you must load relative "core" project
#

cmake_minimum_required(VERSION 2.8.9)

if (NOT TCE_LIB_NETWORKING)
  set(TCE_LIB_NETWORKING ON)
else()
  return()
endif()

TCE_SET_PATH("CMAKE_TCE_LIB_NETWORKING_DIR" "${CMAKE_TCECPP_LIBRARIES}/Networking")

file(GLOB_RECURSE hwc_sources_NETWORKING "${CMAKE_TCE_LIB_NETWORKING_DIR}/*.cpp" "${CMAKE_TCE_LIB_NETWORKING_DIR}/*.h")

if (USE_COREPCH)
    set(hwc_extra_STAT_SRC
        ${hwc_extra_STAT_SRC}
        ${hwc_sources_NETWORKING}
    )
    # update global 
    TCE_SET_GLOBAL("hwc_extra_STAT_SRC" "${hwc_extra_STAT_SRC}")
else()
    add_library(hwc_lib_networking STATIC
      ${hwc_sources_NETWORKING}
    )

    set_target_properties(hwc_lib_networking PROPERTIES LINKER_LANGUAGE CXX)

    # HEADER ONLY CANNOT BE TARGETTED IN CMAKE 2.8
    #target_link_libraries(core
    #    hwc_lib_networking
    #)
endif()