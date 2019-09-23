rsync --rsh=ssh -u pi@192.168.1.227:/home/pi/picam_wrapper/pics/* ./pics
for f in pics/*; do mv "$f" $(echo $f | tr -d "-"); done
for f in pics/*; do mv "$f" $(echo $f | tr -d "_"); done
# ffmpeg -pattern_type glob -i "./pics/*.jpg" -framerate 30 output.mp4
# ffmpeg -pattern_type glob -i "./pics/*.jpg" -framerate 30 -preset veryslow -crf 18 -r 30 output.mp4
ffmpeg -pattern_type glob -i "./pics/*.jpg" -framerate 10 -tune film output.mp4
