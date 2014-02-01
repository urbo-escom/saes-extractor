#!/bin/bash
set +o history
[ -z "$1" ] && echo "usage: $0 <cookies-file>" 1>&2 && exit 1

home="$(cd "$(dirname "$0")"; pwd -P)"
page=https://www.saes.escom.ipn.mx/Default.aspx
data="$home/login.post"
cookies_file="${1:-./cookies.txt}"

printf "Enter UserName: "
stty_orig=`stty -g` && stty -echo
read user 
stty $stty_orig && echo

printf  "Enter Password: "
stty_orig=`stty -g` && stty -echo 
read passwd 
stty $stty_orig && echo

"$home/get-page.sh" \
	--url "$page" --cookies-file "$cookies_file" --insecure \
	--post-data "'$(cat "$data" | \
			sed -E "s|(UserName=)|\1$user|" | \
			sed -E "s|(Password=)|\1$passwd|" | tr '\n' '&')'" \
	1>/dev/null
