#!/bin/bash

foralldir() {
	COMMAND=$@
	if [ ${#@} -lt 1 ]; then
    	echo "No command entered! Please enter a command to run!"
		return;
	fi
	echo "Running $COMMAND"
	find . -maxdepth 1 -type d \( ! -name . \) | grep -v \\./\\. | xargs -I {} bash -c "cd '{}' && echo && echo {} && $COMMAND";
}

foralldir "make -j4 || true"