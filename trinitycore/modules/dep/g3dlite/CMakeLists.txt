# Copyright (C) 2008-2014 TrinityCore <http://www.trinitycore.org/>
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

set(CURDIR ${CMAKE_TCECPP_DEP})

set(g3dlib_STAT_SRCS
  ${CMAKE_CURRENT_LIST_DIR}/source/AABox.cpp
  ${CMAKE_CURRENT_LIST_DIR}/source/Any.cpp
  ${CMAKE_CURRENT_LIST_DIR}/source/AnyTableReader.cpp
  ${CMAKE_CURRENT_LIST_DIR}/source/BinaryFormat.cpp
  ${CMAKE_CURRENT_LIST_DIR}/source/BinaryInput.cpp
  ${CMAKE_CURRENT_LIST_DIR}/source/BinaryOutput.cpp
  ${CMAKE_CURRENT_LIST_DIR}/source/Box.cpp
  ${CMAKE_CURRENT_LIST_DIR}/source/Capsule.cpp
  ${CMAKE_CURRENT_LIST_DIR}/source/CollisionDetection.cpp
  ${CMAKE_CURRENT_LIST_DIR}/source/CoordinateFrame.cpp
  ${CMAKE_CURRENT_LIST_DIR}/source/Crypto.cpp
  ${CMAKE_CURRENT_LIST_DIR}/source/Cylinder.cpp
  ${CMAKE_CURRENT_LIST_DIR}/source/debugAssert.cpp
  ${CMAKE_CURRENT_LIST_DIR}/source/FileSystem.cpp
  ${CMAKE_CURRENT_LIST_DIR}/source/fileutils.cpp
  ${CMAKE_CURRENT_LIST_DIR}/source/format.cpp
  ${CMAKE_CURRENT_LIST_DIR}/source/g3dfnmatch.cpp
  ${CMAKE_CURRENT_LIST_DIR}/source/g3dmath.cpp
  ${CMAKE_CURRENT_LIST_DIR}/source/GThread.cpp
  ${CMAKE_CURRENT_LIST_DIR}/source/Line.cpp
  ${CMAKE_CURRENT_LIST_DIR}/source/LineSegment.cpp
  ${CMAKE_CURRENT_LIST_DIR}/source/Log.cpp
  ${CMAKE_CURRENT_LIST_DIR}/source/Matrix3.cpp
  ${CMAKE_CURRENT_LIST_DIR}/source/Matrix4.cpp
  ${CMAKE_CURRENT_LIST_DIR}/source/MemoryManager.cpp
  ${CMAKE_CURRENT_LIST_DIR}/source/PhysicsFrame.cpp
  ${CMAKE_CURRENT_LIST_DIR}/source/Plane.cpp
  ${CMAKE_CURRENT_LIST_DIR}/source/prompt.cpp
  ${CMAKE_CURRENT_LIST_DIR}/source/Quat.cpp
  ${CMAKE_CURRENT_LIST_DIR}/source/Random.cpp
  ${CMAKE_CURRENT_LIST_DIR}/source/Ray.cpp
  ${CMAKE_CURRENT_LIST_DIR}/source/RegistryUtil.cpp
  ${CMAKE_CURRENT_LIST_DIR}/source/Sphere.cpp
  ${CMAKE_CURRENT_LIST_DIR}/source/stringutils.cpp
  ${CMAKE_CURRENT_LIST_DIR}/source/System.cpp
  ${CMAKE_CURRENT_LIST_DIR}/source/TextInput.cpp
  ${CMAKE_CURRENT_LIST_DIR}/source/TextOutput.cpp
  ${CMAKE_CURRENT_LIST_DIR}/source/Triangle.cpp
  ${CMAKE_CURRENT_LIST_DIR}/source/uint128.cpp
  ${CMAKE_CURRENT_LIST_DIR}/source/UprightFrame.cpp
  ${CMAKE_CURRENT_LIST_DIR}/source/Vector2.cpp
  ${CMAKE_CURRENT_LIST_DIR}/source/Vector3.cpp
  ${CMAKE_CURRENT_LIST_DIR}/source/Vector4.cpp
)

if(WIN32)
  include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}/include
    ${CMAKE_SOURCE_DIR}/dep/zlib
  )
else()
  include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}/include
  )
endif()

add_library(g3dlib STATIC ${g3dlib_STAT_SRCS})

target_link_libraries(g3dlib
  ${ZLIB_LIBRARIES}
  ${CMAKE_THREAD_LIBS_INIT}
)
