#!/bin/bash

export PACKAGE_XML="${1:-package.xml}"
export SKIP_FILE="${2}"
export SKIP_LIST=$(curl -sL https://raw.githubusercontent.com/frcteam195/ros-ci-helper/main/skip_packages.txt)
clone_dependency()
{
	if [ $# -gt 0 ]; then
		if [[ "${SKIP_FILE}" == "" ]]; then
			if [[ ! $(echo "${SKIP_LIST}" | grep -F "${1}") ]]; then
				git clone --recurse-submodules -j4 "https://github.com/frcteam195/${1}.git"
			fi
		else
			if [[ ! $(grep -F "${1}" "${SKIP_FILE}") ]]; then
                                git clone --recurse-submodules -j4 "https://github.com/frcteam195/${1}.git"
                        fi
		fi
	fi
}
export -f clone_dependency

xmllint --xpath "//package/build_depend/text()" "${PACKAGE_XML}" | xargs -P 4 -I {} bash -c "clone_dependency {}"
xmllint --xpath "//package/depend/text()" "${PACKAGE_XML}" | xargs -P 4 -I {} bash -c "clone_dependency {}"
