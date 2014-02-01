#!/bin/bash
clean() {
	# To oneline without unnecessary spaces
	tr '\r\n' ' ' | \
		sed -E 's# +# #g;' | \
		sed -E 's# *< *(/?) *#<\1#g; s# *(/?) *> *#\1>#g' && \
		echo
}

if [ -z "$1" ]; then
	text="";
	while read line; do
		text=$text$line;
	done;
	echo "$text" | clean;
else
	cat "$1" | clean;
fi
