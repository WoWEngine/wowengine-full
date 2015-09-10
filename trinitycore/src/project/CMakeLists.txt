# * Copyright (C) 2007 - 2014 Hyperweb2 All rights reserved.
# * GNU General Public License version 3; see www.hyperweb2.com/terms/


if (NOT TCE_PROJECT)
  set(TCE_PROJECT ON)
else()
  return()
endif()

message("making core project")

# Set projectname (must be done AFTER setting configurationtypes)
if (NOT PROJECT_NAME)
    project(TCE)
endif()

TCE_GET_GLOBAL("hwc_extra_STAT_SRC")
TCE_GET_GLOBAL("hwc_lib_STAT_PCH_SRC")
TCE_GET_GLOBAL("hwc_lib_STAT_PCH_HDR")
TCE_GET_GLOBAL("TCE_CORE_TGS")

TCE_LOAD_INC_PATHS()

# interface library
# we cannot use cmake INTERFACE 
# to support 2.8 version
# so dummy files are needed here
add_library(core STATIC
    "${hwc_lib_STAT_PCH_SRC}"
    "${CMAKE_CURRENT_LIST_DIR}/coreProj.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/coreProj.h"
    ${hwc_extra_STAT_SRC} # list of extra sources
)

set_target_properties(core PROPERTIES LINKER_LANGUAGE CXX)



set(core_targets
  ${TCE_CORE_TGS}
  ${READLINE_LIBRARY}
  ${TERMCAP_LIBRARY}
  ${MYSQL_LIBRARY}
  ${OPENSSL_LIBRARIES}
  ${ZLIB_LIBRARIES}
  ${JEMALLOC_LIBRARY}
  ${CMAKE_THREAD_LIBS_INIT}
  ${Boost_LIBRARIES}
  ${core_targets}
)

target_link_libraries(core
  ${core_targets}
)

TCE_ADD_CORE_TG("core")

if(hwc_lib_STAT_PCH_HDR AND hwc_lib_STAT_PCH_SRC)
    message("adding pch...")
    add_cxx_pch(core ${hwc_lib_STAT_PCH_HDR} ${hwc_lib_STAT_PCH_SRC})
endif()

