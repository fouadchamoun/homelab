# Kube-vip

Kube-vip installed using:

``` bash
kubectl apply -f https://kube-vip.io/manifests/rbac.yaml
kubectl apply -f https://raw.githubusercontent.com/kube-vip/kube-vip-cloud-provider/main/manifest/kube-vip-cloud-controller.yaml
docker run --network host --rm ghcr.io/kube-vip/kube-vip:v1.0.4 \
  manifest daemonset --inCluster --taint \
  --arp --leaderElection --enableLoadBalancer \
  --controlplane --interface lo --address 192.168.200.70 \
  --services

```
