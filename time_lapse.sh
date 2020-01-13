#!/bash/bin

get_pics()
{
mkdir -p pics
# rsync --rsh=ssh -u pi@192.168.1.227:/home/pi/picam_wrapper/pics/* ./pics
rsync -avz --files-from=image_list.txt pi@192.168.1.227:/home/pi/picam_wrapper/pics ./pics
}

change_pic_names()
{
for f in pics/*; do mv "$f" $(echo $f | tr -d "-"); done
for f in pics/*; do mv "$f" $(echo $f | tr -d "_"); done
}

reduce_time_frame()
{
for f in pics/*
do
    x=$(echo $f | cut -c 14-15) # hour

    if [ $x -ge 7 ] && [ $x -le 15 ]
    then
       cp $f ./pics2/ 
    fi
done
}

fPattern=./pics2/*.jpg
mFile=time_lapse.mp4
# sFile=enya.mp3
sFile=gymnopedies.mp3

make_time_lapse()
{
rm $mFile || true 
ffmpeg -pattern_type glob -i "$fPattern" -i $sFile -framerate 1000 -tune film $mFile

playback
}

make_looped_time_lapse()
# for some reason changing the filenames between steps helps fix bugs
{
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

playback
}

playback()
{
cvlc --fullscreen $mFile vlc://quit
}

# get_pics
# change_pic_names
# reduce_time_frame
# make_time_lapse

# Useful?: 
# cvlv = vlc -I dummy 
# cvlc --no-video $mFile --sout="#std{access=file,mux=mp4,dst=$mFile.mpg}" vlc://quit
# ffmpeg -i $mFile -loop 5 timeLapse.gif
