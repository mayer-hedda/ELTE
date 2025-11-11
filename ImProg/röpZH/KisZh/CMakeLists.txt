cmake_minimum_required(VERSION 4.0)
project(KisZh C)

set(CMAKE_C_STANDARD 11)

add_executable(KisZh main.c
        Friend.h
        friend.c)
