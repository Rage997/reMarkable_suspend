#!/bin/bash

# Changes the sleep screen of remarkable given an image
# it requires to install imagick - https://imagemagick.org/
# on Linux: apt install imagick
# on Mac: brew install imagick

# reMarkable usb ip, if reMarkable is not connect through usb write it
rm_ip=10.11.99.1

image=$1
if [ -z $image ]; then
        echo "No input image! Usage: ./changeRmScreen <input_image>"
        exit 0
fi

echo 'Resizing image for Remarkable (1827x1404 with 226 DPI)'
convert $image -resize 1404x1872! -density 226 -colorspace Gray -quiet $PWD/suspended.png
echo 'Done! Image saved in: '$PWD/suspended.png

# echo 'Press write the Remarkable ip'
# read rm_ip
echo 'Connecting to reMarkable through ssh and storing it'
scp $PWD/suspended.png root@$rm_ip:/usr/share/remarkable

if [ $? -eq 0 ]; then
    echo 'Done! Enjoy your sleep screen!'
else
    echo 'Something went wrong with ssh connection. Is the reMarkable on and awake?'
fi
