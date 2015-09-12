# * Copyright (C) 2007 - 2014 Hyperweb2 All rights reserved.
# * GNU General Public License version 3; see www.hyperweb2.com/terms/

cmake_minimum_required(VERSION 2.8.9)

if (NOT WOWENGINE_LIB_MOD)
  set(WOWENGINE_LIB_MOD ON)
else()
  return()
endif()

TCE_SET_PATH("CMAKE_WOWENGINE_LIB_MODS_DIR" "${CMAKE_WOWENGINE_LIB_DIR}/mods")

file(GLOB_RECURSE sources_Mods "${CMAKE_WOWENGINE_LIB_MODS_DIR}/*.cpp" "${CMAKE_WOWENGINE_LIB_MODS_DIR}/*.h")

add_library(mods STATIC
  ${sources_Mods}
)

TCE_GET_GLOBAL("TCE_CORE_TGS")

target_link_libraries(mods
  ${TCE_CORE_TGS}
)
