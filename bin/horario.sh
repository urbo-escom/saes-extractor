#!/bin/bash
home="$(cd "$(dirname "$0")"; pwd -P)"
page=https://www.saes.escom.ipn.mx/Academica/horarios.aspx
data="$home/horario.post"
turnos="M V"
periodos="1 2 3 4 5"

[ -z "$1" ] && echo "usage: $0 <cookies-file>" 1>&2 && exit 1

for turno in $turnos; do
	for periodo in $periodos; do
		echo "Downloading $turno-$periodo" 1>&2;
		"$home/get-page.sh" \
			--url "$page" \
			--cookies-file "$1" --insecure \
			--post-data "'$(cat "$data" | \
				sed -E "s|(cboTurno=)|\1$turno|" | \
				sed -E "s|(Periodos=)|\1$periodo|" | \
				 tr '\n' '&')'";
	done
done
