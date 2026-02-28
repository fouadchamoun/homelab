# External Secrets Operator

External Secrets Operator installed using:

``` bash
helm repo add external-secrets https://charts.external-secrets.io

helm install external-secrets \
   external-secrets/external-secrets \
    -n external-secrets \
    --create-namespace

kubectl create secret generic scw-sm-secret -n external-secrets \
  --from-literal="access-key=<SCWACCESSKEY>" \
  --from-literal="secret-key=<SCWSECRETKEY>"

```
