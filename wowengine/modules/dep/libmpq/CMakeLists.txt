# Copyright (C) 2008-2015 TrinityCore <http://www.trinitycore.org/>
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

file(GLOB sources_mpq ${CMAKE_CURRENT_LIST_DIR}/libmpq/*.c ${CMAKE_CURRENT_LIST_DIR}/libmpq/*.h)

set(mpq_STAT_SRCS
  ${sources_mpq}
)

if( UNIX )
include_directories(
  ${CMAKE_CURRENT_LIST_DIR}
  ${CMAKE_TCECPP_DEP}/zlib
  ${CMAKE_TCECPP_DEP}/bzip2
)
elseif( WIN32 )
  include_directories(
    ${CMAKE_CURRENT_LIST_DIR}/win
  )
endif()

add_library(mpq STATIC ${mpq_STAT_SRCS})

set_target_properties(mpq PROPERTIES LINKER_LANGUAGE CXX)
