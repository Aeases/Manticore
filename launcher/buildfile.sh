#!/bin/bash
repo_root=$(git rev-parse --show-toplevel)
build_dir="$repo_root/builds"
modrinthpack="$repo_root/Manticore*.mrpack"
indextoml="$repo_root/index.toml"

if [ ! -d "$indextoml" ]; then
    # If the directory doesn't exist, create it
    touch "$indextoml"
fi

if [ ! -d "$build_dir" ]; then
    # If the directory doesn't exist, create it
    mkdir "$build_dir"
fi

( cd $repo_root && packwiz modrinth export ) || (packwiz modrinth export ) || {
    # If the build command fails, show a Zenity error dialog
    zenity --error --text="Build failed! Try deleting the 'index.toml' file"
    echo "Build failed! Try deleting the 'index.toml' file"
    echo "${PWD}"
    exit 1
}



mv $modrinthpack $build_dir