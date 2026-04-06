cmake_minimum_required(VERSION 3.12)

# For the --list_conten option, Boost.Test write the output to stderr.
execute_process(
  COMMAND ${EXE} --list_content
  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
  RESULT_VARIABLE RESULT
  ERROR_VARIABLE CONTENT
)

if(NOT RESULT)
  # Turn content into list of lines. One to two empty lines will be created by
  # that depending on how the platform handles the output of the process.
  string(REPLACE "\n" ";" LINES "${CONTENT}")

  # Count the indents in each line.
  set(INDENT_LEVELS "")
  set(SUITES_AND_TESTS "")
  foreach(LINE IN LISTS LINES)
    if(NOT LINE STREQUAL "")
      string(REGEX MATCH "^[ ]*" SPACES "${LINE}")
      string(LENGTH "${SPACES}" SPACE_COUNT)
      string(REGEX REPLACE "(\\*|([* ]:.*))$" "" SUITE_OR_TEST_WITH_INDENTS "${LINE}")
      string(STRIP "${SUITE_OR_TEST_WITH_INDENTS}" SUITE_OR_TEST)
      math(EXPR INDENT_LEVEL "${SPACE_COUNT} / 4")
      list(APPEND INDENT_LEVELS ${INDENT_LEVEL})
      list(APPEND SUITES_AND_TESTS ${SUITE_OR_TEST})
    endif()
  endforeach()

  list(LENGTH SUITES_AND_TESTS COUNT)
  if(COUNT GREATER 0)
    set(TESTS "")
    math(EXPR LAST_IDX "${COUNT} - 1")
    set(STACK "")
    foreach(IDX RANGE ${LAST_IDX})
      list(GET INDENT_LEVELS ${IDX} CURRENT_INDENT)
      list(GET SUITES_AND_TESTS ${IDX} SUITE_OR_TEST)
      math(EXPR NEXT_IDX "${IDX} + 1")

      list(SUBLIST STACK 0 ${CURRENT_INDENT} STACK)
      list(APPEND STACK ${SUITE_OR_TEST})

      # Leaves are either the last item in the list or the
      # next item has the same indentation as the current.
      if (IDX EQUAL LAST_IDX)
        list(JOIN STACK "/" TEST)
        list(APPEND TESTS ${TEST})
      else()
        list(GET INDENT_LEVELS ${NEXT_IDX} NEXT_INDENT)

        if(NEXT_INDENT LESS_EQUAL CURRENT_INDENT)
          list(JOIN STACK "/" TEST)
          list(APPEND TESTS ${TEST})
        endif()
      endif()
    endforeach()

    set(MODE "WRITE")
    foreach(TEST IN LISTS TESTS)
      file(${MODE}
        "${CMAKE_CURRENT_BINARY_DIR}/${TARGET}-tests.cmake"
        "add_test(\"${TEST}\" \"${EXE}\" \"--run_test=${TEST}\")\n")
      set(MODE "APPEND")
    endforeach()
  elseif(EXISTS "${CMAKE_CURRENT_BINARY_DIR}/${TARGET}-tests.cmake")
    file(REMOVE "${CMAKE_CURRENT_BINARY_DIR}/${TARGET}-tests.cmake")
  endif()
else()
  message(FATAL_ERROR "Failed to run ${EXE} --list_content\n${CONTENT}")
endif()
