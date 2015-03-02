#!/bin/sh

VIDEONAME=test
for f in ./figs/*.ps; do convert -quality 100 $f  ./figs/`basename $f .ps`.jpg; done
ffmpeg -r 3 -f image2 -i figs/gmsh_test_2Dview-%1d.jpg $VIDEONAME.avi
