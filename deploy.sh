#!/bin/sh

sh ./stop_server.sh
ssh-add
cap production deploy
sh ./start_server.sh
