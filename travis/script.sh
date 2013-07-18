#!/bin/sh
set -e

cd src/
pod install
xctool build test
