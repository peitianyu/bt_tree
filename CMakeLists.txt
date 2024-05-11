# 指定cmake版本
cmake_minimum_required(VERSION 3.3)
# 工程名
project(behavior_tree)

#cmake的c++设置
# 告知當前使用的是交叉編譯方式，必須配置
SET(CMAKE_SYSTEM_NAME Linux)
SET(CMAKE_C_COMPILER "gcc")
SET(CMAKE_CXX_COMPILER "g++")
# 设置编译选项
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O0 -Wall -std=c++14 -fPIC -g")

# 运行测试
add_definitions(-DTEST_ENABLE)

# 添加.h文件
include_directories(src src/lib)

file(GLOB_RECURSE ALL_LIBRIRY_SRCS "src/*.c*")


# 执行文件
add_executable(${PROJECT_NAME} ${ALL_LIBRIRY_SRCS})
