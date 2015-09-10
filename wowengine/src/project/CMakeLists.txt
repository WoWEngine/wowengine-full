# * Copyright (C) 2007 - 2014 Hyperweb2 All rights reserved.
# * GNU General Public License version 3; see www.hyperweb2.com/terms/

if (NOT WOWENGINE_PROJECT)
  set(WOWENGINE_PROJECT ON)
else()
  return()
endif()

get_filename_component(PROJECT_MODULES_ROOT_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../" REALPATH)
include("${PROJECT_MODULES_ROOT_DIR}/trinitycore/src/project/defines.cmake")

if( NOPCH )
  TCE_SET_CACHE(USE_SCRIPTPCH 0)
endif()

#options
option(SERVERS          "Build worldserver and authserver"                            1)
option(SCRIPTS          "Build core with scripts included"                            1)
option(TOOLS            "Build map/vmap/mmap extraction/assembler tools"              0)
option(USE_SCRIPTPCH    "Use precompiled headers when compiling scripts"              1)

# Informations and definitions
if( SERVERS )
  message("* Build world/auth       : Yes (default)")
else()
  message("* Build world/authserver : No")
endif()

if( SCRIPTS )
  message("* Build with scripts     : Yes (default)")
  add_definitions(-DSCRIPTS)
else()
  message("* Build with scripts     : No")
endif()

if( TOOLS )
  message("* Build map/vmap tools   : Yes")
  add_definitions(-DNO_CORE_FUNCS)
else()
  message("* Build map/vmap tools   : No  (default)")
endif()

if( USE_SCRIPTPCH )
  message("* Build scripts w/PCH    : Yes (default)")
else()
  message("* Build scripts w/PCH    : No")
endif()

# set in path list and cache
TCE_SET_PATH("CMAKE_MODULE_PATH" "${CMAKE_TCECPP_PROJECT}/cmake/macros")
TCE_SET_PATH("CMAKE_WOWENGINE_ROOT_DIR" "${PROJECT_MODULES_ROOT_DIR}/wowengine")
TCE_SET_PATH("CMAKE_WOWENGINE_SRC_DIR" "${CMAKE_WOWENGINE_ROOT_DIR}/src")
TCE_SET_PATH("CMAKE_WOWENGINE_GAME_DIR" "${CMAKE_WOWENGINE_SRC_DIR}/game")
TCE_SET_PATH("CMAKE_WOWENGINE_MODULES_DIR" "${CMAKE_WOWENGINE_ROOT_DIR}/modules")
TCE_SET_PATH("CMAKE_WOWENGINE_PROJECT_DIR" "${CMAKE_WOWENGINE_SRC_DIR}/project")
TCE_SET_PATH("CMAKE_WOWENGINE_LIB_DIR" "${CMAKE_WOWENGINE_SRC_DIR}/library")
TCE_SET_PATH("CMAKE_WOWENGINE_GAME_MODS_DIR" "${CMAKE_WOWENGINE_GAME_DIR}/mods")

# Find revision ID and hash of the sourcetree
include("${CMAKE_TCECPP_PROJECT}/cmake/genrev.cmake")
