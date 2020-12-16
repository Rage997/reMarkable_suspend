#!/bin/bash

# Changes the sleep screen of remarkable given an image
# it requires to install imagick - https://imagemagick.org/
# on Linux: apt install imagick
# on Mac: brew install imagick

image=$1

echo 'Resizing image for Remarkable (1827x1404 with 226 DPI) and saving it to: '$PWD/suspended.png  
# TODO convert it to grayscale (add -grayscale flag)
convert $image -resize 1404x1872! -density 226 $PWD/suspended.png

# echo 'Press write the Remarkable ip'
# read rm_ip
rm_ip=192.168.1.186
echo 'Connecting to reMarkable throuhg ssh and storing it'
scp $PWD/suspended.png root@$rm_ip:/usr/share/remarkable

# echo $res
echo 'Done! Enjoy your sleep screen!'
