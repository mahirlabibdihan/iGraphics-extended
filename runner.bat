@echo off
setlocal

:: Check for source file argument
if "%~1"=="" (
    echo Usage: %0 source_file
    exit /b 1
)

:: Set the Base Directory
set BASE_DIR=D:\MINGW\bin
:: Set the PATH
set PATH=%BASE_DIR%;%BASE_DIR%\bin;%PATH%

:: Compile the source file to an object file (with irrKlang include path)
g++.exe -Wall -fexceptions -g -IOpenGL\include -IOpenGL\include\irrKlang -c "%~1" -o exec\object.o
if %ERRORLEVEL% neq 0 (
    echo Compilation failed.
    exit /b 1
)

:: Link the object file to create the executable (with irrKlang lib)
g++.exe -static -static-libgcc -static-libstdc++ -L.\OpenGL\lib -o exec\opengl.exe exec\object.o OpenGL\lib\GLU32.LIB  OpenGL\lib\OPENGL32.LIB -lGLU32 -lfreeglut -lOPENGL32 -lgdi32 -lwinmm -lirrKlang
if %ERRORLEVEL% neq 0 (
    echo Linking failed.
    exit /b 1
)

echo Finished building.

exec\opengl.exe
endlocal
