# Copyright (C) 2008-2014 TrinityCore <http://www.trinitycore.org/>
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

set(Recast_STAT_SRCS
    ${CMAKE_CURRENT_LIST_DIR}/Source/Recast.cpp 
    ${CMAKE_CURRENT_LIST_DIR}/Source/RecastAlloc.cpp 
    ${CMAKE_CURRENT_LIST_DIR}/Source/RecastArea.cpp 
    ${CMAKE_CURRENT_LIST_DIR}/Source/RecastContour.cpp 
    ${CMAKE_CURRENT_LIST_DIR}/Source/RecastFilter.cpp 
    ${CMAKE_CURRENT_LIST_DIR}/Source/RecastLayers.cpp
    ${CMAKE_CURRENT_LIST_DIR}/Source/RecastMesh.cpp 
    ${CMAKE_CURRENT_LIST_DIR}/Source/RecastMeshDetail.cpp 
    ${CMAKE_CURRENT_LIST_DIR}/Source/RecastRasterization.cpp 
    ${CMAKE_CURRENT_LIST_DIR}/Source/RecastRegion.cpp 
)

include_directories(Include)

if(WIN32)
  include_directories(
    ${CMAKE_SOURCE_DIR}/dep/zlib
  )
endif()

add_library(Recast STATIC ${Recast_STAT_SRCS})

target_link_libraries(Recast ${ZLIB_LIBRARIES})