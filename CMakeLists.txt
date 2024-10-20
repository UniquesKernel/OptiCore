cmake_minimum_required(VERSION 3.14)

# Project definition
project(Sim8086
  VERSION 0.1
  LANGUAGES C CXX ASM
)

# Set C standard
set(CMAKE_C_STANDARD 99)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Set default build type if not specified
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Debug)
  message(STATUS "No build type specified, defaulting to Debug")
endif()

# Linker flags for Unix
if(UNIX)
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -z noexecstack")
  set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -z noexecstack")
endif()

# Automatically gather all C, ASM, and header files from src and include directories
file(GLOB_RECURSE C_SOURCES "${PROJECT_SOURCE_DIR}/src/*.c")
file(GLOB_RECURSE CXX_SOURCES "${PROJECT_SOURCE_DIR}/src/*.cpp")
file(GLOB_RECURSE BINDINGS "${PROJECT_SOURCE_DIR}/bindings/*.cpp")
file(GLOB_RECURSE ASM_SOURCES "${PROJECT_SOURCE_DIR}/src/*.s")
file(GLOB_RECURSE HEADERS "${PROJECT_SOURCE_DIR}/include/*.h")

# Gather main source file
set(MAIN_SOURCE "${PROJECT_SOURCE_DIR}/main.cpp")

# Include directories
include_directories(${PROJECT_SOURCE_DIR}/include)
include_directories(${PROJECT_SOURCE_DIR}/include/Instructions)

# Set output directories
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

# Create the executable from all sources
add_executable(Sim8086 ${MAIN_SOURCE} ${C_SOURCES} ${ASM_SOURCES} ${CXX_SOURCES})

# Python execution for running hypothesis tests
find_package(pybind11 REQUIRED)
find_program(PYTHON_EXEC python3 REQUIRED)

# Create the Python module
pybind11_add_module(sim8086_py
  ${C_SOURCES}
  ${CXX_SOURCES}
  ${ASM_SOURCES}
  ${BINDINGS}
)

# Create shared library for testing purposes
add_library(_testing_bundle SHARED ${C_SOURCES} ${ASM_SOURCES} ${CXX_SOURCES})


# Custom target to run tests using pytest with valgrind
add_custom_target(
  run_tests
  WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
  COMMAND valgrind ${PYTHON_EXEC} -m pytest --hypothesis-show-statistics tests/
)

# Ensure the shared library is built before running tests
add_dependencies(run_tests _testing_bundle)
# Ensure the Python module is built before running tests
add_dependencies(run_tests sim8086_py)

# Copy compile_commands.json after build if required
if(CMAKE_EXPORT_COMPILE_COMMANDS)
  add_custom_command(
    TARGET Sim8086 POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy
      ${CMAKE_BINARY_DIR}/compile_commands.json
      ${CMAKE_SOURCE_DIR}/compile_commands.json
  )
endif()

