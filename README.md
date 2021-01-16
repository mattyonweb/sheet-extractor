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

	./sheet-extractor.sh https://youtu.be/cUkHdt2im6M
	
This will:

+ Download the video (using youtubedl)
+ Extract a number of frames from the video (using ffmpeg)
+ Discard similar frames (using findimagedupes)
+ Merge the remaining frames in a single pdf (using imagemagick)

The resulting file will be the following: TODO

It may happen that some the resulting PDF has duplicate pages. In that case, I would advise you to modify the accuracy of `findimagedupes` like this:

	./sheet-extractor.sh 90% https://youtu.be/cUkHdt2im6M
    
98% accuracy means that two frames are considered the same only when they are 98% equal. The correct accuracy largely depends on the video downloaded; the default is set to 95%.

## Caveats

This AI is trained to work best when the video is made of still images only. It may still work when there is a moving line indicating the current position in the score, but only if the score doesn't scroll too. 

Do not use this to download copyrighted scores. Use this small script _ethically_.  
