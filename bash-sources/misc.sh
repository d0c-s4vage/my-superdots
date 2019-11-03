function g__rand_str {
	echo _RAND_STR_$1_ | python -c 'import sys,re,random,string;data=sys.stdin.read();sys.stdout.write(re.sub(r"_RAND_STR_(\d+)_", lambda x: "".join(random.choice(string.ascii_letters + string.digits) for n in xrange(int(x.group(1)))), data))'
}

function cd {
    pushd "$@" >/dev/null
}

function back {
    popd >/dev/null
}

function md {
    mkdir -p "$1" ; cd "$1";
}
