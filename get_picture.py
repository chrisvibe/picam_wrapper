from PIL import Image
from os import listdir
from os.path import isfile, join, getctime


def get_picture(pic_path='./pics/', pic_format='jpg'):
    return Image.open(get_newest_picture(pic_format))


def get_newest_picture(pic_path):
    files = listdir(pic_path)
    paths = [join(pic_path, file_name) for file_name in files]
    return max(paths, key=getctime)
