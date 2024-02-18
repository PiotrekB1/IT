# Intro

## Przygotowanie środowiska
1. Instalacja `kind`

    https://kind.sigs.k8s.io/docs/user/quick-start/#installing-from-release-binaries

2. Instalacja `kubectl`

    https://kubernetes.io/docs/tasks/tools/#kubectl

3. Stworzenie klastra

    ```bash
    kind create cluster --name test --config ./kind-config.yaml
    ```

## HAProxy
1. docker cp ha-external-load-balancer:/usr/local/etc/haproxy/haproxy.cfg ./


## API Server
1. Wykonaj exec do węzła control-plane
2. Zapoznaj się z plikiem `/etc/kubernetes/manifests/kube-apiserver.yaml`

### Metody dostepu do apiservera
- kubectl
- dashboard
- curl - podac parametry `--key` i `--cert`
- nc/openssl - `openssl s_client -connect <ADDR>:<PORT>``


## Scheduler
1. Wykonaj exec do węzła control-plane
2. Zapoznaj się z plikiem `/etc/kubernetes/manifests/kube-scheduler.yaml`

## Controller Manager
1. Wykonaj exec do węzła control-plane
2. Zapoznaj się z plikiem `/etc/kubernetes/manifests/kube-controller-manager.yaml`
3. Popsuj `kube-controller-manager` - na przykład usuń kontroler od obiektu deployment - dodaj w odpowiednim miejscu linię `-deployment`
4. Zweryfikuj, że deployment nie zadziała

## ETCD
1. Wykonaj exec do węzła control-plane
2. Zapoznaj się z plikiem `/etc/kubernetes/manifests/kube-controller-manager.yaml`
3. Interakcja z ETCD

```bash
ETCDCTL_API=3 etcdctl --endpoints=<ADRES_IP>:2379 \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  member list

ETCDCTL_API=3 etcdctl --endpoints=<ADRES_IP>:2379 \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  get /registry/pods/kube-system/kube-
```

4. Usuńmy jakiś obiekt z etcd i zaobserwujmy co się z nim stanie
```bash
kubectl create deployment -n default test-me --image=nginx

# w ETCD
ETCDCTL_API=3 etcdctl --endpoints=<ADRES_IP>:2379 \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  del /registry/deployments/default/test-me
```


## Kubelet + Containerd
Pause container - ctr -n k8s.io container ls
ctr -n k8s.io task metric <ID> - porównaj z resources w podzie
ctr -n k8s.io container info <ID> - sprawdźmy resources i namespace
ps -He

## Dashboard
0. Stwórzmy użytkownika z uprawnieniami cluster-admin
```bash
kubectl apply -f admin-user.yaml
```
1. Zainstaluj dashboard
```bash
kubectl apply -f dashboard.yaml
```

2. Przekieruj porty do serwisu dashboard
```bash
kubectl port-forward -n kubernetes-dashboard svc/kubernetes-dashboard 8443:443 
```

3. Wygenerujmy token
```bash
kubectl create token -n kube-system admin
```