# * Copyright (C) 2007 - 2014 Hyperweb2 All rights reserved.
# * GNU General Public License version 3; see www.hyperweb2.com/terms/

#
# before include this library , you must load relative "core" project
#

if (NOT TCE_LIB_DATABASE)
  set(TCE_LIB_DATABASE ON)
else()
  return()
endif()

TCE_SET_PATH("CMAKE_WOWENGINE_LIB_DATABASE_DIR" "${CMAKE_WOWENGINE_LIB_DIR}/Database")

# add libraries
TCE_SUBDIRLIST(sub_DIRS  "${CMAKE_WOWENGINE_LIB_DATABASE_DIR}" TRUE)
FOREACH(subdir ${sub_DIRS})
    # skip precompiledheaders that must be included separately
    if (NOT "${subdir}" STREQUAL "${CMAKE_WOWENGINE_LIB_DATABASE_DIR}/PrecompiledHeaders")
        file(GLOB tce_lib_database_sources "${subdir}/*.cpp" "${subdir}/*.h")

        set(tce_lib_database_srcs
            ${tce_lib_database_sources}
            ${tce_lib_database_srcs}
        )

        set(tce_lib_database_dirs
            ${subdir}
            ${tce_lib_database_dirs}
        )

    endif()
ENDFOREACH()

file(GLOB tce_sources_DATABASE "${CMAKE_WOWENGINE_LIB_DATABASE_DIR}/*.cpp" "${CMAKE_WOWENGINE_LIB_DATABASE_DIR}/*.h")

TCE_ADD_INC_PATH("${tce_lib_database_dirs}")


if (USE_COREPCH)
    set(tce_extra_STAT_SRC
        ${tce_extra_STAT_SRC}
        ${tce_sources_DATABASE}
        ${tce_lib_database_srcs}
    )
    # update global 
    TCE_SET_GLOBAL("tce_extra_STAT_SRC" "${tce_extra_STAT_SRC}")

    # [TODO] enable pch for database only? now we've included it in sharedPCH instead
    #set(database_STAT_PCH_HDR PrecompiledHeaders/databasePCH.h)
    #set(database_STAT_PCH_SRC PrecompiledHeaders/databasePCH.cpp)
    #add_cxx_pch(tce_extra_STAT_SRC ${database_STAT_PCH_HDR} ${database_STAT_PCH_SRC})
else()
    TCE_LOAD_INC_PATHS()

    add_library(tce_lib_database STATIC
      ${tce_sources_DATABASE}
      ${tce_lib_database_srcs}
    )

    TCE_ADD_CORE_TG("tce_lib_database")
endif()