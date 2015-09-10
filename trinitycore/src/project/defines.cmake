# * Copyright (C) 2007 - 2014 Hyperweb2 All rights reserved.
# * GNU General Public License version 3; see www.hyperweb2.com/terms/

if (NOT TCE_DEFINES)
  set(TCE_DEFINES ON)
else()
  return()
endif()

message("loading defines...")

# CMake policies (can not be handled elsewhere)
cmake_minimum_required(VERSION 2.8.9)
cmake_policy(SET CMP0005 OLD)
if(POLICY CMP0043)
  cmake_policy(SET CMP0043 OLD) # Disable 'Ignore COMPILE_DEFINITIONS_<Config> properties'
endif(POLICY CMP0043)

# set macro-directory
set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake/macros")

include(Utils)

# add this options before PROJECT keyword
TCE_SET_CACHE(CMAKE_DISABLE_SOURCE_CHANGES ON)
TCE_SET_CACHE(CMAKE_DISABLE_IN_SOURCE_BUILD ON)

# Set RPATH-handing (CMake parameters)
TCE_SET_CACHE(CMAKE_SKIP_BUILD_RPATH 0)
TCE_SET_CACHE(CMAKE_BUILD_WITH_INSTALL_RPATH 0)
TCE_SET_CACHE(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/lib")
TCE_SET_CACHE(CMAKE_INSTALL_RPATH_USE_LINK_PATH 1)

# Set TCE directories
get_filename_component(PROJECT_MODULES_ROOT_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../" REALPATH)
TCE_SET_PATH("CMAKE_TCE_ROOT_DIR"  "${PROJECT_MODULES_ROOT_DIR}/trinitycore")
TCE_SET_PATH("CMAKE_TCECPP_SRC" "${CMAKE_TCE_ROOT_DIR}/src")
TCE_SET_PATH("CMAKE_TCECPP_PROJECT" "${CMAKE_TCECPP_SRC}/project")
TCE_SET_PATH("CMAKE_TCECPP_LIBRARIES" "${CMAKE_TCECPP_SRC}/library")
TCE_SET_PATH("CMAKE_TCECPP_DEP" "${CMAKE_TCE_ROOT_DIR}/modules/dep")

# build in Release-mode by default if not explicitly set
if( NOT CMAKE_BUILD_TYPE )
  TCE_SET_CACHE(CMAKE_BUILD_TYPE "Release")
endif()

include(CheckCXXSourceRuns)
include(CheckIncludeFiles)

# set default buildoptions and print them
include("${CMAKE_TCECPP_PROJECT}/cmake/options.cmake")

# turn off PCH totally if enabled (hidden setting, mainly for devs)
if( NOPCH )
  TCE_SET_CACHE(USE_COREPCH 0)
endif()

include(CheckPlatform)

# basic packagesearching and setup (further support will be needed, this is a preliminary release!)
TCE_SET_CACHE(OPENSSL_EXPECTED_VERSION 1.0.0)

find_package(PCHSupport)

find_package(OpenSSL REQUIRED)
find_package(Threads REQUIRED)

include(ConfigureBoost)
find_package(MySQL REQUIRED)

if( UNIX )
  find_package(Readline)
  find_package(ZLIB)
  find_package(BZip2)
endif()

if(NOT WITHOUT_GIT)
  find_package(Git)
endif()

# Find revision ID and hash of the sourcetree
include("${CMAKE_TCECPP_PROJECT}/cmake/genrev.cmake")

# print out the results before continuing
include("${CMAKE_TCECPP_PROJECT}/cmake/showoptions.cmake")

set(include_dirs
  ${MYSQL_INCLUDE_DIR}
  ${OPENSSL_INCLUDE_DIR}
  ${VALGRIND_INCLUDE_DIR}
  ${CMAKE_TCECPP_PROJECT}
  ${CMAKE_CURRENT_BINARY_DIR}
  #dependencies
  ${CMAKE_TCECPP_DEP}/bzip2
  ${CMAKE_TCECPP_DEP}/gsoap
  ${CMAKE_TCECPP_DEP}/g3dlite
  ${CMAKE_TCECPP_DEP}/g3dlite/include
  ${CMAKE_TCECPP_DEP}/jemalloc
  ${CMAKE_TCECPP_DEP}/recastnavigation
  ${CMAKE_TCECPP_DEP}/recastnavigation/Detour
  ${CMAKE_TCECPP_DEP}/recastnavigation/Detour/Include
  ${CMAKE_TCECPP_DEP}/recastnavigation/Recast
  ${CMAKE_TCECPP_DEP}/recastnavigation/Recast/Include
  ${CMAKE_TCECPP_DEP}/SFMT
  ${CMAKE_TCECPP_DEP}/utf8cpp
  ${CMAKE_TCECPP_DEP}/zlib
)

TCE_ADD_INC_PATH("${include_dirs}")

# add dependencies [TODO: reorganize ]
add_subdirectory("${CMAKE_TCECPP_DEP}" "${CMAKE_BINARY_DIR}/dep")

# Include defines if not already done
if (NOT TCE_DEFINES)
    include("${CMAKE_CURRENT_LIST_DIR}/defines.cmake")
endif()

include("${CMAKE_TCECPP_PROJECT}/genrev/CMakeLists.txt")

