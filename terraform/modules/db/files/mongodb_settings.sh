#!/bin/bash

sudo sed -i 's/bind_ip = 127.0.0.1/bind_ip = 0.0.0.0/' /etc/mongodb.conf
sudo sed -i 's/#port = 27017/port = 27017/' /etc/mongodb.conf
sudo service mongodb restart
