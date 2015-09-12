# Copyright (C) 2008-2014 TrinityCore <http://www.trinitycore.org/>
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

file(GLOB_RECURSE sources_CommandLine ${CMAKE_CURRENT_LIST_DIR}/CommandLine/*.cpp ${CMAKE_CURRENT_LIST_DIR}/CommandLine/*.h)
file(GLOB_RECURSE sources_RemoteAccess ${CMAKE_CURRENT_LIST_DIR}/RemoteAccess/*.cpp ${CMAKE_CURRENT_LIST_DIR}/RemoteAccess/*.h)
file(GLOB_RECURSE sources_TCSoap ${CMAKE_CURRENT_LIST_DIR}/TCSoap/*.cpp ${CMAKE_CURRENT_LIST_DIR}/TCSoap/*.h)
file(GLOB sources_localdir ${CMAKE_CURRENT_LIST_DIR}/*.cpp ${CMAKE_CURRENT_LIST_DIR}/*.h)

if (USE_COREPCH)
  set(worldserver_PCH_HDR ${CMAKE_CURRENT_LIST_DIR}/PrecompiledHeaders/worldPCH.h)
  set(worldserver_PCH_SRC ${CMAKE_CURRENT_LIST_DIR}/PrecompiledHeaders/worldPCH.cpp)
endif()

set(worldserver_SRCS
  ${worldserver_SRCS}
  ${sources_CommandLine}
  ${sources_RemoteAccess}
  ${sources_TCSoap}
  ${sources_localdir}
)

if( WIN32 )
  set(worldserver_SRCS
    ${worldserver_SRCS}
    ${CMAKE_TCECPP_LIBRARIES}/Debugging/WheatyExceptionReport.cpp
    ${CMAKE_TCECPP_LIBRARIES}/Debugging/WheatyExceptionReport.h
  )
  if ( MSVC )
    set(worldserver_SRCS
      ${worldserver_SRCS}
      ${CMAKE_CURRENT_LIST_DIR}/worldserver.rc
    )
  endif()
endif()

TCE_LOAD_INC_PATHS()

set(include_dirs
  ${CMAKE_CURRENT_LIST_DIR}/CommandLine
  ${CMAKE_CURRENT_LIST_DIR}/RemoteAccess
  ${CMAKE_CURRENT_LIST_DIR}/TCSoap
)

TCE_ADD_INC_PATH("${include_dirs}")

add_executable(worldserver
  ${worldserver_SRCS}
  ${worldserver_PCH_SRC}
)

if( NOT WIN32 )
  TCE_GET_GLOBAL("CONF_DIR")
  set_target_properties(worldserver PROPERTIES
    COMPILE_DEFINITIONS _TRINITY_CORE_CONFIG="${CONF_DIR}/worldserver.conf"
  )
endif()

add_dependencies(worldserver revision_data.h)

if( UNIX AND NOT NOJEM AND NOT APPLE )
  set(worldserver_LINK_FLAGS "-pthread -lncurses ${worldserver_LINK_FLAGS}")
endif()

set_target_properties(worldserver PROPERTIES LINK_FLAGS "${worldserver_LINK_FLAGS}")

TCE_GET_GLOBAL("TCE_CORE_TGS")

target_link_libraries(worldserver
  world
  ${TCE_CORE_TGS}
  scripts
  g3dlib
  gsoap
  mods
  Detour
  format
  ${JEMALLOC_LIBRARY}
  ${READLINE_LIBRARY}
  ${TERMCAP_LIBRARY}
  ${MYSQL_LIBRARY}
  ${OPENSSL_LIBRARIES}
  ${ZLIB_LIBRARIES}
  ${CMAKE_THREAD_LIBS_INIT}
  ${Boost_LIBRARIES}
)

if( WIN32 )
  if ( MSVC )
    add_custom_command(TARGET worldserver
      POST_BUILD
      COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_LIST_DIR}/worldserver.conf.dist ${CMAKE_BINARY_DIR}/bin/$(ConfigurationName)/
    )
  elseif ( MINGW )
    add_custom_command(TARGET worldserver
      POST_BUILD
      COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_LIST_DIR}/worldserver.conf.dist ${CMAKE_BINARY_DIR}/bin/
    )
  endif()
endif()

if( UNIX )
  install(TARGETS worldserver DESTINATION bin)
  install(FILES ${CMAKE_CURRENT_LIST_DIR}/worldserver.conf.dist DESTINATION ${CONF_DIR})
elseif( WIN32 )
  install(TARGETS worldserver DESTINATION "${CMAKE_INSTALL_PREFIX}")
  install(FILES ${CMAKE_CURRENT_LIST_DIR}/worldserver.conf.dist DESTINATION "${CMAKE_INSTALL_PREFIX}")
endif()

# Generate precompiled header
if( USE_COREPCH )
  add_cxx_pch(worldserver ${worldserver_PCH_HDR} ${worldserver_PCH_SRC})
endif()
