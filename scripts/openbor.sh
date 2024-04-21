#!/bin/sh

cd engine
sed -e "s|-Werror||g" -i Makefile
./build.sh 4 amd64

mkdir -p releases/AppDir/usr/bin
mkdir -p releases/AppDir/usr/share/applications
cp releases/LINUX_AMD64/OpenBOR/OpenBOR releases/AppDir/usr/bin

#cat > releases/AppDir/usr/share/applications/OpenBOR.desktop <<\EOF
cat > releases/AppDir/OpenBOR.desktop <<\EOF
[Desktop Entry]
Version=1.0
Name=OpenBOR
Exec=OpenBOR
Terminal=false
Icon=OpenBOR_Icon_128x128
Type=Application
Categories=Game;
X-AppImage-Integrate=false
EOF

cp resources/OpenBOR_Icon_128x128.png releases/AppDir/

cat > releases/AppDir/AppRun <<\EOF
#!/bin/bash
mkdir -p $HOME/.local/share/OpenBOR
rm -rf $HOME/.local/share/OpenBOR/Logs/*
rm -rf $HOME/.local/share/OpenBOR/Musics/*
rm -rf $HOME/.local/share/OpenBOR/Screenshots/*
rm -rf $HOME/.local/share/OpenBOR/Translation/*

cd $HOME/.local/share/OpenBOR
${0%/*}/usr/bin/OpenBOR
EOF

appimagetool-x86_64.AppImage releases/AppDir/ ~/Desktop/openbor-x86_64.AppImage
#linuxdeploy-x86_64.AppImage --appdir releases/AppDir/ --icon-file resources/OpenBOR_Icon_128x128.png --output appimage
