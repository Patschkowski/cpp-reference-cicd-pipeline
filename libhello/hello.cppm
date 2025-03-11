/// @file
/// Module interface unit.

module;

// C++ Standard Library
#include <iosfwd>
#include <string_view>

/// Provides functionality for personalized greetings.
export module hello;

/// Groups functionality to personally greet people.
export namespace hello
{
  /// @brief Says hello to a @p name.
  /// @param[inout] os Output stream that receives the greeting.
  /// @param[in] name Name of the person to greet. 
  void say_hello(std::ostream& os, std::string_view name);
}
