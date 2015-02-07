SEME 2014 Project Axessim
================

The schedule is detailed here:
http://seme.cemosis.fr/programme

All subjects are available here:
https://github.com/cemosis/seme2014-organisation/blob/master/Sujets/README.md

# License

Feel++ and FreeFem source codes for this project are redistributed under the LGPL-2.1 license.
Reports, slides sources and also generated binaries are distributed under the creative common CC-BY license.

see more about:
- [CC license terms](https://creativecommons.org/licenses/by/3.0/)
- [LGPL license terms](http://www.gnu.org/licenses/lgpl-2.1.html)

# Directory structure

| directory | description |
| --------- | ------------|
| /bibliography | bib files for latex |
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

Just send an empty email to
- [Subscribe](mailto:seme2014_axessim-commits+subscribe@googlegroups.com) / [Unsubscribe](mailto:seme2014_axessim-commits+unsubscribe@googlegroups.com) to the commit list 

