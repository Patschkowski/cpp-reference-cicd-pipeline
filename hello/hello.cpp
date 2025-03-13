// C++ Standard Library
#include <cstdlib>
#include <iostream>

// Guideline Support Library
#include <gsl/span>

import hello;

auto main(int argc, const char** argv) -> int
{
  const gsl::span args(argv, argc);

  if (2 == args.size()) {
    hello::say_hello(std::cout, args[1]);
    return EXIT_SUCCESS;
  }
  else {
    std::cout << "Usage: " << args[0] << " <name>\n";
    return EXIT_FAILURE;
  }
}
