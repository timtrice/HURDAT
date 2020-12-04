## HURDAT v0.2.3.2
================

## Test environments

* local Ubunto 20 install, R 3.6.3
* win-builder.r-project.org R 4.0.3
* win-builder.r-project.org R development
* win-builder.r-project.org R 3.6.3

## R CMD check results

There are no ERRORs or WARNINGs or NOTEs.

winbuilder give a NOTE regarding the Author field. 

> * checking CRAN incoming feasibility ... NOTE
>   Maintainer: 'Tim Trice '
> New submission
> 
> Package was archived on CRAN

Package errors were not corrected in a timely fashion and removed from CRAN. 
This release resolves those errors.

## HURDAT v0.2.3
================

## Test environments

### Local (Ubuntu 18.04)
* R 3.6.1

### Remote (Travis-CI Ubuntu 14.05)
* R devel
* R release
* R oldrelease

### Remote (Appveyor i386-w64-mingw32/i386 (32-bit))
* R 3.5.3
* R devel
* R patched

## R CMD check results

There are no ERRORs or WARNINGs or NOTEs.

winbuilder and r_hub give a NOTE regarding the Author field. 

> * checking CRAN incoming feasibility ... NOTE
>   Maintainer: 'Tim Trice '

This field has not changed from any previous submittal. This NOTE was not 
raised on previous submittals. As I understand it, this is a reminder to 
validate the maintainer field. Therefore, it is validated.

## HURDAT v0.2.0
================

## Test environments

### Local (Ubuntu 18.04)
* R 3.4.4

### Remote (Travis-CI Ubuntu 14.05)
* R release
* r devel

### Remote (Appveyor i386-w64-mingw32/i386 (32-bit))
* R-devel
* R-release

## R CMD check results

There are no ERRORs or WARNINGs or NOTEs.

## HURDAT v0.2.0
================

## Resubmission

This is a resubmission. In this version I have:

* incorporated the MIT license and template per the link given (https://www.r-project.org/Licenses/MIT) along with using guidance from other approved packages. Modified the contents of LICENSE and added LICENSE.md

* I have updated the package Title in DESCRIPTION 

* Non-requested change: I modified the Description tag in DESCRIPTION.

* Changed roles in Description:
  + Tim Trice is author as defined in ?persons
  + Chris Landsea is author, creator and data contributer as defined in ?persons.

* Added link to dataset project in DESCRIPTION Description.

* Corrected cre tag from Chris Landsea to Tim Trice; Landsea does not work directly on this package.

* Put Description url in angle brackets.

## Test environments
* local ubuntu 16.04 , R 3.4.0
* ubuntu 12.04 (on travis-ci), R 3.4.0
* win-builder (devel and release)

## R CMD check results

There are no ERRORs or WARNINGs or NOTEs.
