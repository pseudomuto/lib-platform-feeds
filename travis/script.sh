#!/bin/sh
set -e

xctool -workspace src/PlatformLib -scheme PlatformLib build test
