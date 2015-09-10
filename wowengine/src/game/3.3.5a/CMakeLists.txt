# * Copyright (C) 2007 - 2014 Hyperweb2 All rights reserved.
# * GNU General Public License version 3; see www.hyperweb2.com/terms/

cmake_minimum_required(VERSION 2.8.9)

if (NOT WOWENGINE_335a)
  set(WOWENGINE_335a ON)
else()
  return()
endif()

if (NOT PROJECT_NAME)
    project(WoWEngine-335a)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/../../project/CMakeLists.txt")

TCE_SET_PATH("CMAKE_WOWENGINE_335a_DIR" "${CMAKE_WOWENGINE_ROOT_DIR}/src/game/3.3.5a")
TCE_SET_PATH("CMAKE_WOWENGINE_335a_WORLD_DIR" "${CMAKE_WOWENGINE_335a_DIR}/world")
TCE_SET_PATH("CMAKE_WOWENGINE_335a_SCRIPTS_DIR" "${CMAKE_WOWENGINE_335a_DIR}/scripts")
TCE_SET_PATH("CMAKE_WOWENGINE_335a_SERVER_DIR" "${CMAKE_WOWENGINE_335a_DIR}/server")
TCE_SET_PATH("CMAKE_WOWENGINE_335a_TOOL_DIR" "${CMAKE_WOWENGINE_335a_DIR}/tool")
TCE_SET_PATH("CMAKE_WOWENGINE_335a_MODS_DIR" "${CMAKE_WOWENGINE_335a_DIR}/mods")

TCE_SET_CACHE("CMAKE_WOWENGINE_VERSION" "3.3.5a") # can be usefull for conditions

if(TOOLS)
  add_subdirectory("${CMAKE_WOWENGINE_MODULES_DIR}/dep" "${CMAKE_BINARY_DIR}/wowengine_dep") 
endif()

MACRO(WOWENGINE_LOAD_LIBS)
    #include common libraries
    include("${CMAKE_TCECPP_LIBRARIES}/Common/CMakeLists.txt")
    include("${CMAKE_TCECPP_LIBRARIES}/Configuration/CMakeLists.txt")
    include("${CMAKE_TCECPP_LIBRARIES}/Cryptography/CMakeLists.txt")
    include("${CMAKE_TCECPP_LIBRARIES}/DataStructures/CMakeLists.txt")
    include("${CMAKE_TCECPP_LIBRARIES}/Database/CMakeLists.txt")
    include("${CMAKE_TCECPP_LIBRARIES}/Debugging/CMakeLists.txt")
    include("${CMAKE_TCECPP_LIBRARIES}/Logging/CMakeLists.txt")
    include("${CMAKE_TCECPP_LIBRARIES}/Networking/CMakeLists.txt")
    include("${CMAKE_TCECPP_LIBRARIES}/Packets/CMakeLists.txt")
    include("${CMAKE_TCECPP_LIBRARIES}/Threading/CMakeLists.txt")
    include("${CMAKE_TCECPP_LIBRARIES}/Utilities/CMakeLists.txt")

    #include wowengine libraries
    include("${CMAKE_WOWENGINE_LIB_DIR}/DataStores/CMakeLists.txt")
ENDMACRO()

if (USE_COREPCH)
  include("${CMAKE_TCECPP_LIBRARIES}/PrecompiledHeaders/CMakeLists.txt")
  WOWENGINE_LOAD_LIBS()
  include("${CMAKE_TCECPP_PROJECT}/CMakeLists.txt")
else()
  include("${CMAKE_TCECPP_PROJECT}/CMakeLists.txt")
  WOWENGINE_LOAD_LIBS()
endif ()

# We need to include here instead directly on collision
# because they are required by world that must be included before collision
set(include_dirs
  ${CMAKE_WOWENGINE_335a_DIR}/collision/
  ${CMAKE_WOWENGINE_335a_DIR}/collision/Management
  ${CMAKE_WOWENGINE_335a_DIR}/collision/Maps
  ${CMAKE_WOWENGINE_335a_DIR}/collision/Models
)

TCE_ADD_INC_PATH("${include_dirs}")

if( SERVERS )
  include("${CMAKE_WOWENGINE_335a_DIR}/world/CMakeLists.txt")
  include("${CMAKE_WOWENGINE_335a_DIR}/collision/CMakeLists.txt")
  include("${CMAKE_WOWENGINE_335a_DIR}/scripts/CMakeLists.txt")

  # must follow this order
  include("${CMAKE_WOWENGINE_335a_MODS_DIR}/CMakeLists.txt")
  include("${CMAKE_WOWENGINE_GAME_MODS_DIR}/CMakeLists.txt")
  include("${CMAKE_WOWENGINE_LIB_DIR}/mods/CMakeLists.txt")

  # load all mods
  LOAD_335a_MODS()
  LOAD_GAME_MODS()
  # then link mods library to other related
  target_link_libraries(world
    mods
  )

  include("${CMAKE_WOWENGINE_335a_DIR}/server/CMakeLists.txt")
else()
  if( TOOLS )
    include("${CMAKE_WOWENGINE_335a_DIR}/collision/CMakeLists.txt")
    include("${CMAKE_WOWENGINE_335a_DIR}/server/CMakeLists.txt")
  endif()
endif()

if ( TOOLS )
  add_subdirectory(tool)
endif(TOOLS)


