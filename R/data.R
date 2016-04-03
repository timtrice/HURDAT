#' Atlantic Summary
#'
#' Summary information on each Atlantic cyclone.
#'
#' @format A dataframe with nine variables.
#' \describe{
#'      \item{\code{Key}}{Unique key identifying the tropical cyclone.
#'          Formatted like AABBCCCC where AA is Basin, BB is YearNum and CC is
#'          Year}
#'      \item{\code{Observations}}{Number of observations for the storm.}
#'      \item{\code{StartDate}}{Date/time of first recorded observation (UTC)}
#'      \item{\code{EndDate}}{Date/time of last recorded observation (UTC)}
#'      \item{\code{YearNum}}{The number of the storm for the year}
#'      \item{\code{Year}}{Year of the storm}
#'      \item{\code{Name}}{Name of the storm (UNNAMED for early storms)}
#'      \item{\code{MaxWind}}{Maximum recorded wind in knots}
#'      \item{\code{MinPressure}}{Minimum central pressure in millibars}
#' }
#'
#' This dataframe is the parent data frame for \code{AL_details} and
#'      \code{AL_wind_radius}. Key exists in all child frames to tie the data
#'      frames together.
#'
"AL_summary"

#' Atlantic Details
#'
#' Detailed observations for each storm.
#'
#' @format A dataframe with eight variables.
#' \describe{
#'      \item{\code{Key}}{Unique key identifying the tropical cyclone.
#'          Formatted like AABBCCCC where AA is Basin, BB is YearNum and CC is
#'          Year}
#'      \item{\code{Datetime}}{Date/time of the observation}
#'      \item{\code{Record}}{Record identifier:
#'          \describe{
#'              \item{\code{C}}{Closest approach to a coast, not followed
#'                  by a landfall.}
#'              \item{\code{G}}{Genesis.}
#'              \item{\code{I}}{An intensity peak in terms of both pressure
#'                  and wind.}
#'              \item{\code{L}}{Landfall (center of system crossing a
#'                  coastline).}
#'              \item{\code{P}}{Minimum central pressure.}
#'              \item{\code{R}}{Provides additional detail on the intensity
#'                  of the cyclone when rapid changes are underway.}
#'              \item{\code{S}}{Change of status of the system.}
#'              \item{\code{T}}{Provides additional detail on the track.}
#'              \item{\code{W}}{Maximum sustained wind speed.}
#'          }
#'      }
#'      \item{\code{Status}}{Status of the system:
#'          \describe{
#'              \item{\code{TD}}{Tropical depression (winds < 34 kts)}
#'              \item{\code{TS}}{Tropical storm (winds 34-63 kts)}
#'              \item{\code{HU}}{Hurricane (winds >= 64 kts)}
#'              \item{\code{EX}}{Extratropical cyclone of any intensity}
#'              \item{\code{SD}}{Subtropical cyclone of subtropical depression
#'                  intensity (winds < 34 kts).}
#'              \item{\code{SS}}{Subtroipcal cyclone of subtropical cyclone
#'                  intensity (winds >= 34 kts)}
#'              \item{\code{LO}}{A low that is neither a tropical cyclone,
#'                  subtropical cyclone nor extratropical of any intensity.}
#'              \item{\code{WV}}{Tropical wave}
#'              \item{\code{DB}}{Tropical disturbance}
#'          }
#'      }
#'      \item{\code{Latitude}}{Latitude position; >0 for northern hemisphere,
#'          <0 for southern hemisphere.}
#'      \item{\code{Longitude}}{Longitude position; >0 for eastern hemisphere,
#'          <0 for western hemisphere.}
#'      \item{\code{Wind}}{Recorded or estimated wind speed in knots}
#'      \item{\code{Pressure}}{Recorded or estimated central pressure in
#'          millibars}
#' }
#'
#' Use Key to tie this dataframe to its parent data frame. Use Key and
#'      Datetime to tie to sibling data frames.
#'
"AL_details"

#' Atlantic Wind Radius
#'
#' Recorded wind radius data for each observation, where available. This
#'      data frame is substantially smaller than its sibling "details" data
#'      frame because many storms simply had no data. Where there is a record
#'      means at least one of the wind radius variables have an integer value.
#'
#' @format A data frame of 14 variables
#' \describe{
#'      \item{\code{Key}}{Unique key identifying the tropical cyclone.
#'          Formatted like AABBCCCC where AA is Basin, BB is YearNum and CC is
#'          Year}
#'      \item{\code{Datetime}}{Date/time of the observation}
#'      \item{\code{WindRadii34NE}}{Expansion of winds > 34 kts in the
#'          northeastern quadrant.}
#'      \item{\code{WindRadii34SE}}{Expansion of winds > 34 kts in the
#'          southeastern quadrant.}
#'      \item{\code{WindRadii34SW}}{Expansion of winds > 34 kts in the
#'          southwestern quadrant.}
#'      \item{\code{WindRadii34NW}}{Expansion of winds > 34 kts in the
#'          northwestern quadrant.}
#'      \item{\code{WindRadii50NE}}{Expansion of winds > 50 kts in the
#'          northeastern quadrant.}
#'      \item{\code{WindRadii50SE}}{Expansion of winds > 50 kts in the
#'          southeastern quadrant.}
#'      \item{\code{WindRadii50SW}}{Expansion of winds > 50 kts in the
#'          southwestern quadrant.}
#'      \item{\code{WindRadii50NW}}{Expansion of winds > 50 kts in the
#'          northwestern quadrant.}
#'      \item{\code{WindRadii64NE}}{Expansion of winds > 64 kts in the
#'          northeastern quadrant.}
#'      \item{\code{WindRadii64SE}}{Expansion of winds > 64 kts in the
#'          southeastern quadrant.}
#'      \item{\code{WindRadii64SW}}{Expansion of winds > 64 kts in the
#'          southwestern quadrant.}
#'      \item{\code{WindRadii64NW}}{Expansion of winds > 64 kts in the
#'          northwestern quadrant.}
#' }
#'
#' Use Key to tie this dataframe to its parent data frame. Use Key and
#'      Datetime to tie to sibling data frames.
#'
"AL_wind_radius"

#' East Pacific Summary
#'
#' Summary information on each East Pacific cyclone.
#'
#' @format A dataframe with nine variables:
#' \describe{
#'      \item{\code{Key}}{Unique key identifying the tropical cyclone.
#'          Formatted like AABBCCCC where AA is Basin, BB is YearNum and CC is
#'          Year}
#'      \item{\code{Records}}{Number of records for the storm.}
#'      \item{\code{StartDate}}{Date/time of first recorded observation (UTC)}
#'      \item{\code{EndDate}}{Date/time of last recorded observation (UTC)}
#'      \item{\code{YearNum}}{The number of the storm for the year}
#'      \item{\code{Year}}{Year of the storm}
#'      \item{\code{Name}}{Name of the storm (UNNAMED for early storms)}
#'      \item{\code{MaxWind}}{Maximum recorded wind in knots}
#'      \item{\code{MinPressure}}{Minimum central pressure in millibars}
#' }
#'
#' This dataframe is the parent data frame for EP_details and EP_wind_radius.
#'      Key exists in all child frames to tie the data frames together.
#'
"EP_summary"

#' Atlantic Details
#'
#' Detailed observations for each storm.
#'
#' @format A dataframe with eight variables.
#' \describe{
#'      \item{\code{Key}}{Unique key identifying the tropical cyclone.
#'          Formatted like AABBCCCC where AA is Basin, BB is YearNum and CC is
#'          Year}
#'      \item{\code{Datetime}}{Date/time of the observation}
#'      \item{\code{Record}}{Record identifier:
#'          \describe{
#'              \item{\code{C}}{Closest approach to a coast, not followed
#'                  by a landfall.}
#'              \item{\code{G}}{Genesis.}
#'              \item{\code{I}}{An intensity peak in terms of both pressure
#'                  and wind.}
#'              \item{\code{L}}{Landfall (center of system crossing a
#'                  coastline).}
#'              \item{\code{P}}{Minimum central pressure.}
#'              \item{\code{R}}{Provides additional detail on the intensity
#'                  of the cyclone when rapid changes are underway.}
#'              \item{\code{S}}{Change of status of the system.}
#'              \item{\code{T}}{Provides additional detail on the track.}
#'              \item{\code{W}}{Maximum sustained wind speed.}
#'          }
#'      }
#'      \item{\code{Status}}{Status of the system:
#'          \describe{
#'              \item{\code{TD}}{Tropical depression (winds < 34 kts)}
#'              \item{\code{TS}}{Tropical storm (winds 34-63 kts)}
#'              \item{\code{HU}}{Hurricane (winds >= 64 kts)}
#'              \item{\code{EX}}{Extratropical cyclone of any intensity}
#'              \item{\code{SD}}{Subtropical cyclone of subtropical depression
#'                  intensity (winds < 34 kts).}
#'              \item{\code{SS}}{Subtroipcal cyclone of subtropical cyclone
#'                  intensity (winds >= 34 kts)}
#'              \item{\code{LO}}{A low that is neither a tropical cyclone,
#'                  subtropical cyclone nor extratropical of any intensity.}
#'              \item{\code{WV}}{Tropical wave}
#'              \item{\code{DB}}{Tropical disturbance}
#'          }
#'      }
#'      \item{\code{Latitude}}{Latitude position; >0 for northern hemisphere,
#'          <0 for southern hemisphere.}
#'      \item{\code{Longitude}}{Longitude position; >0 for eastern hemisphere,
#'          <0 for western hemisphere.}
#'      \item{\code{Wind}}{Recorded or estimated wind speed in knots}
#'      \item{\code{Pressure}}{Recorded or estimated central pressure in
#'          millibars}
#' }
#'
#' Use Key to tie this dataframe to its parent data frame. Use Key and
#'      Datetime to tie to sibling data frames.
#'
"EP_details"

#' East Pacific Wind Radius
#'
#' Recorded wind radius data for each observation, where available. This
#'      data frame is substantially smaller than its sibling "details" data
#'      frame because many storms simply had no data. Where there is a record
#'      means at least one of the wind radius variables have an integer value.
#'
#' @format A data frame of 14 variables
#' \describe{
#'      \item{\code{Key}}{Unique key identifying the tropical cyclone.
#'          Formatted like AABBCCCC where AA is Basin, BB is YearNum and CC is
#'          Year}
#'      \item{\code{Datetime}}{Date/time of the observation}
#'      \item{\code{WindRadii34NE}}{Expansion of winds > 34 kts in the
#'          northeastern quadrant.}
#'      \item{\code{WindRadii34SE}}{Expansion of winds > 34 kts in the
#'          southeastern quadrant.}
#'      \item{\code{WindRadii34SW}}{Expansion of winds > 34 kts in the
#'          southwestern quadrant.}
#'      \item{\code{WindRadii34NW}}{Expansion of winds > 34 kts in the
#'          northwestern quadrant.}
#'      \item{\code{WindRadii50NE}}{Expansion of winds > 50 kts in the
#'          northeastern quadrant.}
#'      \item{\code{WindRadii50SE}}{Expansion of winds > 50 kts in the
#'          southeastern quadrant.}
#'      \item{\code{WindRadii50SW}}{Expansion of winds > 50 kts in the
#'          southwestern quadrant.}
#'      \item{\code{WindRadii50NW}}{Expansion of winds > 50 kts in the
#'          northwestern quadrant.}
#'      \item{\code{WindRadii64NE}}{Expansion of winds > 64 kts in the
#'          northeastern quadrant.}
#'      \item{\code{WindRadii64SE}}{Expansion of winds > 64 kts in the
#'          southeastern quadrant.}
#'      \item{\code{WindRadii64SW}}{Expansion of winds > 64 kts in the
#'          southwestern quadrant.}
#'      \item{\code{WindRadii64NW}}{Expansion of winds > 64 kts in the
#'          northwestern quadrant.}
#' }
#'
#' Use Key to tie this dataframe to its parent data frame. Use Key and
#'      Datetime to tie to sibling data frames.
#'
"EP_wind_radius"

#' Central Pacific Summary
#'
#' Summary information on each Central Pacific cyclone.
#'
#' @format A dataframe with nine variables:
#' \describe{
#'      \item{\code{Key}}{Unique key identifying the tropical cyclone.
#'          Formatted like AABBCCCC where AA is Basin, BB is YearNum and CC is
#'          Year}
#'      \item{\code{Records}}{Number of records for the storm.}
#'      \item{\code{StartDate}}{Date/time of first recorded observation (UTC)}
#'      \item{\code{EndDate}}{Date/time of last recorded observation (UTC)}
#'      \item{\code{YearNum}}{The number of the storm for the year}
#'      \item{\code{Year}}{Year of the storm}
#'      \item{\code{Name}}{Name of the storm (UNNAMED for early storms)}
#'      \item{\code{MaxWind}}{Maximum recorded wind in knots}
#'      \item{\code{MinPressure}}{Minimum central pressure in millibars}
#' }
#'
#' This dataframe is the parent data frame for CP_details and CP_wind_radius.
#'      Key exists in all child frames to tie the data frames together.
#'
"CP_summary"

#' Atlantic Details
#'
#' Detailed observations for each storm.
#'
#' @format A dataframe with eight variables.
#' \describe{
#'      \item{\code{Key}}{Unique key identifying the tropical cyclone.
#'          Formatted like AABBCCCC where AA is Basin, BB is YearNum and CC is
#'          Year}
#'      \item{\code{Datetime}}{Date/time of the observation}
#'      \item{\code{Record}}{Record identifier:
#'          \describe{
#'              \item{\code{C}}{Closest approach to a coast, not followed
#'                  by a landfall.}
#'              \item{\code{G}}{Genesis.}
#'              \item{\code{I}}{An intensity peak in terms of both pressure
#'                  and wind.}
#'              \item{\code{L}}{Landfall (center of system crossing a
#'                  coastline).}
#'              \item{\code{P}}{Minimum central pressure.}
#'              \item{\code{R}}{Provides additional detail on the intensity
#'                  of the cyclone when rapid changes are underway.}
#'              \item{\code{S}}{Change of status of the system.}
#'              \item{\code{T}}{Provides additional detail on the track.}
#'              \item{\code{W}}{Maximum sustained wind speed.}
#'          }
#'      }
#'      \item{\code{Status}}{Status of the system:
#'          \describe{
#'              \item{\code{TD}}{Tropical dCPression (winds < 34 kts)}
#'              \item{\code{TS}}{Tropical storm (winds 34-63 kts)}
#'              \item{\code{HU}}{Hurricane (winds >= 64 kts)}
#'              \item{\code{EX}}{Extratropical cyclone of any intensity}
#'              \item{\code{SD}}{Subtropical cyclone of subtropical dCPression
#'                  intensity (winds < 34 kts).}
#'              \item{\code{SS}}{Subtroipcal cyclone of subtropical cyclone
#'                  intensity (winds >= 34 kts)}
#'              \item{\code{LO}}{A low that is neither a tropical cyclone,
#'                  subtropical cyclone nor extratropical of any intensity.}
#'              \item{\code{WV}}{Tropical wave}
#'              \item{\code{DB}}{Tropical disturbance}
#'          }
#'      }
#'      \item{\code{Latitude}}{Latitude position; >0 for northern hemisphere,
#'          <0 for southern hemisphere.}
#'      \item{\code{Longitude}}{Longitude position; >0 for eastern hemisphere,
#'          <0 for western hemisphere.}
#'      \item{\code{Wind}}{Recorded or estimated wind speed in knots}
#'      \item{\code{Pressure}}{Recorded or estimated central pressure in
#'          millibars}
#' }
#'
#' Use Key to tie this dataframe to its parent data frame. Use Key and
#'      Datetime to tie to sibling data frames.
#'
"CP_details"

#' Central Pacific Wind Radius
#'
#' Recorded wind radius data for each observation, where available. This
#'      data frame is substantially smaller than its sibling "details" data
#'      frame because many storms simply had no data. Where there is a record
#'      means at least one of the wind radius variables have an integer value.
#'
#' @format A data frame of 14 variables
#' \describe{
#'      \item{\code{Key}}{Unique key identifying the tropical cyclone.
#'          Formatted like AABBCCCC where AA is Basin, BB is YearNum and CC is
#'          Year}
#'      \item{\code{Datetime}}{Date/time of the observation}
#'      \item{\code{WindRadii34NE}}{Expansion of winds > 34 kts in the
#'          northeastern quadrant.}
#'      \item{\code{WindRadii34SE}}{Expansion of winds > 34 kts in the
#'          southeastern quadrant.}
#'      \item{\code{WindRadii34SW}}{Expansion of winds > 34 kts in the
#'          southwestern quadrant.}
#'      \item{\code{WindRadii34NW}}{Expansion of winds > 34 kts in the
#'          northwestern quadrant.}
#'      \item{\code{WindRadii50NE}}{Expansion of winds > 50 kts in the
#'          northeastern quadrant.}
#'      \item{\code{WindRadii50SE}}{Expansion of winds > 50 kts in the
#'          southeastern quadrant.}
#'      \item{\code{WindRadii50SW}}{Expansion of winds > 50 kts in the
#'          southwestern quadrant.}
#'      \item{\code{WindRadii50NW}}{Expansion of winds > 50 kts in the
#'          northwestern quadrant.}
#'      \item{\code{WindRadii64NE}}{Expansion of winds > 64 kts in the
#'          northeastern quadrant.}
#'      \item{\code{WindRadii64SE}}{Expansion of winds > 64 kts in the
#'          southeastern quadrant.}
#'      \item{\code{WindRadii64SW}}{Expansion of winds > 64 kts in the
#'          southwestern quadrant.}
#'      \item{\code{WindRadii64NW}}{Expansion of winds > 64 kts in the
#'          northwestern quadrant.}
#' }
#'
#' Use Key to tie this dataframe to its parent data frame. Use Key and
#'      Datetime to tie to sibling data frames.
#'
"CP_wind_radius"
