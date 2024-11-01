# Assignment 1 - Memo

```txt
Dustin Michels
1 Nov 2024
11.S956 Public Transportation Analytics and Planning
```

I have investigated the existence of counterproductive or confusing trip suggestions provided by the MBTA trip planner, with special attention given to walking and transfer directions and accessibility concerns.

To do so, I ran a local instance of OpenTripPlanner (OTP) on my machine, based on the configuration provided in the MBTA's [opt-deploy repo](https://github.com/mbta/otp-deploy), and compared the results of a few trip queries to the results provided by the MBTA's trip planner.

## Local OTP configuration

Using the MBTA's [opt-deploy repo](https://github.com/mbta/otp-deploy), I was able to run a local instance of OTP. The only change I made to the provided repository was to update the version of OTP used to the 2.6.0 release.

This configuration utilizes OSM data for Massachusetts and Rhode Island, and GTFS data for the MBTA and Massport.

In `build-config.json`, this instance is [configured to pre-generate wheelchair-accessible transfers](https://docs.opentripplanner.org/en/latest/Accessibility/). OTP should calculate an accessible transfer if the default one is found to be inaccessible to wheelchair users.

In `router-config.json`, there is a setting under `routingDefaults > itineraryFilters` to include an [accessibility score](https://docs.opentripplanner.org/en/latest/RouteRequest/#rd_itineraryFilters) (between 0 and 1) for each leg and itinerary. There is also a setting, `removeItinerariesWithSameRoutesAndStops`, which is set to `true` to remove itineraries that are duplicates of others.

## Case Studies

### (1) MIT to Airport

One trip I looked at was from MIT to the Logan Airport. It provides two trip suggestions, both of which have some counterintuitive elements.

![MIT to Airport](img/trip1_mbta.png)

#### Suggestion A

The first trip suggestion involves taking the Red Line from Kendall/MIT to South Station, then transferring to the Silver Line SL1 to the airport. What is strange is that this trip appears to involve _two_ silver lines.

First you ride the silver line to Terminal A, then ostensibly transfer to a different silver line to go to terminal C. In reality, it should be the same bus the whole time.

![MIT to Airport](img/trip1_silver.png)

The same issue can be seen in the OTP trip suggestion, which provides some additional detail: the first silver line labeled "SL1 Logan Airport" and the second one is labeled "SL1 South Station."

![MIT to Airport](img/trip1_otp.png)

It seems as soon as the bus reaches terminal A the route changes: it is now headed to south station instead of to the airport. This makes sense, since passengers leaving the airport from Terminal A would be seeking a bus headed towards South Station. But it creates confusion if you are headed _to_ Terminal C of the airport, making it appear as if you need to change buses when you don't.
