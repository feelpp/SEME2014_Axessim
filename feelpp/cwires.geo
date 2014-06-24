// Concentric circles
lc = 1;
rs = 2;
rw = 1;

If( rw > rs )
    Error("Error shield radius should be greater than wire radius");
EndIf

Point(1) = {0, 0, 0, lc};
Point(2) = {0, rw, 0, lc};
Point(3) = {0, rs, 0, lc};
Point(4) = {0, -rw, 0, lc};
Point(5) = {0, -rs, 0, lc};
Circle(1) = {2, 1, 4};
Circle(2) = {4, 1, 2};
Circle(3) = {3, 1, 5};
Circle(4) = {5, 1, 3};
Line Loop(5) = {4, 3};
Line Loop(6) = {2, 1};
Plane Surface(7) = {5, 6};
Physical Line("wire-0") = {4, 3};
Physical Line("wire-1") = {1, 2};
Physical Surface("omega") = {7};
