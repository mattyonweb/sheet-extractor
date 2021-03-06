#!/bin/bash

set -eE

# Checks if needed dependencies are installed on the system.
MISSING_DEPENDENCIES=false

if ! command -v youtube-dl &> /dev/null
then
    echo "youtube-dl missing! Find it at https://github.com/ytdl-org/youtube-dl"
    MISSING_DEPENDENCIES=true
fi
if ! command -v convert &> /dev/null
then
    echo "imagemagick missing! Find it at https://github.com/ImageMagick/ImageMagick"
    MISSING_DEPENDENCIES=true
fi
if ! command -v ffmpeg &> /dev/null
then
    echo "ffmpeg missing! Find it at https://github.com/FFmpeg/FFmpeg"
    MISSING_DEPENDENCIES=true
fi
if ! command -v findimagedupes &> /dev/null
then
    echo "findimagedupes missing! Find it at https://github.com/opennota/findimagedupes"
    MISSING_DEPENDENCIES=true
fi

if [ $MISSING_DEPENDENCIES = true ]
then
    echo "Missing dependencies; abort!" > /dev/stderr
    exit 1
fi

###############################################################################
# Command Line arguments; if there is only one, then it is the link to the video;
# if there are two, one is the percentage of similarity needed to consider
# two frames the same picture.
if [ "$#" -e 1 ]; then
    ACCURACY="95%"
    LINK="$1$"
else
    ACCURACY="$1$"
    LINK="$2$"
fi



# Let's first set up some useful variables
ROOTDIR=$(mktemp -d)        # The (temp) directory we will work in
VIDEOFILE=$ROOTDIR/out      # The path to the downloaded video
FRAMESDIR=$ROOTDIR/frames   # The dir containing the video's frames

# This traps possible errors and performs a cleanup of the temporary directory
trap "rm -rf $ROOTDIR" ERR 

# First, download the video
youtube-dl --output "$VIDEOFILE" "$1"

# We don't know beforehand the extension of the downloaded video
# file, so we perform this hack:
VIDEOFILE="$ROOTDIR/"$(ls "$ROOTDIR")

# Extract a good amount of video frames
mkdir "$FRAMESDIR"
ffmpeg -i "$VIDEOFILE" -vf fps=0.30 "$FRAMESDIR"/thumb%04d.jpg -hide_banner
rm "$VIDEOFILE"

# Find which frames are duplicates and discard them; then, put the names of the
# remaining frames in a file
findimagedupes -t 95% "$FRAMESDIR" | awk '{print $1}' | sort > "$ROOTDIR"/.list-out

# Collect all the frames into a single .pdf
convert @"$ROOTDIR"/.list-out out.pdf

# Cleanup
rm -rf "$ROOTDIR"

