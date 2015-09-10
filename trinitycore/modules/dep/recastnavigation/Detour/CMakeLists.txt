# Copyright (C) 2008-2014 TrinityCore <http://www.trinitycore.org/>
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

set(Detour_STAT_SRCS
    ${CMAKE_CURRENT_LIST_DIR}/Source/DetourAlloc.cpp 
    ${CMAKE_CURRENT_LIST_DIR}/Source/DetourCommon.cpp 
    ${CMAKE_CURRENT_LIST_DIR}/Source/DetourNavMesh.cpp 
    ${CMAKE_CURRENT_LIST_DIR}/Source/DetourNavMeshBuilder.cpp 
    ${CMAKE_CURRENT_LIST_DIR}/Source/DetourNavMeshQuery.cpp 
    ${CMAKE_CURRENT_LIST_DIR}/Source/DetourNode.cpp 
)
include_directories(Include)

if(WIN32)
  include_directories(
    ${CMAKE_SOURCE_DIR}/dep/zlib
  )
endif()

add_library(Detour STATIC ${Detour_STAT_SRCS})

target_link_libraries(Detour ${ZLIB_LIBRARIES})
