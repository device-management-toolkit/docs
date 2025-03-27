# Enabling KUMA Service Mesh (Optional)

For enhancing security in the Kubernetes deployment, use KUMA Service Mesh to enable mTLS between services. To learn more about KUMA visit their [documentation](https://kuma.io/docs/).


## Install KUMA w/ Helm

Follow the instructions for [installing KUMA with helm](https://kuma.io/docs/1.2.3/installation/helm/).

## Create Service Mesh

After KUMA is installed, next create a service mesh with mTLS enabled:

``` bash
echo "apiVersion: kuma.io/v1alpha1
kind: Mesh
metadata: 
  name: open-amt-cloud-toolkit-mesh
spec: 
  mtls: 
    enabledBackend: open-amt-cloud-toolkit-cert
    backends: 
      - name: open-amt-cloud-toolkit-cert
        type: builtin
    enabled: true" | kubectl apply -f -
```

## Turn On Sidecar Injection

After the mesh is created, turn on sidecar-injection for the open-amt-cloud-toolkit services with: 

``` bash
echo "apiVersion: v1
kind: Namespace
metadata: 
  name: default
  namespace: default
  annotations: 
    kuma.io/sidecar-injection: enabled
    kuma.io/mesh: open-amt-cloud-toolkit-mesh" | kubectl apply -f -
```

Delete all pods to ensure updated annotations from previous command take effect:

``` bash
kubectl delete pod --all -n default
```

## Configure Traffic Permissions

Finally, we need to allow traffic between services:

``` bash
echo "apiVersion: kuma.io/v1alpha1
kind: TrafficPermission
mesh: open-amt-cloud-toolkit-mesh
metadata:
  namespace: default
  name: allow-all-open-amt-cloud-toolkit-mesh
spec:
  sources:
    - match:
        kuma.io/service: '*'
  destinations:
    - match:
        kuma.io/service: '*'" | kubectl apply -f -
```

After applying traffic permissions, you should now be able to use the Device Management Toolkit and continue logging into the web portal following the setup instructions in the [Getting Started section](../../../GetStarted/Cloud/loginToUI.md).
