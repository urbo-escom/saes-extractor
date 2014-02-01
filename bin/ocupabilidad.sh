#!/bin/bash
home="$(cd "$(dirname "$0")"; pwd -P)"
page=https://www.saes.escom.ipn.mx/Academica/Ocupabilidad_grupos.aspx
data="$home/ocupabilidad.post"

[ -z "$1" ] && echo "usage: $0 <cookies-file>" 1>&2 && exit 1

"$home/get-page.sh" \
	--url "$page" --cookies-file "$1" --insecure \
	--post-data "'$(cat "$data" | tr '\n' '&')'"
