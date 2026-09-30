# chartjs

A ChartJS interface for GNU Octave.

**Content:**

1. [About](#1-about)
2. [Documentation](#2-documentation)
3. [Installation](#3-installation)

## 1. About

The **chartjs** package is a collection of [classdef Classes](https://docs.octave.org/latest/classdef-Classes.html) for interfacing Octave with the [CharJS](https://www.chartjs.org/) JavaScript charting library.  The package is at a very initial development stage and only supports the eight basic chart types of the CharJS library without any support for further [configuration](https://www.chartjs.org/docs/latest/configuration/) and [plugins](https://github.com/chartjs/awesome?tab=readme-ov-file#plugins) usually defined under the `options:` tag in JavaScript code.

The **chartjs** package aims to facilitate the generation of web-ready HTML code for 2D charts through the familiarity of native Octave language. All available chart-specific classdef Classes rely on the parent `Html` classdef for generating CharJS compatible json strings as well as HTML standalone code.  The `webserve` method opens a chart in your web browser, straight from a saved HTML file.

## 2. Documentation
All classdef Classes and their respective methods are documented with [texinfo](https://www.gnu.org/software/texinfo/) format, which can be accessed from the Octave command with the `help` function.  Use dot notation to access the help of a particular method. For example:
```
help BarChart
help BarData.jsonstring
```
To access the documentation of available methods inherited from the `Html` Class, type:
```
help Html.jsonstring
help Html.htmlstring
help Html.htmlsave
help Html.webserve
```
You can also find the entire documentation of the **chartjs** package along with its classdef index at [https://pr0m1th3as.github.io/octave-chartjs/](https://pr0m1th3as.github.io/octave-chartjs/). Alternatively, you can build the online documentation locally using the [`pkg-octave-doc`](https://github.com/gnu-octave/pkg-octave-doc) package. Assuming both packages are installed and loaded, browse to any directory of your choice with *write* permission and run:
```
package_texi2html ("chartjs")
```

## 3. Installation

To install the latest release, you need Octave (>=8.1.0) installed on your system. Install it by typing:

  `pkg install -forge chartjs`

Install the latest dev version from the Octave command prompt by typing 

 `pkg install "https://github.com/pr0m1th3as/octave-chartjs/archive/refs/heads/main.zip"`

## 4. Chart.js

The package bundles [Chart.js](https://www.chartjs.org/) v4.5.1 as `inst/js/chart.umd.min.js`, unchanged from its [npm release](https://www.npmjs.com/package/chart.js/v/4.5.1).  Chart.js is released under the MIT License, Copyright (c) 2014-2024 Chart.js Contributors, and the file keeps its own license notice.

By default, `htmlstring`, `htmlsave`, and `webserve` write this copy into the page, so it opens without a network connection.  Pass `"cdn"` to load the same release from jsDelivr instead, checked against its hash, or a URL to load it from a server that hosts the file.
