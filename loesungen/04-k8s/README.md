# Kubernetes Sample

To use K8s locally, simply install [Minikube](https://minikube.sigs.k8s.io/docs/start/).

Then, create a namespace (project) where all K8s resources are grouped:

```bash
kubectl create namespace schulung
```

## Open Dashboard

Minikube has a Kubernetes Dashboard where you can find the resources in the Browser UI. Just run

```bash
minikube addons enable dashboard
minikube dashboard
```

## Install Database

Use the following commands:

```bash
# create deployment (=deploy db service)
kubectl apply -f db-deployment.yaml -n schulung
# check for pods
kubectl get pods -n schulung
# show details about the pod
kubectl describe pod postgres-xxxxx -n schulung
# show logs
kubectl logs pods/postgres-xxxxx -n schulung
# create service (=static IP + service name = host name) for database
kubectl apply -f db-service.yaml -n schulung
# show services
kubectl get svc -n schulung
```

> [!NOTE]
> For details, see the [YAML Docs](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/deployment-v1/).

## Install Application

Use the following commands:

```bash
kubectl apply -f app-deployment.yaml -n schulung
# analyze the same way...
kubectl get pods -n schulung
# create service (static IP)
kubectl apply -f app-service.yaml -n schulung
```

## Public Access to Application

We can make the application public by using different solutions.

### Use minikube command

```bash
minikube service myapp-service -n schulung
```

### Port forwarding

Simply start port forwarding on a local development machine:

```bash
kubectl port-forward svc/myapp-service 8080:80 -n schulung
curl http://localhost:8080/hello -i
```

### Ingress (prod style)

In production, we use an Ingress controller.
In Minikube, we need to enable an addon for this.

```bash
minikube addons enable ingress
```

Then, create the ingress:

```bash
kubectl apply -f app-ingress.yaml -n schulung
# analyze
kubectl get ingress -n schulung
# you need to add an entry to /etc/hosts file (local DNS resolving)
grep -q "myapp.local" /etc/hosts || echo "$(minikube ip) myapp.local" | sudo tee -a /etc/hosts
```

Then, we can open the app in the browser with `http://localhost/container-schulung/hello`

> [!NOTE]
> Wenn Du im Kubernetes-Cluster testen möchtest (z.B. `curl` auf die POD.- oder Service-IP), dann verwende `kubectl run tmp --rm -it --image=curlimages/curl -n schulung -- sh`.
