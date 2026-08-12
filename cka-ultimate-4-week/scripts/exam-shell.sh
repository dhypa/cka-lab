#!/usr/bin/env bash
set -euo pipefail
alias k=kubectl
source <(kubectl completion bash)
complete -o default -F __start_kubectl k
export KUBE_EDITOR="${KUBE_EDITOR:-vim}"
printf 'host:    '; hostname
printf 'context: '; kubectl config current-context 2>/dev/null || echo '<unavailable>'
printf 'client:  '; kubectl version --client 2>/dev/null | head -1 || true
