cmake_minimum_required(VERSION 3.16)

project(ToGetMathTable VERSION 1.0 LANGUAGES CXX)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
include(GNUInstallDirs)
find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.10)

set(QT_ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")

qt_add_executable(appToGetMathTable
    main.cpp
)

qt_add_qml_module(appToGetMathTable
    URI ToGetMathTable
    VERSION 1.0
    QML_FILES
        Main.qml
        SOURCES mathtable.h mathtable.cpp
        RESOURCES icon.qrc
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appToGetMathTable PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appToGetMathTable
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
    QT_ANDROID_APP_NAME "ToGetMathTable"
    QT_ANDROID_APP_ICON "@mipmap/ic_launcher"
    QT_ANDROID_PACKAGE_NAME "com.madhav.togetmathtable"
    QT_ANDROID_VERSION_CODE 1
    QT_ANDROID_VERSION_NAME ${PROJECT_VERSION}
    QT_ANDROID_ABIS "arm64-v8a"
)

if(ANDROID)
    set_target_properties(appToGetMathTable PROPERTIES
        QT_ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android"
    )

    target_include_directories(appToGetMathTable SYSTEM BEFORE PRIVATE
        "${CMAKE_ANDROID_NDK}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include/c++/v1"
    )
endif()

target_link_libraries(appToGetMathTable
    PRIVATE Qt6::Quick
)

install(TARGETS appToGetMathTable
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

install(FILES com.madhav.ToGetMathTable.desktop
    DESTINATION ${CMAKE_INSTALL_DATADIR}/applications
)
