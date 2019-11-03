#!/bin/sh


function json_pp {
    python <(cat <<EOF
import sys
import json

data = sys.stdin.read()
print(json.dumps(json.loads(data), indent=4))
EOF
)
}
