#!/bin/bash
cd ~/Desktop/RBDOOM-3-BFG

rm -Rf ~/Desktop/RBDOOM-3-BFG/build


git fetch origin
git checkout master
git reset --hard origin/master 
git clean -xdf 


git submodule init
git submodule update --recursive

cd neo
./cmake-linux-release.sh

cd ../build
make


mkdir -p AppDir/usr/bin
mv RBDoom3BFG AppDir/usr/bin
cp -R ../base AppDir/usr/bin

mkdir -p AppDir/usr/share/icons/hicolor/scalable
icns2png -x ../neo/sys/posix/res/Doom3BFG.icns -o AppDir/usr/share/icons/hicolor/scalable/

mkdir -p AppDir/usr/share/applications
cat > AppDir/usr/share/applications/DOOM-3-BFG.desktop <<\EOF
[Desktop Entry]
Version=1.0
Icon=Doom3BFG_256x256x32
Exec=RBDoom3BFG
Terminal=false
Type=Application
Categories=Game
Name=DOOM 3 BFG
GenericName=DOOM 3 BFG
Comment=DOOM 3 BFG
EOF


env OUTPUT=~/Desktop/RBDOOM_3_BFG-x86_64.AppImage ~/linuxdeploy-x86_64.AppImage --appdir AppDir --output appimage
