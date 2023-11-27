#!/bin/sh
cd ~/Desktop/openbor/
rm -R engine/releases
git pull

cd engine
sed -e "s|-Werror||g" -i Makefile
./build.sh 4 amd64

mkdir -p releases/AppDir/usr/bin
mkdir -p releases/AppDir/usr/share/applications
mkdir -p releases/AppDir/usr/share/icons/hicolor/512x512
cp releases/LINUX_AMD64/OpenBOR/OpenBOR releases/AppDir/usr/bin
curl -o releases/AppDir/usr/share/icons/hicolor/512x512/openbor.png https://images.igdb.com/igdb/image/upload/t_cover_big/ge42.png 

cat > releases/AppDir/usr/share/applications/openBOR.desktop <<\EOF
[Desktop Entry]
Version=1.0
Name=OpenBOR
Exec=OpenBOR
Terminal=false
Icon=openbor
Type=Application
Categories=Game;
X-AppImage-Integrate=false
EOF


cat > releases/AppDir/AppRun <<\EOF
#!/bin/bash
mkdir -p $HOME/.local/share/OpenBOR
cd $HOME/.local/share/OpenBOR
${0%/*}/usr/bin/OpenBOR
EOF


env OUTPUT=~/Desktop/OpenBOR-x86_64.AppImage ~/linuxdeploy-x86_64.AppImage --appdir releases/AppDir/ --output appimage
