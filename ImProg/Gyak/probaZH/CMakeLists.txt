cmake_minimum_required(VERSION 4.0)
project(probaZH C)

set(CMAKE_C_STANDARD 11)

add_executable(probaZH main.c
        buszmegallok.h
        buszmegallok.c)
