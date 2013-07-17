#!/bin/sh
set -e

cd src/
pod install
xctool -workspace PlatformLib.xcworkspace -scheme PlatformLib build test
