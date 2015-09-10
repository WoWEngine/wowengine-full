# * Copyright (C) 2007 - 2014 Hyperweb2 All rights reserved.
# * GNU General Public License version 3; see www.hyperweb2.com/terms/

#
# before include this library , you must load relative "core" project
#

if (NOT TCE_LIB_CRYPTOGRAPHY)
  set(TCE_LIB_CRYPTOGRAPHY ON)
else()
  return()
endif()

TCE_SET_PATH("CMAKE_TCE_LIB_CRYPTOGRAPHY_DIR" "${CMAKE_TCECPP_LIBRARIES}/Cryptography")

# add libraries
TCE_SUBDIRLIST(sub_DIRS  "${CMAKE_TCE_LIB_CRYPTOGRAPHY_DIR}" TRUE)
FOREACH(subdir ${sub_DIRS})
    file(GLOB hwc_lib_cryptography_sources "${subdir}/*.cpp" "${subdir}/*.h")

    set(hwc_lib_cryptography_srcs
        ${hwc_lib_cryptography_sources}
        ${hwc_lib_cryptography_srcs}
    )

    set(hwc_lib_cryptography_dirs
        ${subdir}
        ${hwc_lib_cryptography_dirs}
    )
ENDFOREACH()

file(GLOB hwc_sources_Cryptography "${CMAKE_TCE_LIB_CRYPTOGRAPHY_DIR}/*.cpp" "${CMAKE_TCE_LIB_CRYPTOGRAPHY_DIR}/*.h")

TCE_ADD_INC_PATH("${hwc_lib_cryptography_dirs}")

if (USE_COREPCH)
    set(hwc_extra_STAT_SRC
        ${hwc_extra_STAT_SRC}
        ${hwc_sources_Cryptography}
        ${hwc_lib_cryptography_srcs}
    )
    # update global 
    TCE_SET_GLOBAL("hwc_extra_STAT_SRC" "${hwc_extra_STAT_SRC}")
else()
    TCE_LOAD_INC_PATHS()

    add_library(hwc_lib_cryptography STATIC
        ${hwc_sources_Cryptography}
        ${hwc_lib_cryptography_srcs}
    )

    TCE_ADD_CORE_TG("hwc_lib_cryptography")
endif()