# Copyright (C) 2008-2014 TrinityCore <http://www.trinitycore.org/>
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

cmake_minimum_required(VERSION 2.8.9)

if (NOT WOWENGINE_335a_WORLD)
  set(WOWENGINE_335a_WORLD ON)
else()
  return()
endif()

TCE_SUBDIRLIST(sub_DIRS  "${CMAKE_CURRENT_LIST_DIR}" TRUE)
FOREACH(subdir ${sub_DIRS})
    file(GLOB sources "${subdir}/*.cpp" "${subdir}/*.h")

    set(world_STAT_SRCS
        ${world_STAT_SRCS}
        ${sources}
    )

    set(world_DIRS
        ${subdir}
        ${world_DIRS}
    )
ENDFOREACH()

# Create world-libary

if (USE_COREPCH)
  set(world_STAT_PCH_HDR ${CMAKE_CURRENT_LIST_DIR}/PrecompiledHeaders/worldPCH.h)
  set(world_STAT_PCH_SRC ${CMAKE_CURRENT_LIST_DIR}/PrecompiledHeaders/worldPCH.cpp)
endif ()

TCE_LOAD_INC_PATHS()

TCE_ADD_INC_PATH("${world_DIRS}")

add_library(world STATIC
  ${world_STAT_SRCS}
  ${world_STAT_PCH_SRC}
)

add_dependencies(world revision.h)

# Generate precompiled header
if (USE_COREPCH)
  add_cxx_pch(world ${world_STAT_PCH_HDR} ${world_STAT_PCH_SRC})
endif ()
