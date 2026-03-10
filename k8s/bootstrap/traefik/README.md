# Traefik

Traefik installed using:

``` bash
helm upgrade --install cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.19 \
  --set crds.enabled=true \
  --set "extraArgs={--enable-gateway-api,--dns01-recursive-nameservers-only,--dns01-recursive-nameservers=1.1.1.1:53\,1.0.0.1:53}"

helm upgrade --install -f values.yaml traefik traefik/traefik \
  --namespace traefik \
  --create-namespace \
  --version 39.0.2
```
