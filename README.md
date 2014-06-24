SEME 2014 Project Axessim
================

The schedule is detailed here:
http://seme.cemosis.fr/programme

All subjects are available here:
https://github.com/cemosis/seme2014-organisation/blob/master/Sujets/README.md

# Freefem++

Freefem++ version 3.30 minimum required

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
