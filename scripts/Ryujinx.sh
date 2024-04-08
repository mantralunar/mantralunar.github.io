cd ~/Projects/Ryujinx
rm -Rf AppDir
git pull

dotnet publish -c Release -r linux-x64 -o AppDir/usr/bin -p:DebugType=embedded -p:ExtraDefineConstants=DISABLE_UPDATER src/Ryujinx --self-contained true

cp distribution/linux/Ryujinx.desktop AppDir/
cp distribution/misc/Logo.svg AppDir/Ryujinx.svg

cat > AppDir/AppRun <<\EOF
#!/bin/sh

SCRIPT_DIR=$(dirname "$(realpath "$0")")/usr/bin/

if [ -f "$SCRIPT_DIR/Ryujinx.Headless.SDL2" ]; then
    RYUJINX_BIN="Ryujinx.Headless.SDL2"
fi

if [ -f "$SCRIPT_DIR/Ryujinx" ]; then
    RYUJINX_BIN="Ryujinx"
fi

if [ -z "$RYUJINX_BIN" ]; then
    exit 1
fi

COMMAND="env DOTNET_EnableAlternateStackCheck=1"

if command -v gamemoderun > /dev/null 2>&1; then
    COMMAND="$COMMAND gamemoderun"
fi

exec $COMMAND "$SCRIPT_DIR/$RYUJINX_BIN" "$@"
EOF

chmod +x AppDir/AppRun

ARCH=x86_64 ~/appimagetool-x86_64.AppImage AppDir ~/Desktop/Ryujinx-x86_64.AppImage
