function(boosttest_discover_tests TARGET)
  add_custom_command(
    TARGET ${TARGET}
    POST_BUILD
    COMMAND ${CMAKE_COMMAND} ARGS
      -D "TARGET=${TARGET}"
      -D "EXE=$<TARGET_FILE:${TARGET}>"
      -P "${CMAKE_CURRENT_FUNCTION_LIST_DIR}/ListContentAndWriteTestsScript.cmake"
    VERBATIM)

  configure_file(
    ${CMAKE_CURRENT_FUNCTION_LIST_DIR}/include_tests.cmake.in
    "${TARGET}-include_tests.cmake")

  set_property(DIRECTORY
    APPEND
    PROPERTY
      TEST_INCLUDE_FILES "${CMAKE_CURRENT_BINARY_DIR}/${TARGET}-include_tests.cmake")
endfunction()
