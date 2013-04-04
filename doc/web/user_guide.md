# OpenQG User Guide

This document outlines everything you need to know as a user of OpenQG.
If you have problems or questions which are not covered here, please address them to the OpenQG [mailing list](https://groups.google.com/forum/#!forum/openqg-users).

## Downloading OpenQG

### Downloading Stable Releases

The source code of official releases of OpenQG can be downloaded as zip or tar.gz files from the [Downloads page](http://openqg.org/web/downloads).

### Downloading Development Branch

OpenQG uses git for version control, with an official central repository hosted at [GitHub](https://github.com/BreakawayLabs/openqg).
If you want to stay up-to-date with OpenQG development, the recommended way of accessing the OpenQG source is to clone the official repository using git.

#### Installing git

Git can be installed on Debian/Ubuntu systems with the following command.

    sudo apt-get install git

Installation instructions for other platforms can be found on the [git website](http://git-scm.com/)

#### Downloading the source

To get the latest development version of OpenQG, run the following command:

    git clone https://github.com/BreakawayLabs/openqg.git

This will download the development branch into a local repository in the directory `openqg`.
While all efforts are made to ensure the development branch is stable, it is possible that there will be bugs ranging from the minor to the catestrophic.
As such it is not recommended to use the development branch for research unless there is a specfic new feature which is needed.

If you find a problem please check the [task tracker](http://openqg.org/youtrack) to see if it is already known about.
If you cannot find an existing issue which covers your problem, please create a new issue so that the problem can be fixed ASAP.
See the [Reporting Bugs](#bugs) section below.

#### Accessing Annexed Files

The complete distribution of OpenQG includes some large data files used for testing and examples.
To save your bandwidth and keep source code checkouts fast, the data files are managed in a slightly different way to source code files.
For more details on accessing these files, see the [Downloads page](http://openqg.org/web/downloads).

## Dependencies

The main part of OpenQG is written in Fortran 90, using the FFTW, NetCDF and LAPACK libraries.
For setting up runs and processing data, Python is used with the matplotlib and scipy libraries.

For instructions on how to install the necessary packages on Ubuntu, see the [Quickstart Guide](http://openqg.org/web/docs/project/quickstart).

## Compiling OpenQG

OpenQG is written in [Fortran 90](http://en.wikipedia.org/wiki/Fortran#Fortran_90) and distributed in source only form. As such, users must compile the model before running it.

By default OpenQG uses the [`gfortran`](http://gcc.gnu.org/wiki/GFortran) compiler. Version 4.6.3 has been successfully tested, however any recent version should work fine.

To compile the model, run the following commands:

    cd src
    make

This will create the executable file `src/openqg`.

## Running Predefined Example Experiments

OpenQG comes with a number of predefined example experiments.
These can be used as a starting point for customising your own experiments.
It is advised to run a number of these examples to ensure the model is running correctly on your system.

The predefined experiments can run by invoking the `run_model.py` script.
This script takes care of preparing a directory with a number of files that inform the raw OpenQG binary of the setup (number of layers, time step size, resolution, etc.).
The parameters of the expreiment are specified in .ncd (NetCDF) files in this directory. The script then calls the binary with the necessary arguments.

## Experiment Directory Structure

## Running Custom Experiments

## Configuring OpenQG

## Diagnostics

## Advanced Compiler Options

## <a id="bugs"></a>Reporting Bugs
