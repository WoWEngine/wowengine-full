# * Copyright (C) 2007 - 2014 Hyperweb2 All rights reserved.
# * GNU General Public License version 3; see www.hyperweb2.com/terms/

#
# before include this library , you must load relative "core" project
#

if (NOT TCE_LIB_COLLISION)
  set(TCE_LIB_COLLISION ON)
else()
  return()
endif()

TCE_SET_PATH("CMAKE_WOWENGINE_LIB_COLLISION_DIR" "${CMAKE_WOWENGINE_LIB_DIR}/Collision")

# add libraries
TCE_SUBDIRLIST(sub_DIRS  "${CMAKE_WOWENGINE_LIB_COLLISION_DIR}" TRUE)
FOREACH(subdir ${sub_DIRS})
    file(GLOB hwc_lib_collision_sources "${subdir}/*.cpp" "${subdir}/*.h")

    set(hwc_lib_collision_srcs
        ${hwc_lib_collision_sources}
        ${hwc_lib_collision_srcs}
    )

    set(hwc_lib_collision_dirs
        ${subdir}
        ${hwc_lib_collision_dirs}
    )
ENDFOREACH()

file(GLOB hwc_sources_COLLISION "${CMAKE_WOWENGINE_LIB_COLLISION_DIR}/*.cpp" "${CMAKE_WOWENGINE_LIB_COLLISION_DIR}/*.h")

TCE_ADD_INC_PATH("${hwc_lib_collision_dirs}")


if (USE_COREPCH)
    set(hwc_extra_STAT_SRC
        ${hwc_extra_STAT_SRC}
        ${hwc_sources_COLLISION}
        ${hwc_lib_collision_srcs}
    )
    # update global 
    TCE_SET_GLOBAL("hwc_extra_STAT_SRC" "${hwc_extra_STAT_SRC}")
else()
    TCE_LOAD_INC_PATHS()

    add_library(hwc_lib_collision STATIC
      ${hwc_sources_COLLISION}
      ${hwc_lib_collision_srcs}
    )

    TCE_ADD_CORE_TG("hwc_lib_collision")
endif()