# * Copyright (C) 2007 - 2014 Hyperweb2 All rights reserved.
# * GNU General Public License version 3; see www.hyperweb2.com/terms/

#
# before include this library , you must load relative "core" project
#

if (NOT TCE_LIB_THREADING)
  set(TCE_LIB_THREADING ON)
else()
  return()
endif()

TCE_SET_PATH("CMAKE_TCE_LIB_THREADING_DIR" "${CMAKE_TCECPP_LIBRARIES}/Threading")

file(GLOB_RECURSE tce_sources_THREADING "${CMAKE_TCE_LIB_THREADING_DIR}/*.cpp" "${CMAKE_TCE_LIB_THREADING_DIR}/*.h")

if (USE_COREPCH)
    set(tce_extra_STAT_SRC
        ${tce_extra_STAT_SRC}
        ${tce_sources_THREADING}
    )
    # update global 
    TCE_SET_GLOBAL("tce_extra_STAT_SRC" "${tce_extra_STAT_SRC}")
else()
    add_library(tce_lib_threading STATIC
      ${tce_sources_THREADING}
    )

    set_target_properties(tce_lib_threading PROPERTIES LINKER_LANGUAGE CXX)

    # HEADER ONLY CANNOT BE TARGETTED IN CMAKE 2.8
    #target_link_libraries(core
    #  tce_lib_threading
    #)
endif()