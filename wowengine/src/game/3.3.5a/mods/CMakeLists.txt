cmake_minimum_required(VERSION 2.8.9)

if (NOT WOWENGINE_335a_MODS)
  set(WOWENGINE_335a_MODS ON)
else()
  return()
endif()

include("${CMAKE_CURRENT_LIST_DIR}/../CMakeLists.txt")

# Select loader file
if(EXISTS "${CMAKE_WOWENGINE_335a_MODS_DIR}/ModsLoader.h")
  TCE_SET_GLOBAL("MODS_LOADER" ON)
  TCE_ADD_INC_PATH("${CMAKE_WOWENGINE_335a_MODS_DIR}")
else()
  TCE_ADD_INC_PATH("${CMAKE_WOWENGINE_LIB_DIR}/mods/loader")
endif()

MACRO(LOAD_335a_MODS)
    # add mods
    TCE_SUBDIRLIST(sub_DIRS  "${CMAKE_WOWENGINE_335a_MODS_DIR}" FALSE)
    FOREACH(subdir ${sub_DIRS})
      if(EXISTS "${subdir}/CMakeLists.txt")
        include("${subdir}/CMakeLists.txt")
      endif()

        set(mods_DIRS
            ${mods_DIRS}
            ${subdir}
        )

    ENDFOREACH()

    TCE_ADD_INC_PATH(
      "${mods_DIRS}"
    )
ENDMACRO(LOAD_335a_MODS)

message(STATUS "335a MODS PREPARATION COMPLETE")
message("")


#
# BELOW YOU CAN ADD YOUR CUSTOMIZATIONS
#
