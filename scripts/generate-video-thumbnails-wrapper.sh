#!/usr/bin/env bash

XURLMIN=$MOZPERFAX/bin/moz-perf-x-transform-url.exe
XTHUMBNAILS=../../scripts/generate_video_thumbnails_standalone.py

CHROMEDIR=chrome_release
FIREFOXDIR=fenix_nightly

ODIR=tmp
if [ ! -d tmp ]; then
    mkdir $ODIR
fi

# assume data layout as
# results/2024-11-10/chrome_release,fenix_nightly/[minified-url].[json | mp4]
generate_platform_by_sitelist() {
    PLATFORM="$1"
    SITELIST="$2"
    ISODATE="$3"

   for i in `cat ${SITELIST}`
   do
       URLM=`${XURLMIN} "$i"`
       TPLATFORM="${PLATFORM}-${URLM}"
       ARTIFACT_BASE="$ISODATE-$TPLATFORM";

       echo "$i"
       echo "$URLM"

       FFV="${ODIR}/${ARTIFACT_BASE}-firefox.mp4"
       $XTHUMBNAILS $FFV
       
       CV="${ODIR}/${ARTIFACT_BASE}-chrome.mp4"
       $XTHUMBNAILS $CV
   done

}

generate_platform_by_sitelist "android" "../sitelist.txt" "2024-11-10"
