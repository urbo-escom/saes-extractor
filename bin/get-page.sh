#!/bin/bash
set +o history
usage() {
[ ! -z "$1" ] && echo "$1"
cat << EOF
usage: $0 (-u | --url) <url> [options]

options:

	If multiple definitions are passed, only the last one will be
	used. It prints to STDOUT

	-u, --url <url>
		Downloaded URL
	-c, --cookies-file <file>
		Save/use cookies in file
	-d, --post-data <string>
		Perform an http post
	-r, --recursive
		Download recursively with no parent
	-i, --insecure
		Disable https confirmation
	-v, --verbose
EOF
}

while [ "$1" != "" ]; do
	case "$1" in
	"-u" | "--url")
		url="$2" && shift ;;
	"-c" | "--cookies-file")
		cookies_file="$2" && shift ;;
	"-d" | "--post-data")
		post_data="$2" && shift ;;
	"-r" | "--recursive")
		recursive=true ;;
	"-i" | "--insecure")
		insecure=true ;;
	"-v" | "--verbose")
		verbose=--verbose ;;
	"*") echo "Unknown option '$1'" 1>&2
	esac
	shift
done

[ -z "$url" ] && usage "No url specified" 1>&2 && exit 1
[ -z "$cookies_file" ] || touch "$cookies_file"

wget \
	${insecure:+--no-check-certificate} \
	${cookies_file:+--keep-session-cookies} \
	${cookies_file:+--save-cookies "$cookies_file"} \
	${cookies_file:+--load-cookies "$cookies_file"} \
	${post_data:+--post-data "$post_data"} \
	${recursive:+--recursive --no-parent -nd -nH} \
	${verbose:---no-verbose} \
	--output-document - \
	"$url"
