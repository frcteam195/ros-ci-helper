#!/bin/bash
PACKAGE_XML="./package.xml"
DEPENDENCIES=($(grep -oP '(?<=build_depend>)[^<]+' "${PACKAGE_XML}"))

for i in ${!DEPENDENCIES[*]}
do
  echo "$i" "${DEPENDENCIES[$i]}"
  # instead of echo use the values to send emails, etc
done