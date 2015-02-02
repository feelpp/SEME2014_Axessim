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


////////////////////////////////////////////////////////////////////////////////
// FUNCTIONS TO DRAW CIRCLES
////////////////////////////////////////////////////////////////////////////////


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


////////////////////////////////////////////////////////////////////////////////
// SAMPLES
////////////////////////////////////////////////////////////////////////////////


//------------------------------------------------------------------------------
// Create Nc recurrence of 3 circles
// Rx - initial x position for the center of the 3 circles
// Ry - initial y position for the center of the 3 circles
// d  - distance from the center
//------------------------------------------------------------------------------
Function WireDataTriCircle1
    isCircleSurfMarked=0;
    DATA[]={};
    Rx=0;
    Ry=0;
    dist=40;
    distfrombound=4;
    Nl=10;
    For j In {1:Nl}
        For i In {1:3}
            rad=dist/2;
            DATA+=dist*Cos(i*2*Pi/3);
            DATA+=dist*Sin(i*2*Pi/3);
            DATA+=rad;
            DATA+=0;
        EndFor
        DATA+=0;
        DATA+=0;
        DATA+=dist+rad+distfrombound;
        DATA+=0;
        dist=dist/4;
        distfrombound=distfrombound/4;
    EndFor
Return

//------------------------------------------------------------------------------
// Create Nc recurrence of 3 circles
// Rx - initial x position for the center of the 3 circles
// Ry - initial y position for the center of the 3 circles
// d  - distance from the center
// Nc - Level of recursion of 3-circles
//------------------------------------------------------------------------------
Function WireDataTriCircle2
    isCircleSurfMarked=1;
    DATA[]={};
    Rx=0;
    Ry=0;
    dist=10;
    dist2=30;
    distfrombound=4;
    distfrombound2=4;
    Nl=1;
    For j In {1:Nl}
        For k In {1:3}
            Rx=dist2*Cos(k*2*Pi/3);
            Ry=dist2*Sin(k*2*Pi/3);

            //For i In {1:3}
            //    rad=dist/2;
            //    DATA+=dist/2*Cos(i*2*Pi/3);
            //    DATA+=dist/2*Sin(i*2*Pi/3);
            //    DATA+=rad/2;
            //    DATA+=0;
            //EndFor

            // Tri wires diag
            //For i In {1:3}
            //    rad=dist/2;
            //    DATA+=dist2*Cos(i*2*Pi/3+Pi/3);
            //    DATA+=dist2*Sin(i*2*Pi/3+Pi/3);
            //    DATA+=3*rad/2;
            //    DATA+=0;
            //EndFor

            // Tri wires center
            For i In {1:3}
                rad=dist/2;
                DATA+=Rx+dist*Cos(i*2*Pi/3);
                DATA+=Ry+dist*Sin(i*2*Pi/3);
                DATA+=rad;
                DATA+=0;
            EndFor

            //For i In {1:3}
            //    rad=dist/2;
            //    DATA+=Rx+dist*Cos(i*2*Pi/3+Pi/3);
            //    DATA+=Ry+dist*Sin(i*2*Pi/3+Pi/3);
            //    DATA+=rad/2;
            //    DATA+=0;
            //EndFor

            DATA+=Rx;
            DATA+=Ry;
            DATA+=dist+rad+distfrombound;
            DATA+=0;
        EndFor

        dist=dist/4;
        distfrombound=distfrombound/4;
    EndFor
            DATA+=0;
            DATA+=0;
            DATA+=dist2+dist+rad+distfrombound+distfrombound2+20;
            DATA+=0;
        distfrombound2=distfrombound2/4;
Return

//------------------------------------------------------------------------------
// Create Nc recurrence of 3 circles + 1 shield
// Rx - initial x position for the center of the 3 circles
// Ry - initial y position for the center of the 3 circles
// d  - distance from the center
// Nc - Level of recursion of 3-circles
//------------------------------------------------------------------------------
Function WireDataTriCircle3
    isCircleSurfMarked=0;
    DATA[]={};
    Rx=0;
    Ry=0;
    Nl=1;

    orbit=2;
    rad1=1;
    rad2=4;

    For j In {1:Nl}
//        For k In {1:3}
//            Rx=dist2*Cos(k*2*Pi/3);
//            Ry=dist2*Sin(k*2*Pi/3);

            // Tri wires center
            For i In {1:3}
                DATA+=Rx+orbit*Cos(i*2*Pi/3);
                DATA+=Ry+orbit*Sin(i*2*Pi/3);
                DATA+=rad1;
                DATA+=0;
            EndFor

            // Shield
            DATA+=Rx;
            DATA+=Ry;
            DATA+=rad2;
            DATA+=0;
//        EndFor
    EndFor
Return


//------------------------------------------------------------------------------
// Create Nc recurrence of n circles per shield
// Shield index recursive formula: s_id(n) = s_id(n-1) + (2n+2)
// Rx - initial x position for the center of the 3 circles
// Ry - initial y position for the center of the 3 circles
// d  - distance from the center
// Nl - Level of recursion of 3-circles
//------------------------------------------------------------------------------
Function WireDataNCircle
    isCircleSurfMarked=0;
    DATA[]={};
    Nl=2;
    Rx=0;
    Ry=0;
    rad1=0.5;
    rad2=2;
    orbit=1;
//    Nc=3;

    dist=orbit;
    r1=rad1;
    r2=rad2;
    For j In {1:Nl}
            // Tri wires center
            Nc=2*j+1;
            For i In {1:Nc}
                DATA+=Rx+dist*Cos(i*2*Pi/Nc);
                DATA+=Ry+dist*Sin(i*2*Pi/Nc);
                DATA+=r1;
                DATA+=0;
            EndFor

            // Shield
            DATA+=Rx;
            DATA+=Ry;
            DATA+=r2;
            DATA+=0;

            dist+=2*orbit;
            r2+=rad2;
    EndFor
Return

////////////////////////////////////////////////////////////////////////////////
// MAIN PROGRAM
////////////////////////////////////////////////////////////////////////////////


lc = 0.3;

isCircleSurfMarked=1;

// Load data from a file
//Include "multiwires2.dat";

// Load samples
//Call WireDataTriCircle1;
//Call WireDataTriCircle2;
//Call WireDataTriCircle3;
Call WireDataNCircle;

// Draw the geometry
Call WireFromData;
