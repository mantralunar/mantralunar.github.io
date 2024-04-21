#!/bin/bash
make -C ./src XDGUSERPATH=1

###Prepare AppImage Directory
mkdir -p AppDir/usr/bin
mkdir -p AppDir/usr/share/applications
mkdir -p AppDir/usr/share/icons/hicolor/64x64

cp bin/* AppDir/usr/bin/

cat > AppDir/usr/share/applications/omnispeak.desktop <<EOF
[Desktop Entry]
Version=1.0
Icon=unixicon
Exec=omnispeak
Terminal=false
Type=Application
Categories=Game;Emulator;
Name=Omnispeak
GenericName=Omnispeak
Comment=Omnispeak
EOF


cat > AppDir/AppRun <<\EOF
#!/bin/bash
cd ${0%/*}/usr/bin
./omnispeak /GAMEPATH $HOME/.local/share/"Commander Keen"/data/ $1 $2
EOF

linuxdeploy-x86_64.AppImage --appdir AppDir --icon-file unixicon.png --output appimage
