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
    file(GLOB tce_lib_datastructures_sources "${subdir}/*.cpp" "${subdir}/*.h")

    set(tce_lib_datastructures_srcs
        ${tce_lib_datastructures_sources}
        ${tce_lib_datastructures_srcs}
    )

    set(tce_lib_datastructures_dirs
        ${subdir}
        ${tce_lib_datastructures_dirs}
    )
ENDFOREACH()

file(GLOB tce_sources_Datastructures "${CMAKE_TCE_LIB_DATASTRUCTURES_DIR}/*.cpp" "${CMAKE_TCE_LIB_DATASTRUCTURES_DIR}/*.h")

TCE_ADD_INC_PATH("${tce_lib_datastructures_dirs}")


if (USE_COREPCH)
    set(tce_extra_STAT_SRC
      ${tce_extra_STAT_SRC}
      ${tce_sources_Datastructures}
      ${tce_lib_datastructures_srcs}
    )

    # update global 
    TCE_SET_GLOBAL("tce_extra_STAT_SRC" "${tce_extra_STAT_SRC}")
else()
    add_library(tce_lib_datastructures STATIC
      ${tce_sources_Datastructures}
      ${tce_lib_datastructures_srcs}
    )

    set_target_properties(tce_lib_datastructures PROPERTIES LINKER_LANGUAGE CXX)

    # HEADER ONLY CANNOT BE TARGETTED IN CMAKE 2.8
    #target_link_libraries(core
    #    tce_lib_datastructures
    #)
endif()