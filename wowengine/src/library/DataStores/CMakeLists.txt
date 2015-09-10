# * Copyright (C) 2007 - 2014 Hyperweb2 All rights reserved.
# * GNU General Public License version 3; see www.hyperweb2.com/terms/

if (NOT WOWENGINE_LIB_DATASTORE)
  set(WOWENGINE_LIB_DATASTORE ON)
else()
  return()
endif()

TCE_SET_PATH("CMAKE_WOWENGINE_LIB_DATASTORE_DIR" "${CMAKE_WOWENGINE_LIB_DIR}/DataStores")

file(GLOB_RECURSE hwc_sources_Datastores "${CMAKE_WOWENGINE_LIB_DATASTORE_DIR}/*.cpp" "${CMAKE_WOWENGINE_LIB_DATASTORE_DIR}/*.h")

if (USE_COREPCH)
    set(hwc_extra_STAT_SRC
        ${hwc_extra_STAT_SRC}
        ${hwc_sources_Datastores}
    )
    # update global
    TCE_SET_GLOBAL("hwc_extra_STAT_SRC" "${hwc_extra_STAT_SRC}")
else()
    TCE_LOAD_INC_PATHS()

    add_library(hwc_lib_datastores STATIC
      ${hwc_sources_Datastores}
    )

    TCE_ADD_CORE_TG("hwc_lib_datastores")
endif()