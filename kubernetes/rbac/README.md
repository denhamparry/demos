# RBAC

## Demo

### Prereqs

- minikube
- kubectl

### Walkthrough

```bash
$ minikube start
```

```bash
$ kubectl create namespace office
```

```bash
$ openssl genrsa -out employee.key 2048
$ openssl req -new -key employee.key -out employee.csr -subj "/CN=employee/O=bitnami"
$ openssl x509 -req -in employee.csr -CA CA_LOCATION/ca.crt -CAkey CA_LOCATION/ca.key -CAcreateserial -out employee.crt -days 500
```

```bash
$ kubectl config set-credentials employee --client-certificate=/home/employee/.certs/employee.crt  --client-key=/home/employee/.certs/employee.key
$ kubectl config set-context employee-context --cluster=minikube --namespace=office --user=employee
$ kubectl --context=employee-context get pods
```

#### Role Creation

```yaml
kind: Role
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  namespace: office
  name: deployment-manager
rules:
- apiGroups: ["", "extensions", "apps"]
  resources: ["deployments", "replicasets", "pods"]
  verbs: ["get", "list", "watch", "create", "update", "patch", "delete"] # You can also use ["*"]
```

```bash
$ kubectl create -f role-deployment-manager.yaml
```

#### Role Binding Creation

```yaml
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: deployment-manager-binding
  namespace: office
subjects:
- kind: User
  name: employee
  apiGroup: ""
roleRef:
  kind: Role
  name: deployment-manager
  apiGroup: ""
```

```bash
$ kubectl create -f rolebinding-deployment-manager.yaml
```

#### Testing RBAC

```bash
kubectl --context=employee-context run --image bitnami/dokuwiki mydokuwiki
kubectl --context=employee-context get pods
```

```bash
kubectl --context=employee-context get pods --namespace=default
```

## References

- [Configure RBAC in your Kubernetes Cluster](https://docs.bitnami.com/tutorials/configure-rbac-in-your-kubernetes-cluster/)
