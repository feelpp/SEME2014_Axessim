cmake_minimum_required(VERSION 2.8)
find_path(FEELPP_CMAKE_MODULES FindFeel++.cmake PATHS /usr/share/feel/cmake/modules/ /usr/local/share/feel/cmake/modules/ )
if(FEELPP_CMAKE_MODULES)
    set(CMAKE_MODULE_PATH ${FEELPP_CMAKE_MODULES})
else()
    message(FATAL_ERROR "Feel++ does not seem to have been installed on this platform")
endif()
find_package(Feel++)

feelpp_add_application( multiwires
                        SRCS multiwires.cpp
                        CFG multiwires.cfg
                        GEO cwires.geo
                        LABELS seme2014
                        INCLUDE_IN_ALL )
