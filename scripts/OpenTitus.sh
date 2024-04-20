#!/bin/bash
zig build

mkdir -p bin/AppDir/usr/bin/
mkdir -p bin/AppDir/usr/share/applications/
mkdir -p bin/AppDir/usr/share/icons/hicolor/scalable/apps/
curl https://raw.githubusercontent.com/mantralunar/mantralunar.github.io/main/img/titus.png -o bin/AppDir/usr/share/icons/hicolor/scalable/apps/titus.png
cp bin/titus/opentitus bin/AppDir/usr/bin/
cp bin/titus/music.bin bin/AppDir/usr/bin/

cat > bin/AppDir/usr/share/applications/OpenTitus.desktop <<\EOF
[Desktop Entry]
Version=1.0
Name=Titus the Fox
Exec=opentitus
Terminal=false
Icon=titus
Type=Application
Categories=Game;
X-AppImage-Integrate=false
EOF

cat > bin/AppDir/AppRun <<\EOF
#!/bin/bash
mkdir -p $HOME/.local/share/OpenTitus/
ln -sf ${0%/*}/usr/bin/music.bin $HOME/.local/share/OpenTitus/
cd $HOME/.local/share/OpenTitus
${0%/*}/usr/bin/opentitus
EOF

env OUTPUT=~/Desktop/OpenTitus-x86_64.AppImage ~/linuxdeploy-x86_64.AppImage --appdir bin/AppDir --output appimage
