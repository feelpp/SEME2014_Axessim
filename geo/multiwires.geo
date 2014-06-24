/************************************************************************[ LIC ]
 Author(s): Guillaume Dolle <gdolle@unistra.fr>
 Date: 2014-06-27
 Copyright (C) 2014 Universite de Strasbourg

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>
********************************************************************************/

nmarker=0;

//------------------------------------------------------------------------------
// SUPERCIRCLE create a parametered circle.
// ARGS:
//   rx - position x
//   ry - position y
//   rz - position z
//   r  - radius
//------------------------------------------------------------------------------
Function SuperCircle 
    Printf("%f",r);
    p1=newp; Point(p1) = {rx, ry, rz, lc};
    p2=newp; Point(p2) = {rx, r, rz, lc};
    p3=newp; Point(p3) = {rx, -r, rz, lc};
    l1=newl; Circle(l1) = {p2, p1, p3};
    l2=newl; Circle(l2) = {p3, p1, p2};
    l3=newl; Line Loop(l3) = {l1, l2};
    Physical Line(Sprintf("wire-%.f",nmarker)) = {l1, l2};
    nmarker++;
Return

//------------------------------------------------------------------------------
// WIREFROMDATA read a matrix POS (Nx4) where each rows contains
// <rx,ry,rz,r>
//------------------------------------------------------------------------------
Function WireFromData
    N=#DATA[];
    Printf("-- Number of wires: %.f",N);
    Nj=4;
    Ni=N/Nj;
    For i In {0:Ni-1}
            Printf("data number %f",i*Nj);
            rx=DATA[i*Nj];
            ry=DATA[i*Nj+1];
            rz=DATA[i*Nj+2];
            r=DATA[i*Nj+3];
            Call SuperCircle;
    EndFor
Return

//------------------------------------------------------------------------------
// MAIN
//------------------------------------------------------------------------------
lc = 1;
Include "multiwires.dat";
Call WireFromData;
