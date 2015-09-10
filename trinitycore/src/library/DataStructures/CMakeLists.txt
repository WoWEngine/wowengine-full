# * Copyright (C) 2007 - 2014 Hyperweb2 All rights reserved.
# * GNU General Public License version 3; see www.hyperweb2.com/terms/

#
# before include this library , you must load relative "core" project
#

if (NOT TCE_LIB_DATASTRUCTURES)
  set(TCE_LIB_DATASTRUCTURES ON)
else()
  return()
endif()

TCE_SET_PATH("CMAKE_TCE_LIB_DATASTRUCTURES_DIR" "${CMAKE_TCECPP_LIBRARIES}/DataStructures")

# add libraries
TCE_SUBDIRLIST(sub_DIRS  "${CMAKE_TCE_LIB_DATASTRUCTURES_DIR}" TRUE)
FOREACH(subdir ${sub_DIRS})
    file(GLOB hwc_lib_datastructures_sources "${subdir}/*.cpp" "${subdir}/*.h")

    set(hwc_lib_datastructures_srcs
        ${hwc_lib_datastructures_sources}
        ${hwc_lib_datastructures_srcs}
    )

    set(hwc_lib_datastructures_dirs
        ${subdir}
        ${hwc_lib_datastructures_dirs}
    )
ENDFOREACH()

file(GLOB hwc_sources_Datastructures "${CMAKE_TCE_LIB_DATASTRUCTURES_DIR}/*.cpp" "${CMAKE_TCE_LIB_DATASTRUCTURES_DIR}/*.h")

TCE_ADD_INC_PATH("${hwc_lib_datastructures_dirs}")


if (USE_COREPCH)
    set(hwc_extra_STAT_SRC
      ${hwc_extra_STAT_SRC}
      ${hwc_sources_Datastructures}
      ${hwc_lib_datastructures_srcs}
    )

    # update global 
    TCE_SET_GLOBAL("hwc_extra_STAT_SRC" "${hwc_extra_STAT_SRC}")
else()
    add_library(hwc_lib_datastructures STATIC
      ${hwc_sources_Datastructures}
      ${hwc_lib_datastructures_srcs}
    )

    set_target_properties(hwc_lib_datastructures PROPERTIES LINKER_LANGUAGE CXX)

    # HEADER ONLY CANNOT BE TARGETTED IN CMAKE 2.8
    #target_link_libraries(core
    #    hwc_lib_datastructures
    #)
endif()