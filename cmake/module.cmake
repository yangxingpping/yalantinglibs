# module-list
set(yLT_ALL_PROJECTS "struct_pack;struct_json;coro_rpc;util")
# separate
option(Build_ylt_struct_pack "Build struct_pack" ON)
option(Build_ylt_struct_json "Build struct_json" ON)
option(Build_ylt_coro_rpc "Build coro_rpc" ON)
option(Build_ylt_util "Build util" OFF)

foreach(proj ${yLT_ALL_PROJECTS})
    set(build_proj "Build_ylt_${proj}")
    if(${build_proj})
        list(APPEND yLT_ENABLE_PROJECTS ${proj})
    endif()
endforeach()

message(STATUS "yLT_ENABLE_PROJECTS: ${yLT_ENABLE_PROJECTS}")

foreach(module ${yLT_ENABLE_PROJECTS})
    set(module_location ${CMAKE_SOURCE_DIR}/src/${module})
    if(EXISTS ${module_location})
        add_subdirectory(${module_location})
        if(BUILD_UNIT_TESTS AND EXISTS "${module_location}/tests")
            message(STATUS "ylt_add_tests_${module}")
            add_subdirectory(${module_location}/tests)
        endif()
        if(BUILD_BENCHMARK AND EXISTS "${module_location}/benchmark")
            message(STATUS "ylt_add_benchmark_${module}")
            add_subdirectory(${module_location}/benchmark)
        endif()
        if(BUILD_EXAMPLES AND EXISTS "${module_location}/examples")
            message(STATUS "ylt_add_example_${module}")
            add_subdirectory(${module_location}/examples)
        endif()
    endif()
endforeach()
