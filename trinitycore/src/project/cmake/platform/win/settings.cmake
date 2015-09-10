# Package overloads
TCE_SET_CACHE(BZIP2_LIBRARIES "bzip2")
TCE_SET_CACHE(ZLIB_LIBRARIES "zlib")

# check the CMake preload parameters (commented out by default)

# overload CMAKE_INSTALL_PREFIX if not being set properly
#if( WIN32 )
#  if( NOT CYGWIN )
#    if( NOT CMAKE_INSTALL_PREFIX )
#      set(CMAKE_INSTALL_PREFIX "${CMAKE_BINARY_DIR}/bin")
#    endif()
#  endif()
#endif()

if ( MSVC )
  include(${CMAKE_TCECPP_PROJECT}/cmake/compiler/msvc/settings.cmake)
elseif ( MINGW )
  include(${CMAKE_TCECPP_PROJECT}/cmake/compiler/mingw/settings.cmake)
endif()
