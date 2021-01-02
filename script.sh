#!/bin/bash

set -e

mkdir .out

youtube-dl --output ".out/out" $1 
VIDEOFILE=$(ls .out)

ffmpeg -i .out/$VIDEOFILE -vf fps=0.30 .out/thumb%04d.jpg -hide_banner

rm .out/$VIDEOFILE

findimagedupes -t 95% .out/ | awk '{print $1}' | sort > .out/.list-out

convert @.out/.list-out out.pdf

rm -rf .out/
