#define BOOST_TEST_MODULE libhello Tests
#include <boost/test/included/unit_test.hpp>

import hello;

BOOST_AUTO_TEST_SUITE(libhello_tests)

BOOST_AUTO_TEST_CASE(say_hello_greets_name)
{
  std::ostringstream oss;

  hello::say_hello(oss, "world");
  BOOST_TEST(oss.str() == "Hello, world!\n");
}

BOOST_AUTO_TEST_SUITE_END()
