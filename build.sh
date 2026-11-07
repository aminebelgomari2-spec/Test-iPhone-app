#!/bin/bash
# Compile MonApp pour iPhone (arm64, iOS 12+) et fabrique MonApp.ipa pseudo-signé.
# Usage : double-clic impossible, ouvre le Terminal :  cd dossier/MonApp && ./build.sh
set -e
cd "$(dirname "$0")"

if ! command -v xcrun >/dev/null; then
  echo "Xcode (ou ses Command Line Tools) est requis : xcode-select --install"; exit 1
fi
if ! command -v ldid >/dev/null; then
  echo "ldid manquant : installe-le avec  brew install ldid"; exit 1
fi

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

echo "-> Écran de lancement..."
xcrun ibtool --compile "$APP/LaunchScreen.storyboardc" LaunchScreen.storyboard

echo "-> Pseudo-signature (ldid)..."
ldid -S "$APP/MonApp"

echo "-> Création de l'IPA..."
(cd build && zip -qr MonApp.ipa Payload)

echo
echo "Terminé : $(pwd)/build/MonApp.ipa"
echo "Envoie-le sur l'iPhone (AirDrop, Filza, SSH), ouvre-le dans Filza puis Installer."
