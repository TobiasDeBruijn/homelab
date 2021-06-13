#!/bin/bash

#
# MCAR - MCA Remover
# Remove region files past a certain distance from 0,0
#
# Usage
# ./mcar.sh $1
#
# Where $1 is the distance in blocks from 0,0 that should be preserved (i.e past $1 regions will be deleted)
# $1 must be a multiple of 512 and more than 512

IR=$1

if [ -z "$IR" ]
then
        IR=1024
fi

if [ $(("$IR" % 512 )) -ne 0 ]
then
        echo "Input '$IR' is not a multiple of 512!"
        exit 1
fi

if test "$IR" -lt 512
then
        echo "Input '$IR' is lower than 512!"
        exit 1
fi

R=$(($IR / 512))


for f in *.mca
do
        X=$(echo $f | cut -d'.' -f2)
        Z=$(echo $f | cut -d'.' -f3)

        if test "$X" -gt "$R" -o "$X" -lt "-$R" -o "$Z" -gt "$R" -o "$Z" -lt "-$R"
        then
                echo Deleting $f
                rm -f $f
        fi
done
