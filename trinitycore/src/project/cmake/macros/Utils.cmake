
#
# TCE_SUBDIRLIST
#
FUNCTION(TCE_SUBDIRLIST result curdir recursive)
  # glob recurse seem's doesn't work
  FILE(GLOB children RELATIVE ${curdir} "${curdir}/[^\\.]*")
  SET(dirlist "")
  FOREACH(child ${children})
    IF(IS_DIRECTORY "${curdir}/${child}")
        if (recursive)
          TCE_SUBDIRLIST(sub_Dirs "${curdir}/${child}" TRUE)
          SET(dirlist "${curdir}/${child}" ${sub_Dirs} ${dirlist})
        else()
          SET(dirlist "${curdir}/${child}" ${dirlist}) 
        endif()
    ENDIF()
  ENDFOREACH()
  SET(${result} ${dirlist} PARENT_SCOPE)
ENDFUNCTION(TCE_SUBDIRLIST curdir recursive)

#
# TCE_SET_GLOBAL
#
MACRO(TCE_SET_GLOBAL name val)
  set_property ( GLOBAL PROPERTY ${name} ${val})
  # after set , create the variable for current scope
  TCE_GET_GLOBAL(${name})
ENDMACRO()

#
# TCE_GET_GLOBAL
#
MACRO(TCE_GET_GLOBAL name)
  get_property(${name} GLOBAL PROPERTY ${name})
ENDMACRO()

#
# TCE_SET_CACHE
#
MACRO(TCE_SET_CACHE name val)
  set(${name} ${val} CACHE INTERNAL "TCE Var")
ENDMACRO()


#
# TCE_SET_PATH
#
MACRO(TCE_SET_PATH name val)
  TCE_SET_CACHE(${name} ${val})

  TCE_ADD_INC_PATH(${val})
ENDMACRO()

#
# TCE_ADD_INC_PATH
#
MACRO(TCE_ADD_INC_PATH val)
    set(TCE_INC_PATHS
        ${TCE_INC_PATHS}
        ${val}
    )
    #update cache
    TCE_SET_CACHE("TCE_INC_PATHS" ${TCE_INC_PATHS})
    include_directories(${val})
ENDMACRO()


#
# TCE_LOAD_INC_PATHS
#
MACRO(TCE_LOAD_INC_PATHS)
  include_directories(${TCE_INC_PATHS})
ENDMACRO()

#
# TCE_SET_PARENT
#
MACRO(TCE_SET_PARENT name val)
  set(${name} ${val} PARENT_SCOPE)
ENDMACRO()

#
# TCE_ADD_CORE_TG
#
MACRO(TCE_ADD_CORE_TG val)
    TCE_GET_GLOBAL("TCE_CORE_TGS")

    set(TCE_CORE_TGS
        ${TCE_CORE_TGS}
        ${val}
    )
    #update cache
    TCE_SET_GLOBAL("TCE_CORE_TGS" "${TCE_CORE_TGS}")
ENDMACRO()

