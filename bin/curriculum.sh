#!/bin/bash
home="$(cd "$(dirname "$0")"; pwd -P)"
page=https://www.saes.escom.ipn.mx/Academica/mapa_curricular.aspx
data="$home/curriculum.post"
planes="09" # 99 plan only works from 1 to 5 (there are 8)
periodos="1 2 3 4 5"

[ -z "$1" ] && echo "usage: $0 <cookies-file>" 1>&2 && exit 1

# 99 plan doesn't work on 6 7 and 8
for plan in $planes; do
	for periodo in $periodos; do
		echo "Downloading $plan-$periodo" 1>&2;
		"$home/get-page.sh" \
			--url "$page" \
			--cookies-file "$1" --insecure \
			--post-data "'$(cat "$data" | \
				sed -E "s|(cboPlanEstud=)|\1$plan|" | \
				sed -E "s|(NoPeriodos=)|\1$periodo|" | \
				 tr '\n' '&')'";
	done
done
