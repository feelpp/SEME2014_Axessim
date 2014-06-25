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
ncircles=0;
maxr=0;
ll[]={};
shieldlineid=0;
isCircleSurfMarked=0;

//------------------------------------------------------------------------------
// SUPERCIRCLE create a parametered circle.
// ARGS:
//   rx - position x
//   ry - position y
//   rz - position z
//   r  - radius
// RETURN:
//  shieldlineid - the id of the max shield
//------------------------------------------------------------------------------
Function DrawCircle 
    Printf("%f",r);
    p1=newp; Point(p1) = {rx, ry, 0, lc};
    p2=newp; Point(p2) = {rx, ry+r, 0, lc};
    p3=newp; Point(p3) = {rx, ry-r, 0, lc};
    l1=newl; Circle(l1) = {p2, p1, p3};
    l2=newl; Circle(l2) = {p3, p1, p2};
    l3=newl; Line Loop(l3) = {l1, l2};
    ll[]+=l1;
    ll[]+=l2;
    If(r>maxr)
        maxr=r;
        shieldlineid=l3;
    EndIf
    Physical Line(Sprintf("dw%.f",nmarker++)) = {l1, l2};
    If(isCircleSurfMarked>0)
       s1=news; Plane Surface(s1) = {l3};
       Physical Surface(Sprintf("w%f",nmarker++)) = {s1};
    EndIf
Return

//------------------------------------------------------------------------------
// Include circle in the shield surface
//------------------------------------------------------------------------------
Function incCirclesInSurface
    Printf("-- shield line id: %.f",shieldlineid);
    s1=news; Plane Surface(s1) = {shieldlineid};
    Physical Surface("shield") = {s1};
    s=#ll[];
    For i In {0:s-1}
        //Printf("-- lines : %.f", ll[i]);
        //If(ll[i]!=shieldlineid)
            Line {ll[i]} In Surface{s1};
        //EndIf
    EndFor
Return
//------------------------------------------------------------------------------

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
            r=DATA[i*Nj+2];
            ShieldLevel=DATA[i*Nj+3];
            Call DrawCircle;
    EndFor
    Call incCirclesInSurface;
Return

//------------------------------------------------------------------------------
// MAIN
//------------------------------------------------------------------------------
lc = 1;

isCircleSurfMarked=1;
Include "multiwires2.dat";
Call WireFromData;
