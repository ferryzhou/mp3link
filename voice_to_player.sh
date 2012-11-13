
arecord -f S16_LE -d 3 temp.wav;

sox temp.wav temp.flac;

hyp=$(curl --data-binary @temp.flac --header "Content-type: audio/x-flac; rate=8000" "https://www.google.com/speech-api/v1/recognize?xjerr=1&client=chromium&pfilter=2&lang=zh-CN&maxresults=6" | grep -Po '"utterance":.*?[^\\]",' | perl -pe 's/"utterance"://; s/^"//; s/",$//')

echo $hyp

#uri_escape(){ echo -E "$@" | sed 's/\\/\\\\/g;s/./&\n/g' | while read -r i; do echo $i | grep -q '[a-zA-Z0-9/.:?&=]' && echo -n "$i" || printf %%%x \'"$i" done }

#uri_escape $hyp

hyp_encode=$(echo $hyp | perl -MURI::Escape -ne 'chomp;print uri_escape($_),"\n"')

echo $hyp_encode

mp3link=$(curl "http://mp3link.herokuapp.com/q?name=$hyp_encode")

echo $mp3link

mplayer $mp3link

