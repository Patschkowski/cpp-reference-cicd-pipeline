cmake_minimum_required(VERSION 3.30)

project(hello)

option(BUILD_DOC "build documentation" ON)

find_package(Microsoft.GSL CONFIG REQUIRED)

include(CTest)
if(BUILD_TESTING)
  find_package(Boost REQUIRED COMPONENTS unit_test_framework)
endif()

if(BUILD_DOC)
  find_package(Doxygen REQUIRED)
endif()

add_library(libhello)
target_sources(libhello
  PRIVATE
    "libhello/hello.cpp")
target_sources(libhello
  PUBLIC FILE_SET CXX_MODULES FILES
    "libhello/hello.cppm")
target_link_libraries(libhello
  PUBLIC
    Microsoft.GSL::GSL)

add_executable(hello)
target_sources(hello
  PRIVATE
    "hello/hello.cpp")
target_link_libraries(hello
  PRIVATE
    libhello)

if(BUILD_TESTING)
  add_executable(libhello_tests)
  target_sources(libhello_tests
    PRIVATE
      "libhello/hello.test.cpp")
  target_link_libraries(libhello_tests
    PRIVATE
      libhello
      Boost::unit_test_framework)

  add_test(libhello_tests_say_hello_greets_name libhello_tests -t "libhello_tests/say_hello_greets_name")
endif()

if(BUILD_DOC)
  set(DOXYGEN_EXCLUDE_PATTERNS */.vs/* */cmake/* */out/* */tests/* */third_party/*)
  set(DOXYGEN_PLANTUML_JAR_PATH "$ENV{PLANTUML_JAR_PATH}")
  set(DOXYGEN_EXTRACT_PRIVATE TRUE)
  set(DOXYGEN_EXTRACT_STATIC TRUE)
  set(DOXYGEN_ENABLE_PREPROCESSING TRUE)
  set(DOXYGEN_MACRO_EXPANSION TRUE)
  set(DOXYGEN_EXPAND_ONLY_PREDEF TRUE)
  set(DOXYGEN_PREDEFINED "GSL_SUPPRESS(x)=" "STDMETHOD(x)=HRESULT x")
  set(DOXYGEN_IMAGE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/doc")
  set(DOXYGEN_GENERATE_TREEVIEW YES)
  set(DOXYGEN_DISABLE_INDEX NO)
  set(DOXYGEN_FULL_SIDEBAR NO)
  if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/third_party/doxygen-awesome-css/doxygen-awesome.css")
    set(DOXYGEN_HTML_EXTRA_STYLESHEET
      "${CMAKE_CURRENT_SOURCE_DIR}/third_party/doxygen-awesome-css/doxygen-awesome.css"
      "${CMAKE_CURRENT_SOURCE_DIR}/doc/doxygen-awesome-custom.css")
  endif()
  set(DOXYGEN_HTML_COLORSTYLE LIGHT)
  doxygen_add_docs(doxygen ${CMAKE_CURRENT_SOURCE_DIR} ALL)
endif()
