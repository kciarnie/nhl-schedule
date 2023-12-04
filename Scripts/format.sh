#!/bin/sh

# Check to see if we have homebrew installed
if ! [ -x "$(command -v brew)" ]; then
  echo "Installing Homebrew..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Check to see if we have Swiftformat installed
if ! [ -x "$(command -v swiftformat)" ]; then
  echo "Installing SwiftFormat..."
  brew install swiftformat
fi

# The script is pretty simple. It installs Swiftgen and Swiftformat using Homebrew and then runs them. The script is called from the main script, so it’s not necessary to run it manually.
echo "Running SwiftFormat..."
swiftformat .