#!/bin/bash -e
# Run in exercise directory by exutil

exercise="$(basename $(pwd))"
filename="${exercise//-/_}.rb"
echo "Creating $filename..."
touch "$filename"