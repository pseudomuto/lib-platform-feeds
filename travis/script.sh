#!/bin/sh
set -e

cd src/
pod install
xctool test -workspace PlatformLib.xcworkspace -scheme PlatformLib
