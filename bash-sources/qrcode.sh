#!/usr/bin/env bash

function qr {
    (
        if [ ! -d /tmp/qr-venv ] ; then
            venv2 /tmp/qr-venv
            . /tmp/qr-venv/bin/activate
            pip install pyqrcode
        else
            . /tmp/qr-venv/bin/activate
        fi
        python <(cat <<EOF
import argparse
import pyqrcode
import sys

parser = argparse.ArgumentParser("qr", "Create qrcodes out of arbitrary data")
parser.add_argument(
    "input",
    nargs="?",
    default=sys.stdin,
    type=argparse.FileType("rb"),
    help="Input data/file (default=stdin)"
)
args = parser.parse_args(sys.argv[1:])

data = args.input.read()
qr = pyqrcode.create(data)
print(qr.terminal())
EOF
        ) "$@"
    )
}
