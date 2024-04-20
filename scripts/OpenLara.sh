cd src/platform/nix
./build.sh

cd ../../../bin/
mkdir -p AppDir/usr/share/applications/
mkdir -p AppDir/usr/share/icons/hicolor/256x256/apps/
cp ../src/platform/3ds/icon.png AppDir/usr/share/icons/hicolor/256x256/apps/OpenLara.png

cat > AppDir/usr/share/applications/OpenLara.desktop <<\EOF
[Desktop Entry]
Version=1.0
Name=Tomb Raider
Exec=OpenLara
Terminal=false
Icon=OpenLara
Type=Application
Categories=Game;
X-AppImage-Integrate=false
EOF

cat > AppDir/AppRun <<\EOF
#!/bin/bash
mkdir -p $HOME/.local/share/OpenLara/
cd $HOME/.local/share/OpenLara
${0%/*}/usr/bin/OpenLara
EOF


env OUTPUT=~/Desktop/OpenLara-x86_64.AppImage ~/linuxdeploy-x86_64.AppImage --appdir AppDir --executable OpenLara --output appimage
