# Talos setup with Talhelper

## Generate secrets (only once per cluster)

```bash
➜ talhelper gensecret > talsecret.sops.yaml
```

## Generate config

```bash
➜ talhelper genconfig
generated config for talos-cp-00 in ./clusterconfig/fouadflix-talos-talos-cp-00.yaml
generated config for talos-cp-01 in ./clusterconfig/fouadflix-talos-talos-cp-01.yaml
generated config for talos-cp-02 in ./clusterconfig/fouadflix-talos-talos-cp-02.yaml
generated client config in ./clusterconfig/talosconfig
generated .gitignore file in ./clusterconfig/.gitignore
```

## Generate "apply" commands

```bash
➜ talhelper gencommand apply
talosctl apply-config --talosconfig=./clusterconfig/talosconfig --nodes=192.168.200.60 --file=./clusterconfig/fouadflix-talos-talos-cp-00.yaml;
talosctl apply-config --talosconfig=./clusterconfig/talosconfig --nodes=192.168.200.61 --file=./clusterconfig/fouadflix-talos-talos-cp-01.yaml;
talosctl apply-config --talosconfig=./clusterconfig/talosconfig --nodes=192.168.200.62 --file=./clusterconfig/fouadflix-talos-talos-cp-02.yaml;
```

## Apply first node

```bash
➜ talosctl apply-config --talosconfig=./clusterconfig/talosconfig --nodes=192.168.200.60 --file=./clusterconfig/fouadflix-talos-talos-cp-00.yaml;
```

## Bootstrap cluster with first node only

```bash
➜ talhelper gencommand bootstrap
talosctl bootstrap --talosconfig=./clusterconfig/talosconfig --nodes=192.168.200.60;
```

## Apply second node and wait for it to join cluster

```bash
➜ talosctl apply-config --talosconfig=./clusterconfig/talosconfig --nodes=192.168.200.61 --file=./clusterconfig/fouadflix-talos-talos-cp-01.yaml;
```

## Apply third node and wait for it to join cluster

```bash
➜ talosctl apply-config --talosconfig=./clusterconfig/talosconfig --nodes=192.168.200.62 --file=./clusterconfig/fouadflix-talos-talos-cp-02.yaml;
```

## Get kubeconfig

```bash
➜ talhelper gencommand kubeconfig
talosctl kubeconfig --talosconfig=./clusterconfig/talosconfig --nodes=192.168.200.60;
```

## How to reset a node

```bash
➜ talosctl reset -n talos-cp-00 --reboot --system-labels-to-wipe STATE --system-labels-to-wipe EPHEMERAL
```
