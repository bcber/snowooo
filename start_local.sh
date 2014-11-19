#!/bin/sh

rake assets:clean && rake assets:precompile && bundle exec thin restart -C thinapp.yml
