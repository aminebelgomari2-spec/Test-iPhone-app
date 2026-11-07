#!/bin/bash
set -e
cd "$(dirname "$0")"

rm -rf build && mkdir -p build/Payload/MonApp.app
APP=build/Payload/MonApp.app

echo "-> Compilation..."
xcrun -sdk iphoneos swiftc \
  -target arm64-apple-ios12.2 \
  -swift-version 5 \
  -O \
  Sources/*.swift \
  -o "$APP/MonApp"

cp Info.plist "$APP/Info.plist"
xcrun ibtool --compile "$APP/LaunchScreen.storyboardc" LaunchScreen.storyboard

echo "-> Signature..."
codesign --remove-signature "$APP/MonApp" 2>/dev/null || true
ldid -Sents.plist "$APP/MonApp"

echo "-> Verification..."
ldid -e "$APP/MonApp"
otool -l "$APP/MonApp" | grep -q LC_CODE_SIGNATURE || { echo "ERREUR : pas de signature"; exit 1; }

echo "-> Creation de l'IPA..."
(cd build && zip -qry MonApp.ipa Payload)
echo "Termine"
