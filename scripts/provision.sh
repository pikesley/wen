#!/bin/bash

#cd ~/wen
git pull
bundle

sudo bundle exec foreman export systemd -u pi -a wen /etc/systemd/system/
sudo systemctl enable wen.target

sudo cp scripts/timekeeper.service /etc/systemd/system/
sudo systemctl enable timekeeper.service

sudo cp scripts/pivertiser.service /etc/systemd/system/
sudo systemctl enable pivertiser.service

sudo cp scripts/vhost /etc/nginx/sites-enabled/wen
sudo service nginx restart

sudo systemctl restart wen.target
