# check what platform we're on (64-bit or 32-bit), and create a simpler test than CMAKE_SIZEOF_VOID_P
if(CMAKE_SIZEOF_VOID_P MATCHES 8)
    TCE_SET_CACHE(PLATFORM 64)
    MESSAGE(STATUS "Detected 64-bit platform")
else()
    TCE_SET_CACHE(PLATFORM 32)
    MESSAGE(STATUS "Detected 32-bit platform")
endif()

include("${CMAKE_TCECPP_PROJECT}/cmake/platform/settings.cmake")

if(WIN32)
  include("${CMAKE_TCECPP_PROJECT}/cmake/platform/win/settings.cmake")
elseif(UNIX)
  include("${CMAKE_TCECPP_PROJECT}/cmake/platform/unix/settings.cmake")
endif()
