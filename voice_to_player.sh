
arecord -f S16_LE -d 3 temp.wav;

sox temp.wav temp.flac;

hyp=$(curl --data-binary @temp.flac --header "Content-type: audio/x-flac; rate=8000" "https://www.google.com/speech-api/v1/recognize?xjerr=1&client=chromium&pfilter=2&lang=zh-CN&maxresults=6" | grep -Po '"utterance":.*?[^\\]",' | perl -pe 's/"utterance"://; s/^"//; s/",$//')

echo $hyp

mp3link=$(curl -G --data-urlencode "name=$hyp" "http://mp3link.herokuapp.com/q")

echo $mp3link

mplayer $mp3link

