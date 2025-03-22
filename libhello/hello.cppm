/// @file
/// Module interface unit.

module;

// C++ Standard Library
#include <iosfwd>
#include <string_view>

// CMake generated export header.
#include "libhello_export.h"

/// Provides functionality for personalized greetings.
export module hello;

/// Groups functionality to personally greet people.
export namespace hello
{
  /// @brief Says hello to a @p name.
  /// @param[inout] os Output stream that receives the greeting.
  /// @param[in] name Name of the person to greet. 
  LIBHELLO_EXPORT void say_hello(std::ostream& os, std::string_view name);
}
