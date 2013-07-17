#!/bin/sh
set -e

xctool -workspace src/PlatformLib.xcworkspace -scheme PlatformLib build test
