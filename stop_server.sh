#!/bin/sh

ssh deploy@snowooo.com "cd /var/www/snowooo/current && bundle exec thin stop -C thinapp.yml"
