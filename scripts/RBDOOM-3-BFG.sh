#!/bin/bash
cd ~/Projects/RBDOOM-3-BFG

git fetch origin
git checkout master
git reset --hard origin/master 
git clean -xdf 
git pull

git submodule init
git submodule update --recursive

cd neo
./cmake-linux-retail.sh

cd ../build
make


mkdir -p AppDir/usr/bin
mv RBDoom3BFG AppDir/usr/bin
cp -R ../base AppDir/usr/bin

mkdir -p AppDir/usr/share/icons/hicolor/256x256/apps
icns2png -x ../neo/sys/posix/res/Doom3BFG.icns -o AppDir/usr/share/icons/hicolor/256x256/apps/

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

cat > AppDir/AppRun <<\EOF
#!/bin/bash
cd ${0%/*}/usr/bin
./RBDoom3BFG
EOF


rm -Rf ~/Desktop/RBDOOM-3-BFG-x86_64.AppImage
env OUTPUT=~/Desktop/RBDOOM-3-BFG-x86_64.AppImage ~/linuxdeploy-x86_64.AppImage --appdir AppDir --plugin checkrt --output appimage
