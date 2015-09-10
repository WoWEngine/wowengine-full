# Copyright (C) 2008-2014 TrinityCore <http://www.trinitycore.org/>
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

SET(zlib_STAT_SRCS
  ${CMAKE_CURRENT_LIST_DIR}/adler32.c                                                                                                                                           
  ${CMAKE_CURRENT_LIST_DIR}/compress.c                                                                                                                                          
  ${CMAKE_CURRENT_LIST_DIR}/crc32.c                                                                                                                                             
  ${CMAKE_CURRENT_LIST_DIR}/deflate.c                                                                                                                                           
  ${CMAKE_CURRENT_LIST_DIR}/example.c                                                                                                                                           
  ${CMAKE_CURRENT_LIST_DIR}/infback.c                                                                                                                                           
  ${CMAKE_CURRENT_LIST_DIR}/inffast.c                                                                                                                                           
  ${CMAKE_CURRENT_LIST_DIR}/inflate.c                                                                                                                                           
  ${CMAKE_CURRENT_LIST_DIR}/inftrees.c                                                                                                                                          
  ${CMAKE_CURRENT_LIST_DIR}/trees.c                                                                                                                                             
  ${CMAKE_CURRENT_LIST_DIR}/uncompr.c                                                                                                                                           
  ${CMAKE_CURRENT_LIST_DIR}/zutil.c   
)

include_directories(
  ${CMAKE_CURRENT_LIST_DIR}
)

add_library(zlib STATIC ${zlib_STAT_SRCS})
