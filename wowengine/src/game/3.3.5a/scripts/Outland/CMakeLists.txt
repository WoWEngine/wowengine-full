# * Copyright (C) 2007 - 2014 Hyperweb2 All rights reserved.
# * GNU General Public License version 3; see www.hyperweb2.com/terms/

file(GLOB_RECURSE current_dir_SRCS "${CMAKE_CURRENT_LIST_DIR}/*.cpp" "${CMAKE_CURRENT_LIST_DIR}/*.h")

set(scripts_STAT_SRCS
  ${scripts_STAT_SRCS}
  ${current_dir_SRCS}
)

message("  -> Prepared: Outland")
