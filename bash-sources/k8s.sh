
function k8s_install_kubectl {
	curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
	mv kubectl ~/.local/bin
	chmod u+x ~/.local/bin/kubectl
}

function k8s_install_minikube {
	curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
	mv minikube-linux-amd64 ~/.local/bin/minikube
	chmod u+x ~/.local/bin/minikube
}

function k8s_ns {
    kubectl config set-context $(kubectl config current-context) --namespace="$1"
}

function k8s_tail {
    app="$1"
    for pod in $(kubectl get --no-headers pods -l app="$1" | awk '{print $1}') ; do
        kubectl logs -f --tail=0 "$pod"
    done
}