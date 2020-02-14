#!/bin/bash
. picam_venv/bin/activate
python3 -c 'import take_picture as tp; tp.take_picture()'
deactivate
# python3 -c 'import take_picture as tp; tp.take_picture(flash_mode=True)'
