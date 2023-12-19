cd ~/Desktop/perfect_dark
rm -Rf build
git pull

make -f Makefile.port TARGET_PLATFORM=i686-linux

mkdir -p ~/Desktop/perfect_dark/build/AppDir/usr/bin/
mkdir -p ~/Desktop/perfect_dark/build/AppDir/usr/share/applications
mkdir -p ~/Desktop/perfect_dark/build/AppDir/usr/share/icons/hicolor/512x512
cp ~/Desktop/perfect_dark/build/ntsc-final-port/pd.exe ~/Desktop/perfect_dark/build/AppDir/usr/bin/pd
curl https://raw.githubusercontent.com/mantralunar/mantralunar.github.io/main/img/pd.png -o ~/Desktop/perfect_dark/build/AppDir/usr/share/icons/hicolor/512x512/pd.png


cat > ~/Desktop/perfect_dark/build/AppDir/usr/share/applications/pd.desktop <<\EOF
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


env OUTPUT=~/Desktop/pd-x86_64.AppImage ~/linuxdeploy-x86_64.AppImage --appdir ~/Desktop/perfect_dark/build/AppDir/ --output appimage
