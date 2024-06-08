#!/bin/bash
# Grabbin some noize

# validate url function
validate_url() {
if [[ $1 =~ ^https?://(www\.)?youtube\.com/watch\?v=[a-zA-Z0-9_-]+$ ]]; then
	# check if the video exists ya dhingus
	if curl --output /dev/null --silent --head --fail 



}

# Pass in your gremlin noises I guess
URL="$1"
TEMP_FILE="tempfile.m4a"
FINAL_FILE="$2"

echo "you passed in the url $URL"

# download the stupid video
youtube-dl -x --audio-format m4a --output "$TEMP_FILE" "$URL"

echo "The file has been saved at $TEMP_FILE"
echo "We will now try to convert this, I hope you passed in a good filename"

# convert the gremlin noises into kinda noises
ffmpeg -i "$TEMP_FILE" -vn -ab 128k "$FINAL_FILE"

# mop up the gremlin remains
rm "$TEMP_FILE"

# echo "The gremlin has been captured and squeezed for the goodies, it's at $FINAL_FILE"
