#!/bin/bash
rm -f result/*

DEF=$1;
if ($DEF) then DEF=1; fi;

perl regen.pm result/ maql.txt upload_info.json pattern.csv $DEF
