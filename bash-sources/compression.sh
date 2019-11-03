#!/usr/bin/env bash

function zlib {
    python <(cat <<EOF
import argparse
import binascii
import re
import sys
import zlib

parser = argparse.ArgumentParser("zlib", "Decompress/compress data using zlib")
parser.add_argument(
    "-c",
    "--compress",
    action="store_true",
    default=False,
    help="Compress the input data using zlib"
)
parser.add_argument(
    "-f",
    "--find",
    action="store_true",
    default=False,
    help="Find zlib compressed data"
)
parser.add_argument(
    "-H",
    "--hex",
    action="store_true",
    default=False,
    help="Input data is in hex format"
)
parser.add_argument(
    "-r",
    "--repr",
    action="store_true",
    default=False,
    help="Input data is in repr format (string with escapes for chars)"
)
parser.add_argument(
    "input",
    nargs="?",
    default=sys.stdin,
    type=argparse.FileType("rb"),
    help="Input data/file (default=stdin)"
)
parser.add_argument(
    "-o",
    "--output",
    nargs="?",
    default=sys.stdout,
    type=argparse.FileType("wb"),
    help="Output data/file (default=stdout)"
)

args = parser.parse_args(sys.argv[1:])

data = args.input.read()

if args.repr:
    data = data.strip()
    if data.startswith("'"):
        data = data[1:-1]
    data = data.decode("string_escape")

elif args.hex:
    # strip out all whitespace
    data = re.sub(r'\s', '', data)
    data = binascii.unhexlify(data)

if args.compress:
    args.output.write(zlib.compress(data))
    exit(0)

if args.find:
    found_data = False
    for idx in xrange(len(data)):
        try:
            ddata = zlib.decompress(data[idx:])
            sys.stderr.write("Found zlib data at offset 0x{:x}\n".format(idx))
            args.output.write(ddata)
            found_data = True
            break
        except:
            pass

    if not found_data:
        sys.stderr.write("No zlib data found\n")
        exit(1)

    exit(0)

args.output.write(zlib.decompress(data))

EOF
    ) "$@"
}


function hex {
    python <(cat <<EOF
import argparse
import binascii
import sys

parser = argparse.ArgumentParser("hex", "[De]Convert data <-> hex")
parser.add_argument(
    "-d",
    "--dehex",
    action="store_true",
    default=False,
    help="Convert a hex string to raw binary data"
)
parser.add_argument(
    "-r",
    "--repr",
    action="store_true",
    default=False,
    help="Output data in repr format"
)
parser.add_argument(
    "input",
    nargs="?",
    default=sys.stdin,
    type=argparse.FileType("rb"),
    help="Input data/file (default=stdin)"
)
parser.add_argument(
    "-o",
    "--output",
    nargs="?",
    default=sys.stdout,
    type=argparse.FileType("wb"),
    help="Output data/file (default=stdout)"
)
args = parser.parse_args(sys.argv[1:])
data = args.input.read()

if sys.stdin.isatty() and data.endswith("\n"):
    data = data[:-1]

if args.dehex:
    try:
        res = binascii.unhexlify(data)
    except:
        print("Could not unhexlify data")
        exit()

else:
    res = binascii.hexlify(data)

if args.repr:
    res = repr(res)

args.output.write(res)
EOF
    ) "$@"
}
