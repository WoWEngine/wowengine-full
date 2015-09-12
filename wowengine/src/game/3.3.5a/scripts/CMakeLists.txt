# Copyright (C) 2008-2014 TrinityCore <http://www.trinitycore.org/>
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

# Enable precompiled headers when using the GCC compiler.

cmake_minimum_required(VERSION 2.8.9)

if (NOT WOWENGINE_335a_SCRIPTS)
  set(WOWENGINE_335a_SCRIPTS ON)
else()
  return()
endif()

include("${CMAKE_CURRENT_LIST_DIR}/../CMakeLists.txt")

if (USE_SCRIPTPCH)
  set(scripts_STAT_PCH_HDR ${CMAKE_CURRENT_LIST_DIR}/PrecompiledHeaders/ScriptPCH.h)
  set(scripts_STAT_PCH_SRC ${CMAKE_CURRENT_LIST_DIR}/PrecompiledHeaders/ScriptPCH.cpp)
endif ()

message(STATUS "SCRIPT PREPARATIONS")
include("${CMAKE_CURRENT_LIST_DIR}/Spells/CMakeLists.txt")

include("${CMAKE_CURRENT_LIST_DIR}/Commands/CMakeLists.txt")

set(scripts_STAT_SRCS
  ${scripts_STAT_SRCS}
  "${CMAKE_CURRENT_LIST_DIR}/../world/AI/ScriptedAI/ScriptedEscortAI.cpp"
  "${CMAKE_CURRENT_LIST_DIR}/../world/AI/ScriptedAI/ScriptedCreature.cpp"
  "${CMAKE_CURRENT_LIST_DIR}/../world/AI/ScriptedAI/ScriptedFollowerAI.cpp"
)

if(SCRIPTS)
  include("${CMAKE_CURRENT_LIST_DIR}/World/CMakeLists.txt")
  include("${CMAKE_CURRENT_LIST_DIR}/OutdoorPvP/CMakeLists.txt")
  include("${CMAKE_CURRENT_LIST_DIR}/EasternKingdoms/CMakeLists.txt")
  include("${CMAKE_CURRENT_LIST_DIR}/Kalimdor/CMakeLists.txt")
  include("${CMAKE_CURRENT_LIST_DIR}/Outland/CMakeLists.txt")
  include("${CMAKE_CURRENT_LIST_DIR}/Northrend/CMakeLists.txt")
  include("${CMAKE_CURRENT_LIST_DIR}/Events/CMakeLists.txt")
  include("${CMAKE_CURRENT_LIST_DIR}/Pet/CMakeLists.txt")
endif()

message(STATUS "SCRIPT PREPARATION COMPLETE")
message("")

TCE_LOAD_INC_PATHS()
TCE_ADD_INC_PATH("${CMAKE_CURRENT_LIST_DIR}/PrecompiledHeaders")

GroupSources(${CMAKE_CURRENT_SOURCE_DIR})

add_library(scripts STATIC
  ${scripts_STAT_SRCS}
  ${scripts_STAT_PCH_SRC}
)

add_dependencies(scripts revision_data.h)

# Generate precompiled header
if (USE_SCRIPTPCH)
  add_cxx_pch(scripts ${scripts_STAT_PCH_HDR} ${scripts_STAT_PCH_SRC})
endif()
