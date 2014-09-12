SEME 2014 Project Axessim
================

The schedule is detailed here:
http://seme.cemosis.fr/programme

All subjects are available here:
https://github.com/cemosis/seme2014-organisation/blob/master/Sujets/README.md

# Directory structure

| directory | description |
| --------- | ------------|
| /feelpp   | All feel++ source codes |
| /figures  | All tex figures (binaries) |
| /geo      | All GMSH geometries |
| /freefempp | All freefem source codes |
| /report | Report tex sources |
| /slides | Presentation tex sources |

# Report and Slides

Report and slides can be compiled using a texlive base install which should be
available on most linux/unix distributions.
Consider using the provided makefile to automatically compile the tex sources
and also the bibliography:

| Command  | Description |
| -------- | ------ |
|`make`| compile the tex document into ./tmp |
|`make clean`| clean the tmp folder |

NB: You might have to execute twice make to print the bibliography.

# Freefem++

Freefem++ version 3.30 minimum required

See also:
- [freefem++ website](http://www.freefem.org/ff++/)
- [freefem++ mercurial](http://www.freefem.org/ff++/ff++/http://www.freefem.org/ff++/ff++/)

# Feel++

To compile the program just do

    cd feelpp
    mkdir work
    cd work
    cmake ..
    make -j<nthreads>

Then run the program
    ./feelpp_seme2014_axessim --gmsh.filename=cwires.geo

This will create a ensight file .sos you can visualize using paraview or ensight.

See also:
- [feel++ website](http://www.feelpp.org/)
- [feel++ github](https://github.com/feelpp/feelpp)

# Mailing lists

[Github commits](seme2014_axessim-commits@googlegroups.com)

