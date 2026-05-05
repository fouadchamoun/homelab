# Talos

## Get kubeconfig

```bash
➜ talhelper gencommand kubeconfig
talosctl kubeconfig --talosconfig=./clusterconfig/talosconfig --nodes=192.168.200.60;
```

## How to reset a node

```bash
➜ talosctl reset -n talos-cp-00 --reboot --system-labels-to-wipe STATE --system-labels-to-wipe EPHEMERAL
```
