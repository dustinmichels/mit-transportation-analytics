#!/bin/zsh

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'
BAR="----------------------------------------"

out() {
  echo -e "$1${NC}"
}

out "${BLUE}\n${BAR}\nBUILD GRAPH WITH OSM AND GTFS DATA\n${BAR}"
out "${BLUE}\n> java -Xmx8G -jar ~/dev/otp-2.6.0-shaded.jar --build --save .\n"

# alt: otp --build --save .
java -Xmx8G -jar ~/dev/otp-2.6.0-shaded.jar --build --save .
