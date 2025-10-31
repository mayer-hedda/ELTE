cmake_minimum_required(VERSION 4.0)
project(ELTE C)

set(CMAKE_C_STANDARD 11)

add_executable(ELTE
        ImProg/Beadandó/KisBead1/kisBead1.c
        ImProg/Beadandó/KisBead2/kisBead2.c
        ImProg/Gyak/2025-09-15_gyak.c
        ImProg/Gyak/2025-09-22_gyak.c
        ImProg/Gyak/2025-09-29_gyak.c
        ImProg/Gyak/2025-10-06_gyak.c
        ImProg/Gyak/2025-10-13_gyak.c
        ImProg/Gyak/2025-10-20_gyak.c
        ImProg/röpZH/2025-09-15_zh.c
        ImProg/röpZH/2025-09-29_zh.c
        ImProg/röpZH/2025-10-06_zh.c)
