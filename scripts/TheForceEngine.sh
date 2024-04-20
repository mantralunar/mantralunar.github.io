mkdir tfe-build
cd tfe-build

cmake -S .. -DDISABLE_SYSMIDI=ON -DCMAKE_INSTALL_PREFIX=/usr
make -j$(nproc)
make install DESTDIR=AppDir

mv AppDir/usr/share/TheForceEngine/* AppDir/usr/bin/
rmdir AppDir/usr/share/TheForceEngine

cat > AppDir/AppRun <<\EOF
#!/bin/bash
cd ${0%/*}/usr/bin/
./theforceengine
EOF

 ~/linuxdeploy-x86_64.AppImage --appdir AppDir --plugin checkrt --output appimage
