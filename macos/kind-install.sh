curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.32.0/kind-linux-arm64

chmod u+x ./kind
mkdir -p ~/bin && mv ./kind ~/bin
