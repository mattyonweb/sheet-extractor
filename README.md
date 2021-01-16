# sheet-extractor.sh

An advanced recurrent neural network (RNN) to extract sheets from Youtube music videos. 

## Installation

To run this advanced Artificial Intelligence, you will need to install the following:

+ youtube-dl - https://github.com/ytdl-org/youtube-dl
+ imagemagick - https://github.com/ImageMagick/ImageMagick"
+ ffmpeg - https://github.com/FFmpeg/FFmpeg"
+ findimagedupes - https://github.com/opennota/findimagedupes"

Installing `sheet-extractor.sh` is as simple as cloning this repo on your local machine. 


## Usage example

	./sheet-extractor.sh https://youtu.be/K5-IqJZPxQY
	
This will:

+ Download the video (using youtubedl)
+ Extract a number of frames from the video (using ffmpeg)
+ Discard similar frames (using findimagedupes)
+ Merge the remaining frames in a single pdf (using imagemagick)

The resulting file will be the following: TODO
