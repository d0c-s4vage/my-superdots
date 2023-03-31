function srv_input {
    if [ $# -gt 2 ] || [ "$1" == "--help" ] ; then
        echo "USAGE: srv_input HOST:PORT"
        return 1
    fi

    (
        rm -rf /tmp/srv_input_venv
        venv3 /tmp/srv_input_venv >/dev/null 2>&1
        pip install flask >/dev/null 2>&1

        host=${1:-"0.0.0.0"}
        port=${2:-"8080"}
        cat <<-EOF | python
import flask
import signal
from flask import request
import flask.cli
import logging
import os
import sys

# flask.cli.show_server_banner = lambda *args: None
# log = logging.getLogger('werkzeug')
# log.disabled = True
# log.setLevel(logging.ERROR)

app = flask.Flask("test")


def quit():
    os.kill(os.getpid(), signal.SIGKILL)

@app.route("/", methods=["GET", "POST"])
def index() -> str:
    if request.method == "POST":
        if request.form.get("password") != "":
            sys.stdout.write(request.form["password"])
            sys.stdout.flush()
            quit()
        elif "file" in request.files:
            print("Writing file data to stdout")
            sys.stdout.buffer.write(request.files["file"].read())
            sys.stdout.flush()

    return """
        <form method=POST enctype=multipart/form-data>
            <input name=password type=password>
            <br/>
            <input name=file type=file>
            <br/>
            <input type=submit value=DONE />
            <br/>
        </form>
    """

app.run(host=${host@Q}, port=${port@Q}, debug=False)
EOF
    )
}

function srv_nginx {
    tmpdir=$(tempfile)
    rm "$tmpdir" && mkdir -p "$tmpdir"
    (
        cd "$tmpdir"
        cat <<-EOF > default.conf
server {
    listen       80;
    server_name  localhost;

    location / {
        root   /usr/share/nginx/html;
        autoindex on;
    }

    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}
EOF
    )
    CMD=(
        docker run
            --rm
            -p 0.0.0.0:8080:80
            -v "$tmpdir":/etc/nginx/conf.d/
            -v $(pwd):/usr/share/nginx/html:ro
            nginx
    )
    "${CMD[@]}"
    rm -rf "$tmpdir"
}

function previewmd {
	(
		sleep 0.5
		xdg-open http://localhost:8080/
	) &
    # https://github.com/joeyespo/grip
	grip --user-content $1 8080
}

function expandurl {
	wget -S --spider --no-check-certificate "$1" 2>&1 | grep ^Location
}
