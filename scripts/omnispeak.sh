#!/bin/bash
cd ~/Desktop/omnispeak

rm -Rf ~/Desktop/omnispeak/obj
rm -Rf ~/Desktop/omnispeak/bin
rm -Rf ~/Desktop/omnispeak/AppDir


git fetch origin
git checkout master
git reset --hard origin/master 
git clean -xdf 

make -C ./src XDGUSERPATH=1

###Prepare AppImage Directory
cd ~/Desktop/omnispeak
rm -Rf AppDir
mkdir -p AppDir/usr/bin
mkdir -p AppDir/usr/share/applications
mkdir -p AppDir/usr/share/icons/hicolor/scalable
cp unixicon.png AppDir/usr/share/icons/hicolor/scalable/unixicon.png

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

env OUTPUT=~/Desktop/Omnispeak-x86_64.AppImage ~/linuxdeploy-x86_64.AppImage --appdir AppDir --output appimage