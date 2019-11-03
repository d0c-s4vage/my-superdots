
function k8s_ns {
    kubectl config set-context $(kubectl config current-context) --namespace="$1"
}

function k8s_tail {
    app="$1"
    for pod in $(kubectl get --no-headers pods -l app="$1" | awk '{print $1}') ; do
        kubectl logs -f --tail=0 "$pod"
    done
}
