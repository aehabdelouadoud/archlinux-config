#!/bin/bash

notify-send -h string:wf-recorder:record -t 1000 "Recording in:" "<span color='#EA6962' font='20px'><b>3</b></span>"
sleep 1
notify-send -h string:wf-recorder:record -t 1000 "Recording in:" "<span color='#EA6962' font='20px'><b>2</b></span>"
sleep 1
notify-send -h string:wf-recorder:record -t 950 "Recording in:" "<span color='#EA6962' font='20px'><b>1</b></span>"
sleep 1

path="invalid"
good_audio_file=/tmp/temp-audio.wav
noisy_audio_file=/tmp/noisy_temp-audio.wav
video_file=/tmp/temp-video.mkv

wf_recorder_pid=0
ffplay_pid=0
ffmpeg_pid=0

audio=off

# Iterate through all passed arguments
for arg in "$@"; do
  if [[ $arg != --* ]]; then
    path=$arg
    if [[ ! -e $path ]]; then
      echo "Path does not exist"
      exit 1
    fi
    break
  fi
done

if [[ $path == invalid ]]; then
  echo "Need path!"
  exit 1
fi

wf-recorder -f $video_file > /dev/null 2>&1 &
wf_recorder_pid=$!

# Iterate through all passed arguments
for arg in "$@"; do
  if [[ $arg == --webcam ]]; then
    ffplay -f v4l2 -i /dev/video0 -x 232 -y 175 > /dev/null 2>&1 &
    ffplay_pid=$!
  fi
done

# Iterate through all passed arguments
for arg in "$@"; do
  if [[ $arg == --audio ]]; then
    # ffmpeg -y -f alsa -i "default" $audio_file > /dev/null 2>&1 &
    #
    ffmpeg \
      -f pulse \
      -i "default" \
      -filter_complex 'asplit[a1] [a2]; [a1] arnndn=m=/home/x/src/arnndn-models/bd.rnnn [o1];[a2] arnndn=m=/home/x/src/arnndn-models/lq.rnnn [o2]' \
      -map '[o1]' -codec:a pcm_s24le "$good_audio_file" \
      -map '[o2]' -codec:a pcm_s24le "$noisy_audio_file" \
      > /dev/null 2>&1 &

    ffmpeg_pid=$!
  fi
done

safe_kill() {
  if [[ $1 -gt 0 ]] 2> /dev/null; then
    kill -15 "$1" 2>/dev/null || :
  fi
}

# menu
while true; do
    read -p "(screencast 󰹑 ) " choice
    case $choice in
        stop | s)
          echo "Quitting..."
            safe_kill $wf_recorder_pid
            safe_kill $ffplay_pid
            safe_kill $ffmpeg_pid
            if [[ $arg == --audio ]]; then
              ffmpeg -i $good_audio_file -i $video_file -c:v copy -c:a copy "$path/$(date +%Y-%m-%d_%H-%M-%S).mkv" 
              # Clean temp audio files
              rm "$good_audio_file"
              rm "$noisy_audio_file"
            else
              ffmpeg -i $video_file -c:v copy -c:a copy "$path/$(date +%Y-%m-%d_%H-%M-%S).mkv" 
            fi

            # Clean temp video file
            rm "$video_file"
            break 
            ;;
        paus | p)
            echo -e "\nPause"
            ;;
        help | h)
            echo -e "\nAvailable commands are:\n" \
                    "\033[33mstop\033[0m: recording\n" \
                    "\033[33mhelp\033[0m: print menu help"
            ;;
        *)
            echo -e "\nInvalid command."
            ;;
    esac
done

