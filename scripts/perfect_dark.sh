cd ~/Projects/perfect_dark
rm -Rf build
git pull

make -f Makefile.port TARGET_PLATFORM=i686-linux

mkdir -p build/AppDir/usr/bin/
mkdir -p build/AppDir/usr/share/applications
mkdir -p build/AppDir/usr/share/icons/hicolor/512x512/apps
cp build/ntsc-final-port/pd.exe build/AppDir/usr/bin/pd
curl https://raw.githubusercontent.com/mantralunar/mantralunar.github.io/main/img/pd.png -o build/AppDir/usr/share/icons/hicolor/512x512/apps/pd.png


cat > build/AppDir/usr/share/applications/pd.desktop <<\EOF
[Desktop Entry]
Version=1.0
Name=Perfect Dark
Exec=pd
Terminal=false
Icon=pd
Type=Application
Categories=Game;
X-AppImage-Integrate=false
EOF

rm ~/Desktop/perfect_dark-x86_64.AppImage
env ARCH=x86_64 ~/linuxdeploy-x86_64.AppImage --appdir build/AppDir/ --plugin checkrt32 --output appimage
