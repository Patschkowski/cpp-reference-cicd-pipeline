# C++ Reference CI/CD Pipeline

We believe that code quality and fast software development can go hand-in-hand
when facilitated by a strong CI/CD pipeline without the need of a complex
quality management system (QMS).

![Build and Test](https://github.com/patschkowski/cpp-reference-cicd-pipeline/actions/workflows/build-and-test.yml/badge.svg)
[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=Patschkowski_cpp-reference-cicd-pipeline&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=Patschkowski_cpp-reference-cicd-pipeline)

## Verification and Validation

Two levels of testing are set up in this project: unit testing and system
testing.

For both testing approaches
[OpenCppCoverage](https://github.com/OpenCppCoverage/OpenCppCoverage) is
used in the pipeline to generate the line coverage that is then directly
imported into [SonarCloud](https://www.sonarsource.com/products/sonarcloud/).
As this is a C++ project, SonarCloud receives the test reports in the
CPPUnit format which is accomplished by applying an XSLT transformation
[tests\junit-to-cppunit.xsl](tests\junit-to-cppunit.xsl) to the generated
JUnit test reports.

### Unit Testing

Unit testing is done in terms of the
[Boost.Test](https://www.boost.org/doc/libs/1_87_0/libs/test/doc/html/index.html)
unit testing framework as it integrates well with Visual Studio and
most-likely, one will anyway already be using Boost. In this project it the
tests are also wrapped by CTest as it can generate test reports in the JUnit
format. The expectation is that the project practices Test Driven Development
(TDD).

### System Testing

System testing is done using the
[behave](https://behave.readthedocs.io/en/stable/index.html) framework. Again,
the expectation is that the project practices Behavior Driven Development
(BDD) as we believe that documenting the requirements in a formal way using
[Gherkin syntax](https://behave.readthedocs.io/en/stable/gherkin.html#gherkin-feature-testing-language)
is more practical than using a separate requirements management tool that is
difficult to keep in sync with the repository. _Behave_ generates JUnit
formatted test reports as well.

### Static Analysis

For the MSVC compiler the Microsoft code analysis is enabled (c.f.
[CMakePresets.json](CMakePresets.json)). For the Clang compiler clang-tidy is
executed, controlled via [.clang-tidy](.clang-tidy). Furthermore,
[cppcheck](http://cppcheck.net/) runs during the build pipeline.

### Formal Verification

#### Frama-C

#### SeaHorn

## Documentation

[Doxygen](https://www.doxygen.nl/index.html) generates the documentation from
the source files itself, supported by
[Doxygen Awesome](https://jothepro.github.io/doxygen-awesome-css/) to give it
a modern look.

## Naming Convention

As per
[C++ Core Guidelines - NL: Naming and layout suggestions](https://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines#S-naming)
defined in the [.clang-format](.clang-format).

## Folder Structure

The folder structure is based on
[P1204R0 - Canonical Project Structure](https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2018/p1204r0.html)
with the exception that for C++ modules the extension `.cppm` is used as per
[Clang's file name requirements](https://releases.llvm.org/20.1.0/tools/clang/docs/StandardCPlusPlusModules.html#file-name-requirements).

## Dependency management

In principle external dependencies are managed using
[vcpkg](https://vcpkg.io/) with the [vcpkg.json](vcpkg.json) configuration
file. However, some external dependencies have to be drawn in directly. That
is done via the [third_party](third_party) folder and
[git submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules).
