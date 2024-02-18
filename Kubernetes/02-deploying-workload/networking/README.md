# Networking

## Przygotowanie środowiska

1. Instalacja [MetalLB](https://metallb.universe.tf/)
    * Instalacja MetalLB

    ```bash
    kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.7/config/manifests/metallb-native.yaml

    ```

    * Znalezienie puli adresów IP dla loadbalancera:

    ```bash
    docker network inspect kind -f '{{.IPAM.Config}}'
    ```

    * Modyfikacja konfiguracji i instalacja

    ```bash
    kubectl apply -f metallb-config.yaml
    ```

2. Instalacja Ingress Nginx 
    ```bash
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
    ```

## CNI
https://docs.tigera.io/calico/latest/getting-started/kubernetes/kind

## IPTables
https://www.tkng.io/services/clusterip/dataplane/iptables/

0. Stwórzmy Deployment z kilkoma replikami
1. Wejdz na dowolny węzęł klastra i zweryfikuj reguły sieciowe.

iptables -t nat -nvL KUBE-SERVICES
iptables -t nat -nvL KUBE-SVC-L6225SIXICQL5TGT
