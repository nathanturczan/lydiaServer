#!/bin/bash

BASEDIR=$(dirname $0)
cd $BASEDIR

chuck --loop &

sleep 2

chuck + initialize.ck

sleep 10

chuck ^

sleep 5

chuck ^

sleep 10000

