mkdir -p pics
rsync --rsh=ssh -u pi@192.168.1.227:/home/pi/picam_wrapper/pics/* ./pics
for f in pics/*; do mv "$f" $(echo $f | tr -d "-"); done
for f in pics/*; do mv "$f" $(echo $f | tr -d "_"); done

fPattern=./pics/*.jpg
mFile=time_lapse.mp4
sFile=enya.mp3

# ffmpeg -pattern_type glob -i "$fPattern" -i $sFile -framerate 20 -tune film $mFile
ffmpeg -pattern_type glob -i "$fPattern" -framerate 20 -tune film temp1.mp4 

# build concat list
touch list.txt
for i in {1..3}
    do echo "file 'temp1.mp4'" >> list.txt
done

# loop n times
ffmpeg -f concat -i list.txt -c copy temp2.mp4

# slow down vid
ffmpeg -i temp2.mp4 -filter:v "setpts=3.0*PTS" temp3.mp4


# add sound to looped video
ffmpeg -i temp3.mp4 -i $sFile -codec copy temp4.mp4 

# cleanup
rm list.txt
rm temp1.mp4
rm temp2.mp4
rm temp3.mp4
mv temp4.mp4 $mFile

# playback
cvlc --fullscreen $mFile vlc://quit

# Useful?: 
# for some reason changing the filenames between steps helps fix bugs
# cvlv = vlc -I dummy 
# cvlc --no-video $mFile --sout="#std{access=file,mux=mp4,dst=$mFile.mpg}" vlc://quit
# ffmpeg -i $mFile -loop 5 timeLapse.gif
