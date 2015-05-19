add_executable(main main.c util.c)
add_executable(tests util.c tests.cpp first_test.cpp)
set_target_properties(main tests PROPERTIES CXX_STANDARD 11)
