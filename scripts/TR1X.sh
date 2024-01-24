
cd ~/Projects/TR1X/

rm -Rf build

sudo docker run --rm \
  --user $UID:$GID \
  --entrypoint /app/docker/game-linux/entrypoint.sh \
  -e TARGET=release \
  -v $PWD:/app/ \
  rrdash/tr1x-linux:latest

mkdir -p build/AppDir/usr/bin
mkdir -p build/AppDir/usr/share/applications
mkdir -p build/AppDir/usr/share/icons/hicolor/256x256/apps
convert "tools/resources/icon.psd[0]" build/AppDir/usr/share/icons/hicolor/256x256/apps/icon.png

cp build/linux/TR1X build/AppDir/usr/bin
cp -R bin/* build/AppDir/usr/bin

mkdir build/AppDir/usr/bin/fmv
mkdir build/AppDir/usr/bin/audio

ln -s /home/deck/.local/share/TR1X/data/* build/AppDir/usr/bin/data
ln -s /home/deck/.local/share/TR1X/fmv/* build/AppDir/usr/bin/fmv
ln -s /home/deck/.local/share/TR1X/music/* build/AppDir/usr/bin/music
ln -s /home/deck/.local/share/TR1X/saves/ build/AppDir/usr/bin/saves

cat > build/AppDir/usr/share/applications/TR1X.desktop <<\EOF
[Desktop Entry]
Version=1.0
Icon=icon
Exec=TR1X
Terminal=false
Type=Application
Categories=Game
Name=Tomb Raider
GenericName=Tomb Raider
Comment=Tomb Raider
EOF


cat > build/AppDir/AppRun <<\EOF
#!/bin/bash
mkdir -p $HOME/.local/share/TR1X/data
mkdir -p $HOME/.local/share/TR1X/fmv
mkdir -p $HOME/.local/share/TR1X/music
mkdir -p $HOME/.local/share/TR1X/saves
${0%/*}/usr/bin/TR1X
EOF


env OUTPUT=~/Desktop/TR1X-x86_64.AppImage ~/linuxdeploy-x86_64.AppImage --appdir build/AppDir/ --output appimage
