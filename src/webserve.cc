/*
Copyright (C) 2024 Andreas Bertsatos <abertsatos@biol.uoa.gr>

This file is part of the statistics package for GNU Octave.

This program is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation; either version 3 of the License, or (at your option) any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
details.

You should have received a copy of the GNU General Public License along with
this program; if not, see <http://www.gnu.org/licenses/>.
*/

#include <thread>
#include <iostream>

#include <octave/oct.h>
#include <octave/parse.h>

#include "crow_all.h"

using namespace std;

// Define the crow application
crow::SimpleApp app;
bool is_routed = false;
thread *crow_server = nullptr;
string served_html;

// Function to run a crow instance
void run_crow (string addr, int port)
{
  // FIXME: Handle multiple servers on different ports?

  // Run app
  app.bindaddr(addr.c_str ())
  .loglevel(crow::LogLevel::Warning)
  .port(port)
  .run();
}

// Function to stop a crow instance
void stop_crow ()
{
  // Close all connections
  // HOW??

  app.stop ();

  try
  {
    // wait for the thread to stop (it might have already)
    if (crow_server)
      crow_server->join ();
  }
  catch (system_error const& e)
  {
    // do nothing
  }
  catch (...)
  {
    throw;
  }
  crow_server = nullptr;

  // Call destructor and recreate object
  app.~Crow ();
  new (&app) crow::SimpleApp();
  is_routed = false;
}

DEFMETHOD_DLD(__webserve__, interp, args, ,
          "-*- texinfo -*-\n\
 @deftypefn  {octave-chartjs} {} __webserve__ (@var{html}, @var{port}, @var{addr})\n\
\n\
\n\
Serve an html string on a web server instance. \n\
\n\n\
@end deftypefn")
{
  // Add defaults
  string addr = "0.0.0.0";
  string html = "This is an Octave WebServer instance!";
  int port = 8080;

  // Parse input arguments
  int nargin = args.length ();
  if (nargin > 0)
  {
    if (args(0).isnumeric () && args(0).is_scalar_type () &&
        args(0).int_value () == 0)
    {
      stop_crow ();
      interp.munlock ();
      return octave_value_list();
    }
    if (args(0).is_string ())
    {
      html = args(0).string_value ();
    }
    else
    {
      error ("htmlserve: HTML must be a string.");
    }
  }
  if (nargin > 1)
  {
    if (args(1).isnumeric () && args(1).is_scalar_type ())
    {
      port = args(1).int_value ();
    }
    else
    {
      error ("htmlserve: PORT must be a scalar integer value.");
    }
  }
  if (nargin > 2)
  {
    if (args(2).isstring ())
    {
      addr = args(2).string_value ();
    }
    else
    {
      error ("htmlserve: ADDR must be a character vector.");
    }
  }

  // Define an endpoint at the root directory
  if (! is_routed)
  {
    // Define an endpoint at the root directory
    CROW_ROUTE (app, "/")
    ([] () { return (served_html.c_str ()); });
    is_routed = true;
  }

  served_html = html;

  // Run crow instance in a separate thread
  if (! crow_server)
  {
    crow_server = new thread (run_crow, addr, port);
    crow_server->detach ();
  }

  // Lock the function
  interp.mlock ();

  return octave_value_list();
}
