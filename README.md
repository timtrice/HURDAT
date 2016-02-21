[![Travis-CI Build Status](https://travis-ci.org/timtrice/Hurricanes.svg?branch=master)](https://travis-ci.org/timtrice/Hurricanes)

# README

## Introduction

This R package currently aims to reorganize the NOAA HURDAT2 dataset for Atlantic, East Pacific and Central Pacific-basin tropical cyclones and present it in a cleaner format.

The Atlantic basin dataset covers all cyclones that have developed in the Atlantic Ocean. The eastern Pacific datasets cover cyclones in the Pacifc from the United States/Mexico coastlines to -140&deg;W where the cyclone entered what is referred to as the central Pacific basin. The central Pacific basin extends westward to -180&deg;W.

There are some instances where a storm will cross basins (from the Atlantic to the Pacific or vice versa). Per the [National Oceanic and Atmospheric Administration](http://www.noaa.gov)'s [Hurricane Research Division](http://www.aoml.noaa.gov/hrd/) [FAQ](http://www.aoml.noaa.gov/hrd/tcfaq/tcfaqHED.html), [Subject B5](http://www.aoml.noaa.gov/hrd/tcfaq/B5.html):

> The rule used to be that if the tropical storm or hurricane moved into a different basin, then it was renamed to whatever name was next on the list for the area.

At this time, *used to be* is not clarified or unknown.

### Named Cyclones

Cyclones were not named until 1950 and used names of the international phonetic alphabet. For example, Able, Baker, Charlie, etc.

In 1953, the [National Hurricane Center (NHC)](http://www.nhc.noaa.gov) began using female names and by 1954 the NHC would retire some names for storms of significance. Currently the [World Meteorological Organization](http://www.wmo.int/pages/prog/www/tcp/Storm-naming.html) is responsible for maintaining the list of names, retiring names and assigning replacement names.

In this dataset, cyclones not named are simply referred to as "UNNAMED". To aid with identification, cyclones will be referenced by their `Key`, a string of alphanumeric characters identifying basin, the number of the storm for the year, followed by the four-digit year.

For example, *AL011851*:

* AL = Atlantic Basin (`Basin`)

* 01 = First storm of the year (`YearNum`)

* 1851 = Year of the storm (`Year`)

### Meteorological Definitions

It is useful to understand definitions and classifications of tropical cyclones.

- Cyclone: a system of winds rotating inward to an area of low pressure. This system rotates counter-clockwise in the northern hemisphere and clockwise in the southern hemisphere.

- Tropical depression: a tropical cyclone with winds less than 35 mph (34 kts).

- Tropical storm: a tropical  with winds between 35 mph (34 kts) but less than 74mph (64 kts).

- Hurricane: a tropical cyclone with winds greater than 74 mph (64 kts).

- Extratropical Cyclone: a cyclone no longer containing tropical characteristics (warm-core center, tight pressure gradient near the center)

- Subtropical Cyclone: a cyclone containing a mix of tropical and non-tropical characteristics.

- Tropical cyclone: a warm-core surface low pressure system

- Tropical Wave: An open area of low pressure (trough) containing tropical characteristics

- Disturbance: An area of disturbed weather; a large disorganized area of thunderstorms.

### Saffir Simpson Hurricane Scale

Cyclones are classified by their rating within the [Saffir-Simpson Hurricane Scale](https://en.wikipedia.org/wiki/Saffir%E2%80%93Simpson_hurricane_wind_scale) as follows:

Category | Winds
-------- | ------
TD       | 0-38 mph (0-33 kts)
TS       | 39-73 mph (34-64 kts)
1        | 74-95 mph (65-83 kts)
2        | 96-110 mph (84-95 kts)
3        | 111-129 mph (96-113 kts)
4        | 130-156 mph (114-134 kts)
5        | >156 mph (>134 kts)

A "major hurricane" is that a category three or higher.

## Error Reporting

Please submit any errors, discrepancies or issues through the [github/hurricanes](https://github.com/timtrice/Hurricanes/issues) repository.

Errors in the raw data may also be reported to Chris Landsea or the National Hurricane Center Best Track Change Committee [as explained on the HRD website](http://www.aoml.noaa.gov/hrd/hurdat/submit_re-analysis.html).
