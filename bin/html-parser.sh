#!/bin/bash
# Input must add '<' otherwise the last tag is missed
parse() {
	while IFS=$'>' read -d $'<' tag text; do
		tag="$(printf '%s' "$tag" | sed -E 's#^ +| +$##g')"
		echo "ent '$tag', text '$text'";
	done
}

if [ -z "$1" ]; then
	text="";
	while read line; do
		text=$text$line;
	done
	(echo "$text"; echo '<') | parse;
else
	(cat "$1"; echo '<') | parse;
fi
