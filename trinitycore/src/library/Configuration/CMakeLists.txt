# * Copyright (C) 2007 - 2014 Hyperweb2 All rights reserved.
# * GNU General Public License version 3; see www.hyperweb2.com/terms/

#
# before include this library , you must load relative "core" project
#

cmake_minimum_required(VERSION 2.8.9)

if (NOT TCE_LIB_CONFIGURATION)
  set(TCE_LIB_CONFIGURATION ON)
else()
  return()
endif()

TCE_SET_PATH("CMAKE_TCE_LIB_CONFIGURATION_DIR" "${CMAKE_TCECPP_LIBRARIES}/Configuration")

file(GLOB_RECURSE tce_sources_Configuration "${CMAKE_TCE_LIB_CONFIGURATION_DIR}/*.cpp" "${CMAKE_TCE_LIB_CONFIGURATION_DIR}/*.h")

if (USE_COREPCH)
    set(tce_extra_STAT_SRC
        ${tce_extra_STAT_SRC}
        ${tce_sources_Configuration}
    )
    # update global 
    TCE_SET_GLOBAL("tce_extra_STAT_SRC" "${tce_extra_STAT_SRC}")
else()
    TCE_LOAD_INC_PATHS()

    add_library(tce_lib_configuration STATIC
      ${tce_sources_Configuration}
    )

    set_target_properties(tce_lib_configuration PROPERTIES LINKER_LANGUAGE CXX)

    TCE_ADD_CORE_TG("tce_lib_configuration")
endif()