#!/bin/bash
rm -f result/*
mkdir -p result

DEF=${1:-1}

perl regen.pm result/ maql.txt upload_info.json pattern.csv "$DEF"
