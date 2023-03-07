# Godot Dev Container

## About
This is a Docker image to quickly build the Godot Engine editor for Linux with Debug symbols using Clang, Mold and Pyston.

It's uses the tips mentioned in the [documentation](https://docs.godotengine.org/en/stable/contributing/development/compiling/compiling_for_linuxbsd.html) to make the build as fast as possible, and make it less painful for the developer to test her changes.

It's useful for developers who work on the engine codes itself, or those who will be using GDExtensions.

## Run it
TLDR; From your Godot source code directory, run the following command to trigger a build
```bash
docker run -it --rm -v $PWD:/godot hakrou/godot-dev gdbuild
```

To build Godot from source, you can use the following steps:

```bash
# Clone Godot (or your own fork)
git clone https://github.com/godotengine/godot
cd godot

# Run the build
docker run -it --rm -v $PWD:/godot hakrou/godot-dev gdbuild

# You can make it shorter by setting an alias (you can add this to your .profile)
alias gdbuild="docker run -it --rm -v $PWD:/godot hakrou/godot-dev gdbuild"

# Then you just need to run this command from inside your Godot directory
gdbuild

# Add the -d option if you want to generate the compile_commands.json file
gdbuild -d

# You can also run the build and automatically start Godot if the build is successful
gdbuild && /bin/godot.linuxbsd.editor.dev.x86_64.llvm

# If you want to skip the Project Manager and directly open a specific project
# (don't forget to change the --path value to a valid Godot Project directory)
gdbuild && /bin/godot.linuxbsd.editor.dev.x86_64.llvm --editor --path /home/hakim/Projects/godot4-test/
```

## Possible next steps
If there is popular demand, we can add the following :
- [x] Deploy a prebuilt image on Dockerhub so you don't have to build it yourself
- [ ] Add a full C++ IDE inside the container using (Neo)Vim and additional modules (LSP, Clangd ...)
- [ ] Make the build script more configurable, by choosing what linker or compiler to use
