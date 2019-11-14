
function cscope_files {
	find . -type f \
		-name "*.h.in" -or \
		-name "*.h" -or \
		-name "*.cs" -or \
		-name "*.cpp" -or \
		-name "*.c" -or \
		-name "*.cc" -or \
		-name "*.cxx" -or \
		-name "*.idl" -or \
		-name "*.php" -or \
		-name "*.py" -or \
		-name "*.webidl" \
	>> cscope.files
}

function cscope {
	cscope -Rbkq $*
}

function cscope_refresh {
	cscope_find_db
	(
		cd "$(dirname $cscope_path)"
		rm cscope* tags
		cscope_files
		cscope
		ctags -L cscope.files
	)
}

function cscope_find_db {
	cscope_path="./"
	while true ; do
		if [ "$path" == "./../../../../../../" ] ; then
			cscope_path=""
			break
		fi
		if [ -f $cscope_path''cscope.files ] ; then
			cscope_path=$(readlink -e $cscope_path''cscope.files)
			echo "found cscope at '$cscope_path'"
			break
		fi
		echo "no cscope at '$cscope_path'"
		cscope_path="$cscope_path../"
	done
}
