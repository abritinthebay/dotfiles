# Change the colors of your Terminal
# Now, let’s learn how we can configure our # Terminal to obtain the colors of the figure.
#
# Terminal custom colors
# Colors can be changed using the LSCOLORS variable in the 
# ~/.bash_profile. By default is set to
#
# LSCOLORS=exfxcxdxbxegedabagacad
#
# where the string exfxcxdxbxegedabagacad is a concatenation of 
# pairs of the format TB, where T is the text color and B is the 
# Background color.
# 
# The order of these pairs correspond to:
# 1. directory
# 2. symbolic link – special kind of file that contains a reference1
#        to another file or directory.
# 3. socket – special kind of file used for inter-process communication.
# 4. pipe – special file that connects the output of one process to the
#        input of another.
# 5. executable
# 6, block special – a kind of device file.
# 7. character special – a kind of device file.
# 8. executable with setuid bit set (setuid is a short for set user ID
#        upon execution).
# 9. executable with setgid bit set (setgid is a short for set group ID
#        upon execution).
# 10. directory writable to others, with sticky bit – only the owner can
#       rename or delete files.
# 11. directory writable to others, without sticky bit – any user with0
#       write and execution permissions can rename or delete files.
#
# And the different letters correspond to:
#   a black
#   b red
#   c green
#   d brown
#   e blue
#   f magenta
#   g cyan
#   h light grey
#   x default color
#
# The same letters in uppercase indicate Bold.
#
# The Terminal default colors, described by exfxcxdxbxegedabagacad, and ordered by file type / text color / background color, are:
# ex –> directory / blue / default
# fx –> symbolic link / magenta / default
# cx –> socket / green / default
# dx –> pipe / brown / default
# bx –> executable / red / default
# eg –> block special / blue / cyan
# ed –> character special / blue / brown
# ab –> executable with setuid / black / red
# ag –> executable without setuid / black / cyan
# ac –> directory with sticky / black / green
# ad –> directory without sticky / black / brown

# Formatting
# Code    Description       Example
# 1       Bold              echo -e "\033[1mBold"
# 2       Dim               echo -e "\033[2mDim"
# 4       Underlined	    echo -e "\033[4mUnderlined"
# 5       Blink             echo -e "\033[5mBlink"
# 7       Reverse/Invert    echo -e "\033[7minverted"
# 8       Hidden            echo -e "\033[8mHidden"
# Reset Formatting
# Code	Description	        Example
# 0	    Reset all           echo -e "\033[0mNormal Text"
# 21    Reset bold          echo -e "\033[1mBold \033[21mNormal"
# 22    Reset dim           echo -e "\033[2mDim \033[22mNormal"
# 24    Reset underlined    echo -e "\033[4mUnderlined \033[24mNormal"
# 25    Reset blink         echo -e "\033[5mBlink \033[25mNormal"
# 27    Reset reverse       echo -e "\033[7minverted \033[27mNormal"
# 28    Reset hidden        echo -e "\033[8mHidden \033[28mNormal"
declare -A __formatCodes=(
	[resetall]=0
	[bold]=1
	[dim]=2
	[underline]=4
	[blink]=5
	[invert]=7
	[hidden]=8
	[resetbold]=21
	[resetdim]=22
	[resetunderline]=24
	[resetblink]=25
	[resetinverse]=27
	[resethidden]=28
);

# Foreground (text)
# Code	Color	        Example
# 39	Default color	echo -e "Default \e[39mDefault"
# 30	Black	        echo -e "Default \e[30mBlack"
# 31	Red	            echo -e "Default \e[31mRed"
# 32	Green	        echo -e "Default \e[32mGreen"
# 33	Yellow	        echo -e "Default \e[33mYellow"
# 34	Blue	        echo -e "Default \e[34mBlue"
# 35	Magenta	        echo -e "Default \e[35mMagenta"
# 36	Cyan	        echo -e "Default \e[36mCyan"
# 37	Light gray	    echo -e "Default \e[37mLight gray"
# 90	Dark gray	    echo -e "Default \e[90mDark gray"
# 91	Light red	    echo -e "Default \e[91mLight red"
# 92	Light green	    echo -e "Default \e[92mLight green"
# 93	Light yellow	echo -e "Default \e[93mLight yellow"
# 94	Light blue	    echo -e "Default \e[94mLight blue"
# 95	Light magenta	echo -e "Default \e[95mLight magenta"
# 96	Light cyan	    echo -e "Default \e[96mLight cyan"
# 97	White	        echo -e "Default \e[97mWhite"
declare -A __fgColors=(
	[black]="30"
	[red]="31"
	[green]="32"
	[yellow]="33"
	[blue]="34"
	[magenta]="35"
	[cyan]="36"
	[lightgrey]="37"
	[default]="39"
	[darkgrey]="90"
	[lightred]="91"
	[lightgreen]="92"
	[lightyellow]="93"
	[lightblue]="94"
	[lightmagenta]="95"
	[lightcyan]="96"
	[white]="97"
);

# Background
# Code	Color	        Example
# 49	Default color	echo -e "Default \e[49mDefault"
# 40	Black	        echo -e "Default \e[40mBlack"
# 41	Red	            echo -e "Default \e[41mRed"
# 42	Green	        echo -e "Default \e[42mGreen"
# 43	Yellow	        echo -e "Default \e[43mYellow"
# 44	Blue	        echo -e "Default \e[44mBlue"
# 45	Magenta	        echo -e "Default \e[45mMagenta"
# 46	Cyan	        echo -e "Default \e[46mCyan"
# 47	Light gray	    echo -e "Default \e[47mLight gray"
# 100	Dark gray	    echo -e "Default \e[100mDark gray"
# 101	Light red	    echo -e "Default \e[101mLight red"
# 102	Light green	    echo -e "Default \e[102mLight green"
# 103	Light yellow    echo -e "Default \e[103mLight yellow"
# 104	Light blue	    echo -e "Default \e[104mLight blue"
# 105	Light magenta   echo -e "Default \e[105mLight magenta"
# 106	Light cyan	    echo -e "Default \e[106mLight cyan"
# 107	White	        echo -e "Default \e[107mWhite"
declare -A __bgColors=(
	[black]="40"
	[red]="41"
	[green]="42"
	[yellow]="43"
	[blue]="44"
	[magenta]="45"
	[cyan]="46"
	[lightgrey]="47"
	[default]="49"
	[darkgrey]="100"
	[lightred]="101"
	[lightgreen]="102"
	[lightyellow]="103"
	[lightblue]="104"
	[lightmagenta]="105"
	[lightcyan]="106"
	[white]="107"
);

function __getFormat () {
	local format="$1"
	if [[ "$format" ]]; then
		local code="${__formatCodes[$format]}";
		if [[ "$code" ]]; then
			echo "$code";
		fi
	fi
}

function fgColor () {
	local color="$1"
	if [[ "$color" ]]; then
		local code="${__fgColors[$color]}";
		if [[ "$code" ]]; then
			echo "$code";
		fi
	fi
}

function bgColor () {
	local color="$1"
	if [[ "$color" ]]; then
		local code="${__bgColors[$color]}";
		if [[ "$code" ]]; then
			echo "$code";
		fi
	fi
}

function colorize() {
	local code="$1";
	local content="$2";
	local term="\002";
	local escape="\001\033[${code}m${term}";
	local reset="\001\033[0m${term}";
	local resultString="${escape}$content${reset}";
	echo "$resultString";
}

function colorcode() {
	local fgColor="$1";
	local bgColor="$2";
	local format="$3";
	local code="";  
	if [[ "$fgColor" ]]; then
		code="$(fgColor "$fgColor")";
	fi
	if [[ "$bgColor" ]]; then
		echo "$bgColor";
		if [[ "$code" ]]; then
			code="$code;$(bgColor "$bgColor")"
		else
			code="$(bgColor "$bgColor")"
		fi
	fi
	if [[ "$format" ]]; then
		if [[ "$code" ]]; then
			code="$code;$(__getFormat "$format")"
		else
			code="$(__getFormat "$format")";
		fi
	fi
	local escape="\001\033[${code}m${term}";
	local resultString="${escape}";
	echo "\[$resultString\]";
}

# paint text
# usage: paint <text> <forground color name> <background color name> <format name>
function paint() {
	local content="$1";
	local fgColor="$2";
	local bgColor="$3";
	local format="$4";
	local code="";
	if [[ "$content" ]]; then
		if [[ "$fgColor" ]]; then
			code="$(fgColor "$fgColor")";
		fi
		if [[ "$bgColor" ]]; then
			if [[ "$code" ]]; then
				code="$code;$(bgColor "$bgColor")"
			else
				code="$(bgColor "$bgColor")"
			fi
		fi
		if [[ "$format" ]]; then
			if [[ "$code" ]]; then
				code="$code;$(__getFormat "$format")"
			else
				code="$(__getFormat "$format")";
			fi
		fi
	fi
	colorize "$code" "$content";
}

# Test Colors & Formatting
# You can have different foreground and background colors as well as different
# formatting. Not all colors or formatting are supported in all terminals.
function __testColors () {
	local clbg;
	local clfg;
	local attr;
	for clbg in {40..47} {100..107} 49 ; do # Background color (if supported)
		for clfg in {30..37} {90..97} 39 ; do # Foreground (if supported)
			for attr in 0 1 2 4 5 7 8; do # Formatting 
				echo -en "\e[${attr};${clbg};${clfg}m\\\e[${attr};${clbg};${clfg}m \e[0m"
			done
		echo;
		done
	done
}

alias bg='bgColor'
alias fg='bgColor'
alias _c='paint'
