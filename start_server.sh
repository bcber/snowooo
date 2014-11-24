#!/bin/sh
ssh deploy@snowooo.com "cd /var/www/snowooo/current && bundle exec thin start -C thinapp.yml"
