# printhelpers
# functions for nicely-formatting text to a terminal

function testInteger {
	[ -n "$1" -a  "$1" -eq "$1" ] 2>/dev/null
}

termWidth() {
	if command stty &>/dev/null; then
		w=$(stty size | cut -d' ' -f2)
	elif command tput &>/dev/null; then
		w=$(tput cols)
	else
		w=60
	fi
	echo $w
}

indent() {
	testInteger $1 || {
		echo >&2 "indent requires number of spaces as the first argument"
		return 1
	}
	space=$1; shift
	maxWidth=$(termWidth) || width=60
	width=$(expr $maxWidth - $space)
	[ $# -gt 0 ] && echo $* | fold -sw $width | pr -to $space
}

function heading {
	indent 2 "\033[1m$*\033[0m"
}

function body {
	while [ $# -gt 0 ]; do
		indent 6 "$1\n"
		shift
	done
}

function option {
	indent 6 $1
	shift
	while [ $# -gt 0 ]; do
		indent 10 "$1\n"
		shift
	done
}

