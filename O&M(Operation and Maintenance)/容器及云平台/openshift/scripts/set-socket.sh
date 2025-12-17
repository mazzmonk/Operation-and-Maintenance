#!/bin/bash

HOME=/home/blue


ln -s $HOME/apps/docker/var/run/socket /var/run/docker.sock
ln -s $HOME/apps/docker/var/run/docker.pid /var/run/
chown -R blue:blue /home/blue/apps/docker/var/run/*
