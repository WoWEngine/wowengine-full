# Copyright (C) 2008-2014 TrinityCore <http://www.trinitycore.org/>
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

file(GLOB_RECURSE mmap_gen_sources *.cpp *.h)

set(mmap_gen_Includes
  ${CMAKE_BINARY_DIR}
  ${CMAKE_BINARY_DIR}/hwc_project
  ${CMAKE_BINARY_DIR}/wowengine_project
  ${CMAKE_BINARY_DIR}/wowengine_dep
  ${CMAKE_WOWENGINE_MODULES_DIR}/dep/libmpq
  ${CMAKE_TCECPP_DEP}/zlib
  ${CMAKE_TCECPP_DEP}/bzip2
  ${CMAKE_TCECPP_DEP}/g3dlite/include
  ${CMAKE_TCECPP_DEP}/recastnavigation/Recast
  ${CMAKE_TCECPP_DEP}/recastnavigation/Recast/Include
  ${CMAKE_TCECPP_DEP}/recastnavigation/Detour
  ${CMAKE_TCECPP_DEP}/recastnavigation/Detour/Include
  ${CMAKE_TCECPP_LIBRARIES}  
  ${CMAKE_TCECPP_LIBRARIES}/Common
  ${CMAKE_TCECPP_LIBRARIES}/Threading
  ${CMAKE_TCECPP_LIBRARIES}/Utilities
  ${CMAKE_WOWENGINE_335a_DIR}/world/Conditions
  ${CMAKE_WOWENGINE_LIB_DIR}/collision
  ${CMAKE_WOWENGINE_LIB_DIR}/collision/Management
  ${CMAKE_WOWENGINE_LIB_DIR}/collision/Maps
  ${CMAKE_WOWENGINE_LIB_DIR}/collision/Models
)

if( WIN32 )
  set(mmap_gen_Includes
    ${mmap_gen_Includes}
    ${CMAKE_WOWENGINE_MODULES_DIR}/dep/libmpq/win
    )
endif()

include_directories(${mmap_gen_Includes})

add_executable(mmaps_generator ${mmap_gen_sources})

target_link_libraries(mmaps_generator
  collision
  g3dlib
  Recast
  Detour
  ${BZIP2_LIBRARIES}
  ${ZLIB_LIBRARIES}
  ${CMAKE_THREAD_LIBS_INIT}
  ${Boost_LIBRARIES}
)

if( UNIX )
  install(TARGETS mmaps_generator DESTINATION bin)
elseif( WIN32 )
  install(TARGETS mmaps_generator DESTINATION "${CMAKE_INSTALL_PREFIX}")
endif()
