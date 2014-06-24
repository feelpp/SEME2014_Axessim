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

//#include <feel/feelfilters/exporter.hpp>
//#include <feel/feeldiscr/pch.hpp>
//#include <feel/feelfilters/loadmesh.hpp>
//#include <feel/feelvf/form.hpp>
//#include <feel/feelvf/integrator.hpp>
//#include <feel/feelvf/trans.hpp>
#include <feel/feel.hpp>

#define DIM 2

using namespace Feel;
using namespace Feel::vf;

int main( int argc, char** argv )
{
    Feel::Environment env( _argc=argc, _argv=argv );

    typedef Mesh< Simplex<DIM> > mesh_type;
    auto mesh = loadMesh( _mesh=new mesh_type );
    auto Xh = Pch<1>( mesh );

    auto u = Xh->element();
    auto v = Xh->element();
    auto e = exporter( _mesh=mesh );

    for( int id=0; id<2; id++)
    {
        auto a = form2( _test=Xh, _trial=Xh);
        auto l = form1( _test=Xh );

        // Dirichlet boundary condition
        a = integrate( _range=elements( mesh ),
                       _expr= gradt(u)*trans(grad(v)) );

        l = integrate( _range=elements( mesh ),
                       _expr= constant(0.) );

        // Boundary condition (strongly imposed)
        a += on( _range=markedfaces( mesh, "shield" ),
                 _rhs=l,
                 _element=u,
                 _expr=constant(1-id) );

        a += on( _range=markedfaces( mesh, "wired" ),
                 _rhs=l,
                 _element=u,
                 _expr=constant(id) );

        a.solve( _rhs=l, _solution=u );

        e->step(0)->setMesh(mesh);
        e->step(0)->addRegions();
        e->step(0)->add( ( boost::format( "u%1%" ) % id ).str(), u );
        e->save();
    }

    return 0;
}

