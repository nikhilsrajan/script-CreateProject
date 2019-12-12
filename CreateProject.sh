#!/bin/sh

ScriptName=$0
ProjectName=$1
Usage="Usage: ${ScriptName} ProjectName" 

if [ $# -eq 0 ]; then
    echo "Project Name not specified."
    echo ${Usage}
    exit 0
fi

if [ $# -gt 1 ]; then
    echo "Too many arguments"
    echo ${Usage}
    exit 0
fi

git clone https://github.com/nikhilsrajan/Sample.git ${ProjectName}
cd ${ProjectName}
rm -rf .git
sed -i -e 's/<Project>/'"${ProjectName}"'/g' CMakeLists.txt
mkdir build
cd build
mkdir release debug
cd release
cmake ../.. -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
make -j4
./${ProjectName}Test
