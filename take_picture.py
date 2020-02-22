from picamera import PiCamera
from time import sleep
from datetime import datetime
from threading import Thread


def take_picture(pic_path='./pics/',
                 pic_format='jpg',
                 log_path=False,
                 log_data=False,
                 stamp_format='%Y-%m-%d_%H-%M-%S',
                 flash_mode=False,
                 rotation=0,
                 resolution=(1024, 768),
                 stabilize_time=2,  # s
                 ):

    with PiCamera() as camera:
        # INITIALIZE
        camera.rotation = rotation
        camera.resolution = resolution
        camera.start_preview()
        sleep(stabilize_time)

        time_stamp = datetime.now().strftime(stamp_format)
        file_name = pic_path + time_stamp + '.' + pic_format

        # TAKE PIC
        if flash_mode:
            # flash.charge()
            sleep(1/10)
            # Thread(target=flash.trigger).start()
            #Thread(target=camera.capture, args=(file_name,)).start()
            sleep(1)
            # flash.cleanup()
        else:
            camera.capture(file_name)

        # LOG EVENT
        if log_path:
            with open(log_path, 'a') as log_file:
                log_file.write(time_stamp + ' ' + str(log_data) + '\n')


if __name__ == '__main__':
    take_picture(flash_mode=True)
    take_picture()
    print('picture taken!')
