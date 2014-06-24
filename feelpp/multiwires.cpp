/* -*- mode: c++; coding: utf-8; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4; show-trailing-whitespace: t -*- vim:set fenc=utf-8 ft=cpp et sw=2 ts=4 sts=4

  This file is part of the Feel library

  Author(s): Guillaume Dolle <gdolle@unistra.fr>
       Date: 2014-06-27

  Copyright (C) 2008-2014 Universite de Strasbourg

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/
/**
   \file project.cpp
   \author Guillaume Dolle <gdolle@unistra.fr>
   \date 2014-01-21
 */

#include <feel/feel.hpp>

#define DIM 2

using namespace Feel;
using namespace Feel::vf;

int main( int argc, char** argv )
{
    po::options_description myopts( "MyApp options" );
    myopts.add_options()
        ( "nwires", po::value<int>() -> default_value(2), "number of wires" );

    Feel::Environment env( _argc=argc, _argv=argv,
                           _desc=myopts);

    typedef Mesh< Simplex<DIM> > mesh_type;
    auto mesh = loadMesh( _mesh=new mesh_type );
    auto Xh = Pch<1>( mesh );

    auto phi = Xh->element();
    auto v = Xh->element();
    auto psi =Xh->element();
    auto f = cst(0.);
    auto e = exporter( _mesh=mesh );

    int nwires = ioption("nwires");

    // Loop on wires (0 == shield).
    for( int i=0; i<nwires; i++)
    {
        auto a = form2( _test=Xh, _trial=Xh);
        auto l = form1( _test=Xh );

        a = integrate( _range=elements( mesh ),
                       _expr= gradt(phi)*trans(grad(v)) );

        l = integrate( _range=elements( mesh ),
                       _expr=f*id(v) );

        // Dirichlet boundary condition (strongly imposed on each boundary !!!)
        for(int j=0; j<nwires; j++)
        {
            a += on( _range=markedfaces( mesh, ( boost::format( "wire-%1%" ) % j ).str() ),
                     _rhs=l,
                     _element=phi,
                     _expr=chi(i==j) );
        }

        a.solve( _rhs=l, _solution=phi );

        auto o1 = vf::project(Xh, markedfaces( mesh, ( boost::format( "wire-%1%" ) % i ).str() ), cst(1));
        auto bound=integrate( _range=elements( mesh ),
                              _expr=gradv(phi)*trans(gradv(o1)) ).evaluate()(0,0);

        //std::cout << bound[0];

        e->add( ( boost::format( "phi%1%" ) % i ).str(), phi );
        e->add( ( boost::format( "proj%1%" ) % i ).str(), o1 );
    }
    e->save();

    return 0;
}

