/*
Copyright (C) 2026 Andreas Bertsatos <abertsatos@biol.uoa.gr>

This file is part of the chartjs package for GNU Octave.

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

#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <set>
#include <string>

#include <octave/oct.h>

using namespace std;

// The places where Chart.js always reads an array, as dotted field names
// with no indices, so that one path covers every element below it.
typedef set<string> paths;

static void encode (string& out, const octave_value& val, const string& path,
                    const paths& arrays, bool element = false);

// A field's path below its parent's
static inline string
child (const string& path, const string& key)
{
  return path.empty () ? key : path + "." + key;
}

// Text in double quotes, escaped so that it reads back as written.  '<' is
// escaped too, so that no string can close the script element the JSON is
// placed in, and U+2028 and U+2029, which end a line in older JavaScript.
static void
encode_string (string& out, const string& str)
{
  static const char hex[] = "0123456789abcdef";
  out += '"';
  for (size_t i = 0; i < str.size (); i++)
  {
    const unsigned char c = str[i];
    switch (c)
    {
      case '"':
        out += "\\\"";
        break;
      case '\\':
        out += "\\\\";
        break;
      case '\b':
        out += "\\b";
        break;
      case '\f':
        out += "\\f";
        break;
      case '\n':
        out += "\\n";
        break;
      case '\r':
        out += "\\r";
        break;
      case '\t':
        out += "\\t";
        break;
      case '<':
        out += "\\u003c";
        break;
      default:
        if (c < 0x20)
        {
          out += "\\u00";
          out += hex[c >> 4];
          out += hex[c & 0xf];
        }
        else if (c == 0xe2 && i + 2 < str.size ()
                 && static_cast<unsigned char> (str[i+1]) == 0x80
                 && (static_cast<unsigned char> (str[i+2]) == 0xa8
                     || static_cast<unsigned char> (str[i+2]) == 0xa9))
        {
          out += static_cast<unsigned char> (str[i+2]) == 0xa8
                 ? "\\u2028" : "\\u2029";
          i += 2;
        }
        else
        {
          out += static_cast<char> (c);
        }
    }
  }
  out += '"';
}

// "1e-07" and "1e+20" as "1e-7" and "1e20"
static string
tidy (const char* buf)
{
  string s (buf);
  const size_t e = s.find ('e');
  if (e == string::npos)
  {
    return s;
  }
  string sign;
  size_t d = e + 1;
  if (s[d] == '-')
  {
    sign = "-";
  }
  if (s[d] == '-' || s[d] == '+')
  {
    d++;
  }
  while (d + 1 < s.size () && s[d] == '0')
  {
    d++;
  }
  return s.substr (0, e) + "e" + sign + s.substr (d);
}

// The fewest of 15, 16 or 17 significant digits that read back as the same
// double, and null for NaN and Inf, which JSON cannot hold.  Octave keeps LC_NUMERIC at "C",
// so the decimal point is always '.'.
static void
encode_double (string& out, double x)
{
  if (! isfinite (x))
  {
    out += "null";
    return;
  }
  char buf[32];
  for (int p = 15; p <= 17; p++)
  {
    snprintf (buf, sizeof (buf), "%.*g", p, x);
    if (strtod (buf, nullptr) == x)
    {
      break;
    }
  }
  out += tidy (buf);
}

// As encode_double, for single precision
static void
encode_single (string& out, float x)
{
  if (! isfinite (x))
  {
    out += "null";
    return;
  }
  char buf[32];
  for (int p = 6; p <= 9; p++)
  {
    snprintf (buf, sizeof (buf), "%.*g", p, static_cast<double> (x));
    if (strtof (buf, nullptr) == x)
    {
      break;
    }
  }
  out += tidy (buf);
}

// Only vectors have one obvious order to be written in
static void
check_vector (const octave_value& val)
{
  const dim_vector dv = val.dims ();
  if (dv.ndims () > 2 || (dv(0) > 1 && dv(1) > 1))
  {
    error ("__chartjson__: arrays must be vectors.");
  }
}

// A scalar is written as a value and anything else as an array, unless its
// path is one of ARRAYS, where it is always an array.  ELEMENT marks an
// element of a cell array, which shares the cell's path so that the fields
// below it are found, but is already in an array and is not made one again.
static void
encode (string& out, const octave_value& val, const string& path,
        const paths& arrays, bool element)
{
  const bool forced = ! element && arrays.count (path) > 0;

  // A struct is an object, and a struct array a list of them
  if (val.isstruct ())
  {
    check_vector (val);
    const octave_map map = val.map_value ();
    const string_vector keys = map.keys ();
    const octave_idx_type n = map.numel ();
    const bool list = forced || n != 1;
    if (list)
    {
      out += '[';
    }
    for (octave_idx_type i = 0; i < n; i++)
    {
      if (i > 0)
      {
        out += ',';
      }
      out += '{';
      for (octave_idx_type k = 0; k < keys.numel (); k++)
      {
        if (k > 0)
        {
          out += ',';
        }
        encode_string (out, keys(k));
        out += ':';
        encode (out, map.contents (keys(k))(i), child (path, keys(k)),
                arrays);
      }
      out += '}';
    }
    if (list)
    {
      out += ']';
    }
  }

  // A cell is always an array; its elements stay at the cell's path
  else if (val.iscell ())
  {
    check_vector (val);
    const Cell c = val.cell_value ();
    out += '[';
    for (octave_idx_type i = 0; i < c.numel (); i++)
    {
      if (i > 0)
      {
        out += ',';
      }
      encode (out, c(i), path, arrays, true);
    }
    out += ']';
  }

  // A character vector is one string
  else if (val.is_string ())
  {
    if (val.rows () > 1)
    {
      error ("__chartjson__: character arrays must be a single row.");
    }
    if (forced)
    {
      out += '[';
    }
    encode_string (out, val.string_value ());
    if (forced)
    {
      out += ']';
    }
  }

  // Logical and numeric values
  else if (val.islogical () || val.isnumeric ())
  {
    if (val.iscomplex ())
    {
      error ("__chartjson__: complex values cannot be written to JSON.");
    }
    check_vector (val);
    const octave_idx_type n = val.numel ();
    const bool list = forced || n != 1;
    if (list)
    {
      out += '[';
    }
    if (val.islogical ())
    {
      const boolNDArray a = val.bool_array_value ();
      for (octave_idx_type i = 0; i < n; i++)
      {
        out += i > 0 ? "," : "";
        out += a(i) ? "true" : "false";
      }
    }
    else if (val.isinteger ())
    {
      // Unsigned classes are read as uint64 so that no value above the
      // int64 range is lost
      if (val.class_name ()[0] == 'u')
      {
        const uint64NDArray a = val.uint64_array_value ();
        for (octave_idx_type i = 0; i < n; i++)
        {
          out += i > 0 ? "," : "";
          out += to_string (a(i).value ());
        }
      }
      else
      {
        const int64NDArray a = val.int64_array_value ();
        for (octave_idx_type i = 0; i < n; i++)
        {
          out += i > 0 ? "," : "";
          out += to_string (a(i).value ());
        }
      }
    }
    else if (val.is_single_type ())
    {
      const FloatNDArray a = val.float_array_value ();
      for (octave_idx_type i = 0; i < n; i++)
      {
        out += i > 0 ? "," : "";
        encode_single (out, a(i));
      }
    }
    else
    {
      const NDArray a = val.array_value ();
      for (octave_idx_type i = 0; i < n; i++)
      {
        out += i > 0 ? "," : "";
        encode_double (out, a(i));
      }
    }
    if (list)
    {
      out += ']';
    }
  }

  else
  {
    error ("__chartjson__: values of class '%s' cannot be written to JSON.",
           val.class_name ().c_str ());
  }
}

DEFUN_DLD (__chartjson__, args, ,
           "-*- texinfo -*-\n\
 @deftypefn  {} {@var{json} =} __chartjson__ (@var{value})\n\
 @deftypefnx {} {@var{json} =} __chartjson__ (@var{value}, @var{paths})\n\
\n\
\n\
Write an Octave value as JSON text. \n\
\n\
A scalar struct is written as an object, a struct array as an array of \
objects, a cell array as an array, a character vector as a string, and a \
numeric or logical scalar as a number or boolean, with longer vectors as \
arrays.  @qcode{NaN} and @qcode{Inf} are written as @qcode{null}, and every \
@qcode{<} in a string as @qcode{\\u003c}, so that the text can be placed in \
an HTML script element. \n\
\n\
@var{paths} is a cell array of dotted field names, such as \
@qcode{'data.datasets.data'}, naming the fields that are always written as \
arrays, a single element and a scalar struct included.  A path has no \
indices: it names the field in every element of the struct arrays and cell \
arrays above it. \n\
\n\
This is a helper function for the @qcode{jsonstring} methods of the chartjs \
classes.  Do NOT use this function directly. \n\
\n\
@end deftypefn")
{
  // Validate input
  if (args.length () < 1 || args.length () > 2)
  {
    error ("__chartjson__: invalid number of input arguments.");
  }
  paths arrays;
  if (args.length () == 2)
  {
    if (! args(1).iscellstr ())
    {
      error ("__chartjson__: PATHS must be a cell array of character "
             "vectors.");
    }
    const Array<string> p = args(1).cellstr_value ();
    for (octave_idx_type i = 0; i < p.numel (); i++)
    {
      arrays.insert (p(i));
    }
  }
  string out;
  encode (out, args(0), "", arrays);
  return octave_value (out);
}

/*
## Numbers
%!assert_equal (__chartjson__ (1), "1")
%!assert_equal (__chartjson__ (-0.5), "-0.5")
%!assert_equal (__chartjson__ (0.1), "0.1")
%!assert_equal (__chartjson__ (1/3), "0.3333333333333333")
%!assert_equal (__chartjson__ (0.1 + 0.2), "0.30000000000000004")
%!assert_equal (__chartjson__ (1e-7), "1e-7")
%!assert_equal (__chartjson__ (1e20), "1e20")
%!assert_equal (__chartjson__ (realmax), "1.7976931348623157e308")
%!assert_equal (__chartjson__ (realmin), "2.2250738585072014e-308")
%!assert_equal (__chartjson__ (5e-324), "4.94065645841247e-324")
%!assert_equal (__chartjson__ (2.0041885375976562), "2.0041885375976562")
%!assert_equal (__chartjson__ (0.37438641622486307), "0.3743864162248631")
%!assert_equal (__chartjson__ (123456789.12345679), "123456789.12345679")
%!assert_equal (__chartjson__ (2^53 + 1), "9007199254740992")
%!assert_equal (__chartjson__ ([NaN, Inf, -Inf]), "[null,null,null]")
%!assert_equal (__chartjson__ (single (0.1)), "0.1")
%!assert_equal (__chartjson__ (single (NaN)), "null")
%!assert_equal (__chartjson__ (int8 (-5)), "-5")
%!assert_equal (__chartjson__ (intmin ("int64")), "-9223372036854775808")
%!assert_equal (__chartjson__ (intmax ("uint64")), "18446744073709551615")
%!assert_equal (__chartjson__ ([1, 2]), "[1,2]")
%!assert_equal (__chartjson__ ([1; 2]), "[1,2]")
%!assert_equal (__chartjson__ ([]), "[]")
%!assert_equal (__chartjson__ (1:3), "[1,2,3]")
%!assert_equal (__chartjson__ (sparse ([1, 0])), "[1,0]")

## Logical values
%!assert_equal (__chartjson__ (true), "true")
%!assert_equal (__chartjson__ ([true, false]), "[true,false]")

## Strings
%!assert_equal (__chartjson__ ("a"), "\"a\"")
%!assert_equal (__chartjson__ (""), "\"\"")
%!assert_equal (__chartjson__ ("it's"), "\"it's\"")
%!assert_equal (__chartjson__ ("say \"hi\""), "\"say \\\"hi\\\"\"")
%!assert_equal (__chartjson__ ('a\b'), "\"a\\\\b\"")
%!assert_equal (__chartjson__ ("a\nb\tc"), "\"a\\nb\\tc\"")
%!assert_equal (__chartjson__ (char (1)), "\"\\u0001\"")
%!assert_equal (__chartjson__ ("</script>"), "\"\\u003c/script>\"")
%!assert_equal (__chartjson__ (char ([226, 128, 168])), "\"\\u2028\"")
%!assert_equal (__chartjson__ ("é"), "\"é\"")

## Cell arrays
%!assert_equal (__chartjson__ ({1, "a"}), "[1,\"a\"]")
%!assert_equal (__chartjson__ ({1}), "[1]")
%!assert_equal (__chartjson__ ({}), "[]")
%!assert_equal (__chartjson__ ({{1}}), "[[1]]")

## Structs
%!assert_equal (__chartjson__ (struct ("a", 1, "b", "x")), ...
%!              "{\"a\":1,\"b\":\"x\"}")
%!assert_equal (__chartjson__ (struct ()), "{}")
%!assert_equal (__chartjson__ (struct ("a", {1, 2})), "[{\"a\":1},{\"a\":2}]")
%!assert_equal (__chartjson__ (struct ("a", {})), "[]")
%!assert_equal (__chartjson__ (struct ("a", {{1, 2}})), "{\"a\":[1,2]}")

## Paths always written as arrays
%!assert_equal (__chartjson__ (struct ("a", 1), {'a'}), "{\"a\":[1]}")
%!assert_equal (__chartjson__ (struct ("a", "x"), {'a'}), "{\"a\":[\"x\"]}")
%!assert_equal (__chartjson__ (struct ("a", true), {'a'}), "{\"a\":[true]}")
%!assert_equal (__chartjson__ (struct ("a", struct ("b", 1)), {'a'}), ...
%!              "{\"a\":[{\"b\":1}]}")
%!assert_equal (__chartjson__ (struct ("a", {{1}}), {'a'}), "{\"a\":[1]}")
%!assert_equal (__chartjson__ (struct ("a", 1), {'b'}), "{\"a\":1}")
%!test
%! s.data.datasets.data = 5;
%! assert_equal (__chartjson__ (s, {'data.datasets', 'data.datasets.data'}), ...
%!               "{\"data\":{\"datasets\":[{\"data\":[5]}]}}");
%!test
%! s.data.datasets = struct ("data", {5, 6});
%! assert_equal (__chartjson__ (s, {'data.datasets.data'}), ...
%!               "{\"data\":{\"datasets\":[{\"data\":[5]},{\"data\":[6]}]}}");
%!test
%! s.data.datasets = {struct("data", 5), struct("data", 6, "b", 1)};
%! json = ["{\"data\":{\"datasets\":[{\"data\":[5]},", ...
%!         "{\"data\":[6],\"b\":1}]}}"];
%! assert_equal (__chartjson__ (s, {'data.datasets.data'}), json);
%!test
%! s = struct ("data", {struct("x", 1), struct("x", 2)});
%! assert_equal (__chartjson__ (s, {'data.x'}), ...
%!               "[{\"data\":{\"x\":[1]}},{\"data\":{\"x\":[2]}}]");

## The text reads back as the value written
%!testif HAVE_RAPIDJSON
%! s = struct ("a", {{"</script>", "it's", char(10)}}, "b", [0.1, 1e-7]);
%! d = jsondecode (__chartjson__ (s));
%! assert_equal (d.a, {"</script>"; "it's"; char(10)});
%! assert_equal (d.b, [0.1; 1e-7]);

## Input validation
%!error <__chartjson__: invalid number of input arguments.> __chartjson__ ()
%!error <__chartjson__: invalid number of input arguments.> ...
%! __chartjson__ (1, {}, 1)
%!error <__chartjson__: PATHS must be a cell array of character vectors.> ...
%! __chartjson__ (1, "a")
%!error <__chartjson__: arrays must be vectors.> __chartjson__ (ones (2))
%!error <__chartjson__: arrays must be vectors.> __chartjson__ (cell (2))
%!error <__chartjson__: arrays must be vectors.> ...
%! __chartjson__ (repmat (struct ("a", 1), 2, 2))
%!error <__chartjson__: character arrays must be a single row.> ...
%! __chartjson__ (["ab"; "cd"])
%!error <__chartjson__: complex values cannot be written to JSON.> ...
%! __chartjson__ (1i)
%!error <__chartjson__: values of class 'function_handle' cannot be written to JSON.> ...
%! __chartjson__ (@sin)
*/
