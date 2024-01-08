#!/bin/bash

while ps ax | grep -i [a]pt ; do sleep 10; done;

apt update
apt install -y  ruby-full ruby-bundler build-essential
