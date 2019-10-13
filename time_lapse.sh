# rsync --rsh=ssh -u pi@192.168.1.227:/home/pi/picam_wrapper/pics/* ./pics
# for f in pics/*; do mv "$f" $(echo $f | tr -d "-"); done
# for f in pics/*; do mv "$f" $(echo $f | tr -d "_"); done

fPattern=./pics/*.jpg
aFile=time_lapse.mp4
bFile=temp.mp4
sFile=enya2.mp3

# ffmpeg -pattern_type glob -i "$fPattern" -i $sFile -framerate 20 -tune film $mFile
ffmpeg -pattern_type glob -i "$fPattern" -framerate 20 -tune film $aFile

# build concat list
touch list.txt
for i in {1..3}
    do echo "file '$aFile'" >> list.txt
done

# loop n times
ffmpeg -f concat -i list.txt -c copy $bFile 

# add sound to looped video
ffmpeg -i $bFile -i $sFile -codec copy $aFile 

# playback
cvlc --fullscreen $aFile vlc://quit

# cleanup
rm list.txt
rm temp.mp4

# Useful?: 
# for some reason changing the filenames between steps helps fix bugs
# cvlv = vlc -I dummy 
# cvlc --no-video $mFile --sout="#std{access=file,mux=mp4,dst=$mFile.mpg}" vlc://quit
# ffmpeg -i $mFile -loop 5 timeLapse.gif
