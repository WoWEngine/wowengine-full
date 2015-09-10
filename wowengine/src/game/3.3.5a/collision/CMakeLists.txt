# Copyright (C) 2008-2014 TrinityCore <http://www.trinitycore.org/>
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

#if( USE_COREPCH )
#  include_directories(${CMAKE_CURRENT_BINARY_DIR})
#endif()

file(GLOB_RECURSE sources_Management ${CMAKE_CURRENT_LIST_DIR}/Management/*.cpp ${CMAKE_CURRENT_LIST_DIR}/Management/*.h)
file(GLOB_RECURSE sources_Maps ${CMAKE_CURRENT_LIST_DIR}/Maps/*.cpp ${CMAKE_CURRENT_LIST_DIR}/Maps/*.h)
file(GLOB_RECURSE sources_Models ${CMAKE_CURRENT_LIST_DIR}/Models/*.cpp ${CMAKE_CURRENT_LIST_DIR}/Models/*.h)
file(GLOB sources_localdir ${CMAKE_CURRENT_LIST_DIR}/*.cpp ${CMAKE_CURRENT_LIST_DIR}/*.h)

if (USE_COREPCH)
  set(collision_STAT_PCH_HDR ${CMAKE_CURRENT_LIST_DIR}/PrecompiledHeaders/collisionPCH.h)
  set(collision_STAT_PCH_SRC ${CMAKE_CURRENT_LIST_DIR}/PrecompiledHeaders/collisionPCH.cpp)
endif ()

set(collision_STAT_SRCS
  ${collision_STAT_SRCS}
  ${sources_Management}
  ${sources_Maps}
  ${sources_Models}
  ${sources_localdir}
)

TCE_LOAD_INC_PATHS()

add_library(collision STATIC
  ${collision_STAT_SRCS}
  ${collision_STAT_PCH_SRC}
)

TCE_GET_GLOBAL("TCE_CORE_TGS")

target_link_libraries(collision
  ${TCE_CORE_TGS}
)

# Generate precompiled header
if (USE_COREPCH)
  add_cxx_pch(collision ${collision_STAT_PCH_HDR} ${collision_STAT_PCH_SRC})
endif ()
