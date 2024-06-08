#!/bin/bash
# Grabbin some noize

# validate passed in values
validate_piv(){
#first check if we passed in an URL
if [ -z "$1" ]; then
	echo "You need to pass in a valid Youtube URL ya dingus"
	return 1 #stop
else
	echo "you passed in $URL"
	#continue
fi

if [ -z "$2" ]; then
	echo "Setting output name as default output.mp3" #fix the users mistake
	FINAL_FILE="output.mp3"
	echo "I have fixed your mistake, pray that I do not fix you further"
	return 0
else
	echo "output filename will be $2"
	return 0
fi
}

# validate url function
validate_url() {
if [[ $1 =~ ^https?://(www\.)?youtube\.com/watch\?v=[a-zA-Z0-9_-]+$ ]]; then
	# check if youtube is accessible
	if curl --output /dev/null --silent --head --fail "$1"; then
		return 0
	else
		echo "Youtube is either down or the video is gone"
		return 1
	fi
else
	echo "Invalid Youtube URL format."
	return 1
fi	
	}

# Pass in your gremlin noises I guess
URL="$1"
TEMP_FILE="tempfile.m4a"
FINAL_FILE="$2"

# check if the passed in values are correct
if ! validate_piv "$URL" "$FINAL_FILE"; then
	echo "exiting, user didn't give a url or filename"
	exit 1
fi

# validate the url
if ! validate_url  "$URL"; then
	echo "this url empty or broken! YEET!"
	exit 1
fi


# download the stupid video
youtube-dl -x --audio-format m4a --output "$TEMP_FILE" "$URL"

echo "The file has been saved at $TEMP_FILE"
echo "We will now try to convert this, I hope you passed in a good filename"

# convert the gremlin noises into kinda noises
ffmpeg -i "$TEMP_FILE" -vn -ab 128k "$FINAL_FILE" -loglevel 0

# mop up the gremlin remains
rm "$TEMP_FILE"

# echo "The gremlin has been captured and squeezed for the goodies, it's at $FINAL_FILE"
