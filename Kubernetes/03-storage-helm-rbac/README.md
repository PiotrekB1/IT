# Deploying workload

## Storage - Static Provisioning
1. Zapoznaj się z zawartością pliku `storage/static-pv.yaml`

## Storage - Dynamic Provisioning
1. Zapoznaj się z zawartością pliku `storage/nfs-storage-rwx.yaml`

## Helm
1. Zainstaluj chart [kube-prometheus-stack](https://artifacthub.io/packages/helm/prometheus-community/kube-prometheus-stack)

Dodaj odpowiednie repozytorium i zainstaluj chart w nowym namespace o nazwie `monitoring`.

```bash
helm install k8s-monitoring prometheus-community/kube-prometheus-stack --namespace monitoring --create-namespace
```

2. Zapoznaj się z `values` do tego chart

3. Zmień konfigurację, aby Service `<release>-alertmanager`, i `<release>-kube-promet-prometheus` był stworzony jako NodePort. Zmień hasło administratora do Grafany.

```yaml
alertmanager:
  service:
    type: NodePort

prometheus:
  service:
    type: NodePort

grafana:
  adminPassword: admin123
```

## Przygotowanie Provisionera NFS

### Instalacja Serwera NFS
Do wykonania na naszej VM.
```bash
sudo apt install nfs-kernel-server -y
sudo mkdir -p /opt/nfs-storage
sudo chown -R nobody:nogroup /opt/nfs-storage
sudo chmod 2770 /opt/nfs-storage

echo "/opt/nfs-storage 172.18.0.0/24(rw,sync,no_subtree_check)" | sudo tee -a /etc/exports

sudo exportfs -a
sudo systemctl restart nfs-kernel-server
``` 

### Instalacja Provisionera NFS
```bash
helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner

helm install -n nfs-provisioner --create-namespace nfs-subdir-external-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner --set nfs.server=<addr_ip> --set nfs.path=/opt/nfs-storage
```

## RBAC

### Dodawanie nowego użytkownika
1. Generowanie klucza prywatnego i Certificate Request
    
    ```bash
    openssl genrsa -out jdoe.pem 2048
    openssl req -new -key jdoe.pem -out jdoe.csr -subj "/CN=jdoe/O=developers"
    ```

2. Stworzenie obiektu CertificateSigningRequest na bazie Certificate Request w formacie base64

    ```bash
    cat jdoe.csr | base64 | tr -d "\n"

    cat <<EOF | kubectl apply -f -
    apiVersion: certificates.k8s.io/v1
    kind: CertificateSigningRequest
    metadata:
    name: jdoe-csr
    spec:
    request: <base64-encoded-csr>
    signerName: kubernetes.io/kube-apiserver-client
    usages:
    - digital signature
    - key encipherment
    - client auth
    expirationSeconds: 3600
    EOF
    ```

3. Wyciągnijmy certyfikat podpisany przez kube-apiserver
    ```bash
    kubectl get csr jdoe-csr -ojsonpath='{.status.certificate}' | base64 -d > jdoe.crt
    ```

4. Używając klucza prywatnego (`jdoe.pem`) i publicznego (`jdoe.crt`) możemy uzyskać dostęp do API Kubernetesa:

    Za pomocą `curl`:
    ```bash
    curl -k --key jdoe.pem --cert jdoe.crt https://<api_addr>/api/v1/pods
    ```

    Lub `kubectl`:
    ```bash
    kubectl config set-credentials jdoe --client-key=jdoe.pem --client-certificate=jdoe.crt

    kubectl config set-context --current --user=jdoe
    ```

5. Dodanie ClusterRoleBinding dla grupy `developers`

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: pod-viewer
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list", "watch"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: pod-viewer
subjects:
- kind: User
  name: jdoe
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: pod-viewer
  apiGroup: rbac.authorization.k8s.io

```

6. Zweryfikujmy działanie mechanizmu RBAC za pomocą `kubectl auth can-i`.

    ```bash
    kubectl auth can-i get secrets --as jdoe
    kubectl auth can-i get pods --as jdoe
    ```
