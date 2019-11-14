function srv_input {
    if [ $# -gt 2 ] || [ $1 == "--help" ] ; then
        echo "USAGE: srv_input HOST:PORT"
        return 1
    fi

    host=$1
    port=$2
    cat <<-EOF | python
import flask
from flask import request

app = flask.Flask("test")

@app.route("/", methods=["GET", "POST"])
def index():
    if request.method == "POST":
        print(request.form["password"])
    return "<form method=POST><input name=password type=password></input><input type=submit value=DONE /></form>"

app.run(host="0.0.0.0", debug=False)
EOF
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
