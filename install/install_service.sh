#!/bin/bash

sudo cp systemd_files/* /etc/systemd/system
sudo systemctl daemon-reload

sudo systemctl enable time-lapse.timer
sudo systemctl start time-lapse.timer

echo 'service installed'
