# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.22

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/julia/CG/abcg3

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/julia/CG/abcg3/build

# Include any dependencies generated for this target.
include examples/pikachu/CMakeFiles/pikachu.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include examples/pikachu/CMakeFiles/pikachu.dir/compiler_depend.make

# Include the progress variables for this target.
include examples/pikachu/CMakeFiles/pikachu.dir/progress.make

# Include the compile flags for this target's objects.
include examples/pikachu/CMakeFiles/pikachu.dir/flags.make

examples/pikachu/CMakeFiles/pikachu.dir/main.cpp.o: examples/pikachu/CMakeFiles/pikachu.dir/flags.make
examples/pikachu/CMakeFiles/pikachu.dir/main.cpp.o: ../examples/pikachu/main.cpp
examples/pikachu/CMakeFiles/pikachu.dir/main.cpp.o: examples/pikachu/CMakeFiles/pikachu.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/julia/CG/abcg3/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object examples/pikachu/CMakeFiles/pikachu.dir/main.cpp.o"
	cd /home/julia/CG/abcg3/build/examples/pikachu && /usr/bin/ccache /usr/lib/ccache/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT examples/pikachu/CMakeFiles/pikachu.dir/main.cpp.o -MF CMakeFiles/pikachu.dir/main.cpp.o.d -o CMakeFiles/pikachu.dir/main.cpp.o -c /home/julia/CG/abcg3/examples/pikachu/main.cpp

examples/pikachu/CMakeFiles/pikachu.dir/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/pikachu.dir/main.cpp.i"
	cd /home/julia/CG/abcg3/build/examples/pikachu && /usr/lib/ccache/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/julia/CG/abcg3/examples/pikachu/main.cpp > CMakeFiles/pikachu.dir/main.cpp.i

examples/pikachu/CMakeFiles/pikachu.dir/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/pikachu.dir/main.cpp.s"
	cd /home/julia/CG/abcg3/build/examples/pikachu && /usr/lib/ccache/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/julia/CG/abcg3/examples/pikachu/main.cpp -o CMakeFiles/pikachu.dir/main.cpp.s

examples/pikachu/CMakeFiles/pikachu.dir/model.cpp.o: examples/pikachu/CMakeFiles/pikachu.dir/flags.make
examples/pikachu/CMakeFiles/pikachu.dir/model.cpp.o: ../examples/pikachu/model.cpp
examples/pikachu/CMakeFiles/pikachu.dir/model.cpp.o: examples/pikachu/CMakeFiles/pikachu.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/julia/CG/abcg3/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object examples/pikachu/CMakeFiles/pikachu.dir/model.cpp.o"
	cd /home/julia/CG/abcg3/build/examples/pikachu && /usr/bin/ccache /usr/lib/ccache/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT examples/pikachu/CMakeFiles/pikachu.dir/model.cpp.o -MF CMakeFiles/pikachu.dir/model.cpp.o.d -o CMakeFiles/pikachu.dir/model.cpp.o -c /home/julia/CG/abcg3/examples/pikachu/model.cpp

examples/pikachu/CMakeFiles/pikachu.dir/model.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/pikachu.dir/model.cpp.i"
	cd /home/julia/CG/abcg3/build/examples/pikachu && /usr/lib/ccache/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/julia/CG/abcg3/examples/pikachu/model.cpp > CMakeFiles/pikachu.dir/model.cpp.i

examples/pikachu/CMakeFiles/pikachu.dir/model.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/pikachu.dir/model.cpp.s"
	cd /home/julia/CG/abcg3/build/examples/pikachu && /usr/lib/ccache/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/julia/CG/abcg3/examples/pikachu/model.cpp -o CMakeFiles/pikachu.dir/model.cpp.s

examples/pikachu/CMakeFiles/pikachu.dir/window.cpp.o: examples/pikachu/CMakeFiles/pikachu.dir/flags.make
examples/pikachu/CMakeFiles/pikachu.dir/window.cpp.o: ../examples/pikachu/window.cpp
examples/pikachu/CMakeFiles/pikachu.dir/window.cpp.o: examples/pikachu/CMakeFiles/pikachu.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/julia/CG/abcg3/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object examples/pikachu/CMakeFiles/pikachu.dir/window.cpp.o"
	cd /home/julia/CG/abcg3/build/examples/pikachu && /usr/bin/ccache /usr/lib/ccache/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT examples/pikachu/CMakeFiles/pikachu.dir/window.cpp.o -MF CMakeFiles/pikachu.dir/window.cpp.o.d -o CMakeFiles/pikachu.dir/window.cpp.o -c /home/julia/CG/abcg3/examples/pikachu/window.cpp

examples/pikachu/CMakeFiles/pikachu.dir/window.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/pikachu.dir/window.cpp.i"
	cd /home/julia/CG/abcg3/build/examples/pikachu && /usr/lib/ccache/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/julia/CG/abcg3/examples/pikachu/window.cpp > CMakeFiles/pikachu.dir/window.cpp.i

examples/pikachu/CMakeFiles/pikachu.dir/window.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/pikachu.dir/window.cpp.s"
	cd /home/julia/CG/abcg3/build/examples/pikachu && /usr/lib/ccache/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/julia/CG/abcg3/examples/pikachu/window.cpp -o CMakeFiles/pikachu.dir/window.cpp.s

examples/pikachu/CMakeFiles/pikachu.dir/trackball.cpp.o: examples/pikachu/CMakeFiles/pikachu.dir/flags.make
examples/pikachu/CMakeFiles/pikachu.dir/trackball.cpp.o: ../examples/pikachu/trackball.cpp
examples/pikachu/CMakeFiles/pikachu.dir/trackball.cpp.o: examples/pikachu/CMakeFiles/pikachu.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/julia/CG/abcg3/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building CXX object examples/pikachu/CMakeFiles/pikachu.dir/trackball.cpp.o"
	cd /home/julia/CG/abcg3/build/examples/pikachu && /usr/bin/ccache /usr/lib/ccache/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT examples/pikachu/CMakeFiles/pikachu.dir/trackball.cpp.o -MF CMakeFiles/pikachu.dir/trackball.cpp.o.d -o CMakeFiles/pikachu.dir/trackball.cpp.o -c /home/julia/CG/abcg3/examples/pikachu/trackball.cpp

examples/pikachu/CMakeFiles/pikachu.dir/trackball.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/pikachu.dir/trackball.cpp.i"
	cd /home/julia/CG/abcg3/build/examples/pikachu && /usr/lib/ccache/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/julia/CG/abcg3/examples/pikachu/trackball.cpp > CMakeFiles/pikachu.dir/trackball.cpp.i

examples/pikachu/CMakeFiles/pikachu.dir/trackball.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/pikachu.dir/trackball.cpp.s"
	cd /home/julia/CG/abcg3/build/examples/pikachu && /usr/lib/ccache/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/julia/CG/abcg3/examples/pikachu/trackball.cpp -o CMakeFiles/pikachu.dir/trackball.cpp.s

# Object files for target pikachu
pikachu_OBJECTS = \
"CMakeFiles/pikachu.dir/main.cpp.o" \
"CMakeFiles/pikachu.dir/model.cpp.o" \
"CMakeFiles/pikachu.dir/window.cpp.o" \
"CMakeFiles/pikachu.dir/trackball.cpp.o"

# External object files for target pikachu
pikachu_EXTERNAL_OBJECTS =

bin/pikachu: examples/pikachu/CMakeFiles/pikachu.dir/main.cpp.o
bin/pikachu: examples/pikachu/CMakeFiles/pikachu.dir/model.cpp.o
bin/pikachu: examples/pikachu/CMakeFiles/pikachu.dir/window.cpp.o
bin/pikachu: examples/pikachu/CMakeFiles/pikachu.dir/trackball.cpp.o
bin/pikachu: examples/pikachu/CMakeFiles/pikachu.dir/build.make
bin/pikachu: abcg/libabcg.a
bin/pikachu: /usr/lib/x86_64-linux-gnu/libGLX.so
bin/pikachu: /usr/lib/x86_64-linux-gnu/libOpenGL.so
bin/pikachu: /usr/lib/x86_64-linux-gnu/libGLEW.so
bin/pikachu: abcg/external/fmt/libfmt.a
bin/pikachu: abcg/external/imgui/libimgui.a
bin/pikachu: /usr/lib/x86_64-linux-gnu/libSDL2main.a
bin/pikachu: /usr/lib/x86_64-linux-gnu/libSDL2.so
bin/pikachu: /usr/lib/x86_64-linux-gnu/libSDL2_image.so
bin/pikachu: examples/pikachu/CMakeFiles/pikachu.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/julia/CG/abcg3/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Linking CXX executable ../../bin/pikachu"
	cd /home/julia/CG/abcg3/build/examples/pikachu && /usr/bin/cmake -E remove_directory /home/julia/CG/abcg3/build/bin/pikachu
	cd /home/julia/CG/abcg3/build/examples/pikachu && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/pikachu.dir/link.txt --verbose=$(VERBOSE)
	cd /home/julia/CG/abcg3/build/examples/pikachu && /usr/bin/cmake -E make_directory /home/julia/CG/abcg3/build/bin/pikachu.dir
	cd /home/julia/CG/abcg3/build/examples/pikachu && /usr/bin/cmake -E copy_directory /home/julia/CG/abcg3/examples/pikachu/assets /home/julia/CG/abcg3/build/bin/pikachu.dir/assets
	cd /home/julia/CG/abcg3/build/examples/pikachu && /usr/bin/cmake -E copy /home/julia/CG/abcg3/build/bin/pikachu /home/julia/CG/abcg3/build/bin/pikachu.dir/pikachu
	cd /home/julia/CG/abcg3/build/examples/pikachu && /usr/bin/cmake -E remove /home/julia/CG/abcg3/build/bin/pikachu
	cd /home/julia/CG/abcg3/build/examples/pikachu && /usr/bin/cmake -E rename /home/julia/CG/abcg3/build/bin/pikachu.dir /home/julia/CG/abcg3/build/bin/pikachu
	cd /home/julia/CG/abcg3/build/examples/pikachu && /usr/bin/cmake -E rm -rf /home/julia/CG/abcg3/build/bin/pikachu.dir

# Rule to build all files generated by this target.
examples/pikachu/CMakeFiles/pikachu.dir/build: bin/pikachu
.PHONY : examples/pikachu/CMakeFiles/pikachu.dir/build

examples/pikachu/CMakeFiles/pikachu.dir/clean:
	cd /home/julia/CG/abcg3/build/examples/pikachu && $(CMAKE_COMMAND) -P CMakeFiles/pikachu.dir/cmake_clean.cmake
.PHONY : examples/pikachu/CMakeFiles/pikachu.dir/clean

examples/pikachu/CMakeFiles/pikachu.dir/depend:
	cd /home/julia/CG/abcg3/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/julia/CG/abcg3 /home/julia/CG/abcg3/examples/pikachu /home/julia/CG/abcg3/build /home/julia/CG/abcg3/build/examples/pikachu /home/julia/CG/abcg3/build/examples/pikachu/CMakeFiles/pikachu.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : examples/pikachu/CMakeFiles/pikachu.dir/depend

