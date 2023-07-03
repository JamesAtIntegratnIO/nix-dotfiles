```shell
# add the repo
helm repo add metallb https://metallb.github.io/metallb

# install the chart
helm --namespace metallb-system install --create-namespace metallb metallb/metallb

# install the crds
kubectl apply -f crds
```
