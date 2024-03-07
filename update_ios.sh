#!/bin/bash

set -x


# Go to the ios/ folder
cd ios

# # Update CocoaPods
# sudo gem update cocoapods

# If the above doesn't work, try installing it through Homebrew
brew install cocoapods

# Make sure CocoaPods updated to 1.13.0 or newer version (if available)
pod --version

# Delete the build cache
flutter clean

# Delete the Podfile.lock file
rm Podfile.lock

# Delete the Pods/ folder as well
rm -rf Pods/

# Install the Flutter package dependencies
flutter pub get

# Install the iOS pod dependencies
pod install

# Update your local pods
pod update
