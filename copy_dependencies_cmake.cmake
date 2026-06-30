# CMake script to run PowerShell script for copying dependencies
# This is called during post-build phase

# Build config is passed via -D parameter
if (NOT BUILD_CONFIG)
    if (CMAKE_BUILD_TYPE)
        set(BUILD_CONFIG "${CMAKE_BUILD_TYPE}")
    else()
        set(BUILD_CONFIG "Release")
    endif()
endif()

# Source directory is passed via -D parameter
if (NOT SOURCE_DIR)
    set(SOURCE_DIR "${CMAKE_CURRENT_LIST_DIR}")
endif()

message(STATUS "Copying dependencies for ${BUILD_CONFIG} configuration...")

# Execute PowerShell script
execute_process(
    COMMAND powershell.exe -NoProfile -ExecutionPolicy Bypass 
        -File "${SOURCE_DIR}/deploy_deps.ps1"
        -BuildDir "${SOURCE_DIR}/build"
        -Config "${BUILD_CONFIG}"
    RESULT_VARIABLE RESULT
)

if (NOT RESULT EQUAL 0)
    message(WARNING "Dependency copy script failed with code ${RESULT}")
endif()
