# * Copyright (C) 2007 - 2014 Hyperweb2 All rights reserved.
# * GNU General Public License version 3; see www.hyperweb2.com/terms/

cmake_minimum_required(VERSION 2.8.9)

if (NOT WOWENGINE_GAME_MODS)
  set(WOWENGINE_GAME_MODS ON)
else()
  return()
endif()

include("${CMAKE_CURRENT_LIST_DIR}/../../library/mods/CMakeLists.txt")

TCE_GET_GLOBAL("MODS_LOADER")
# Select loader file
if((NOT ${MODS_LOADER}) AND (EXISTS "${CMAKE_WOWENGINE_GAME_MODS_DIR}/ModsLoader.h"))
  TCE_ADD_INC_PATH("${CMAKE_WOWENGINE_GAME_MODS_DIR}")
else()
  TCE_ADD_INC_PATH("${CMAKE_WOWENGINE_LIB_DIR}/mods/loader")
endif()

MACRO(LOAD_GAME_MODS)
    # add mods
    TCE_SUBDIRLIST(sub_DIRS  "${CMAKE_WOWENGINE_GAME_MODS_DIR}" FALSE)
    FOREACH(subdir ${sub_DIRS})
      if(EXISTS "${subdir}/CMakeLists.txt")
        include("${subdir}/CMakeLists.txt")
      endif()

       set(mods_DIRS
         ${mods_DIRS}
         ${subdir}
       )

    ENDFOREACH()

    TCE_ADD_INC_PATH(
      "${mods_DIRS}"
    )
ENDMACRO(LOAD_GAME_MODS)

message(STATUS "GAME MODS PREPARATION COMPLETE")
message("")


#
# BELOW YOU CAN ADD YOUR CUSTOMIZATIONS
#
