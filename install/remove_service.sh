#!/bin/bash

sudo systemctl stop time-lapse*
sudo rm /etc/systemd/system/time-lapse*
sudo systemctl daemon-reload
echo 'service removed'
