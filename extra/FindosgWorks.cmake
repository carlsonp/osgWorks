# - Find a osgWorks installation or build tree.
# The following variables are set if osgWorks is found.  If osgWorks is not
# found, osgWorks_FOUND is set to false.
#  osgWorks_FOUND         - Set to true when osgWorks is found.
#  osgWorks_INCLUDE_DIRS  - Include directories for osgWorks
#  osgWorks_LIBRARY_DIRS  - Link directories for osgWorks libraries

# TODO: use Version.h header file and figure out exact version


set(osgWorks_FOUND false)

find_path(
	osgWorks_INCLUDE_DIRS
		osgwTools/Version.h
	PATH_SUFFIXES
		include
	PATHS
		/usr
		/usr/local
)

set(osgWorks_Components osgwControls osgwMx osgwQuery osgwTools)

foreach(component ${osgWorks_Components})
	find_library(
		osgWorks_${component}_LIB
			${component}
		PATH_SUFFIXES
			lib
			lib64
		PATHS
			/usr
			/usr/local
	)
	if(osgWorks_${component}_LIB)
		list(APPEND osgWorks_LIBRARY_DIRS ${osgWorks_${component}_LIB})
	else()
		message(FATAL_ERROR "osgWorks: Unable to find ${component}")
	endif()
	#Clear out the variable so it doesn't show up in CMake
	unset(osgWorks_${component}_LIB CACHE)
endforeach()


if( NOT osgWorks_INCLUDE_DIRS OR NOT osgWorks_LIBRARY_DIRS )
	message(FATAL_ERROR "osgworks not found.")
else()
	set(osgWorks_FOUND true)
	message(STATUS "osgworks found: ${osgWorks_INCLUDE_DIRS}")
	message(STATUS "osgworks libraries: ${osgWorks_LIBRARY_DIRS}") #Figure out why this variable doesn't show up in CMake GUI
endif()
