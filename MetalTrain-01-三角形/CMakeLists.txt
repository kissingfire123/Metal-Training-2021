cmake_minimum_required(VERSION 3.12)
project(MetalTrain-01 LANGUAGES C CXX)
set (CMAKE_CXX_STANDARD 11)


set(BASE_PROJECT_SRC_FILES 
    src/main.m
    src/AppDelegate.h 
    src/AppDelegate.m 
    src/SceneDelegate.h
    src/SceneDelegate.m
)
source_group(BaseProj FILES  ${BASE_PROJECT_SRC_FILES})

set(VIEWCONTROLLER_FILES
    src/ViewController.m
    src/ViewController.h
)
source_group(ViewController FILES  ${VIEWCONTROLLER_FILES})

set(RESOURCE_FILES 
    assets/LaunchScreen.storyboard
    assets/Main.storyboard)


add_executable(${CMAKE_PROJECT_NAME} MACOSX_BUNDLE 
    ${BASE_PROJECT_SRC_FILES}
    ${VIEWCONTROLLER_FILES}
    ${RESOURCE_FILES})

target_link_libraries(${CMAKE_PROJECT_NAME} "-framework Foundation  -framework UIKit")

set_target_properties(${CMAKE_PROJECT_NAME} PROPERTIES
    XCODE_ATTRIBUTE_PRODUCT_NAME  ${CMAKE_PROJECT_NAME}
    XCODE_ATTRIBUTE_PRODUCT_BUNDLE_IDENTIFIER ${PRODUCT_BUNDLE_IDENTIFIER}
)

set_target_properties(${CMAKE_PROJECT_NAME} PROPERTIES
    MACOSX_BUNDLE YES
    MACOSX_BUNDLE_INFO_PLIST ${CMAKE_CURRENT_SOURCE_DIR}/assets/Info.plist
    XCODE_ATTRIBUTE_ENABLE_BITCODE "NO"
    XCODE_ATTRIBUTE_CLANG_ENABLE_OBJC_ARC YES
    XCODE_ATTRIBUTE_TARGETED_DEVICE_FAMILY "1,2" # iPhone/iPad
    RESOURCE "${RESOURCE_FILES}"
)

# copy bundle resource(eg. Main.storyboard)
set_source_files_properties(${RESOURCE_FILES} PROPERTIES MACOSX_PACKAGE_LOCATION Resources)

# concern apple-m1 run iOS-app regenerate the app with differenr name: demo1, demo2...
add_custom_command(TARGET ${CMAKE_PROJECT_NAME}  PRE_BUILD
     COMMAND rm -rf ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_BUILD_TYPE}-iphoneos/.XCInstall/)
