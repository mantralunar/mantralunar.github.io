cd ~/Projects/HL2/
rm -Rf ~/Projects/AppDir/*
 

cd hlsdk-portable

git fetch origin
git checkout master
git reset --hard origin/master
git clean -xdf

cmake -DCMAKE_BUILD_TYPE=Release -D64BIT=1 -B build -S .
cmake --build build

cd ..

cd xash3d-fwgs
git fetch origin
git checkout master
git reset --hard origin/master
git clean -xdf


./waf configure -T release -8
./waf build
./waf install --destdir=../AppDir/usr/bin

cd ..
mkdir -p AppDir/usr/bin/valve/cl_dlls/
cp hlsdk-portable/build/cl_dll/client_amd64.so AppDir/usr/bin/valve/cl_dlls/client_amd64.so
mkdir -p AppDir/usr/bin/valve/dlls/
cp hlsdk-portable/build/dlls/hl_amd64.so AppDir/usr/bin/valve/dlls/hl_amd64.so


mkdir -p AppDir/usr/share/applications
mkdir -p AppDir/usr/share/icons/hicolor/128x128/apps/

cp xash3d-fwgs/engine/platform/psvita/sce_sys/icon0.png AppDir/usr/share/icons/hicolor/128x128/apps/
mkdir -p AppDir/usr/lib/
mv AppDir/usr/bin/*.so AppDir/usr/lib/


cat > AppDir/usr/share/applications/xash3d.desktop <<EOF
[Desktop Entry]
Version=1.0
Icon=icon0
Exec=xash3d
Terminal=false
Type=Application
Categories=Game
Name=Half-Life
GenericName=Half-Life
Comment=Half-Life
EOF

cat > AppDir/AppRun <<\EOF
#!/bin/sh
mkdir -p $HOME/.local/share/xash3d/valve/cl_dlls
mkdir -p $HOME/.local/share/xash3d/valve/dlls
ln -sf ${0%/*}/usr/bin/valve/cl_dlls/client_amd64.so $HOME/.local/share/xash3d/valve/cl_dlls
ln -sf ${0%/*}/usr/bin/valve/dlls/hl_amd64.so $HOME/.local/share/xash3d/valve/dlls
ln -sf ${0%/*}/usr/bin/valve/extras.pk3 $HOME/.local/share/xash3d/valve/
export XASH3D_BASEDIR=$HOME/.local/share/xash3d/
${0%/*}/usr/bin/xash3d
EOF

rm ~/Desktop/xash3d-fwgs-x86_64.AppImage
env OUTPUT=~/Desktop/xash3d-fwgs-x86_64.AppImage ~/linuxdeploy-x86_64.AppImage --appdir AppDir --output appimage
