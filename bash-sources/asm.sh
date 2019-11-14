function disasm {
    file="$1"
    start="$2"
    end="$3"

    python -c "import sys ; f = open('$file', 'rb') ; f.seek($start) ; sys.stdout.write(f.read($end-$start+1))" | ndisasm -p intel -b32 -
}
