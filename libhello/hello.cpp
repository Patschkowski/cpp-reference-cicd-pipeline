/// @file
/// Module implementation unit.

module;

// C++ Standard Library
#include <format>
#include <ostream>
#include <string_view>

// Guideline Support Library
#include <gsl/assert>

module hello;

namespace hello {

void say_hello(std::ostream& os, std::string_view name)
{
  Expects(os);

  os << std::format("Hello, {}!", name) << '\n';
}

}
