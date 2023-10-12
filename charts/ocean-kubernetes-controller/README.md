# ocean-kubernetes-controller

![Version: 0.1.4](https://img.shields.io/badge/Version-0.1.4-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.0.19](https://img.shields.io/badge/AppVersion-2.0.19-informational?style=flat-square)

A Helm chart for Ocean Kubernetes Controller.

## Installation

1. Add the Spot Helm chart repository:

```sh
helm repo add spot https://charts.spot.io
```

2. Update your local Helm chart repository cache:

```sh
helm repo update
```

3. Install `ocean-kubernetes-controller`:

```sh
helm install spot spot/ocean-kubernetes-controller \
  --set spotinst.account=$SPOTINST_ACCOUNT \
  --set spotinst.clusterIdentifier=$SPOTINST_CLUSTER_IDENTIFIER \
  --set spotinst.token=$SPOTINST_TOKEN
```

> NOTE: Please configure all required chart values using the `set` command line argument or a `values.yaml` file.

## Installation With HTTPS Proxy

In case you need to configure a proxy with a custom CA bundle you should use the following:

```sh
helm install spot spot/ocean-kubernetes-controller \
  --set spotinst.account=$SPOTINST_ACCOUNT \
  --set spotinst.clusterIdentifier=$SPOTINST_CLUSTER_IDENTIFIER \
  --set spotinst.token=$SPOTINST_TOKEN \
  --set spotinst.proxyUrl=$SPOTINST_PROXY_URL \
  --set caBundleSecret.create=true \
  --set caBundleSecret.data="$(cat ./path/to/ca.pem)"
```

If you already have a CA bundle secret you can instead use:

```sh
helm install spot spot/ocean-kubernetes-controller \
  --set spotinst.account=$SPOTINST_ACCOUNT \
  --set spotinst.clusterIdentifier=$SPOTINST_CLUSTER_IDENTIFIER \
  --set spotinst.token=$SPOTINST_TOKEN \
  --set spotinst.proxyUrl=$SPOTINST_PROXY_URL \
  --set caBundleSecret.name=my-ca-bundle-secret \
  --set caBundleSecret.key=bundle.pem
```

## Requirements

Kubernetes: `>=1.20.0-0`

| Repository | Name | Version |
|------------|------|---------|
| https://kubernetes-sigs.github.io/metrics-server | metrics-server | 3.11.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | string | `nil` |  |
| args | list | `[]` |  |
| caBundleSecret.create | bool | `false` | Controls whether a CA bundle secret should be created. |
| caBundleSecret.data | string | `""` | Must contain the CA bundle data in case `caBundleSecret.create` is true. For example by using `--set caBundleSecret.data="$(cat ./ca.pem)"` |
| caBundleSecret.key | string | `"userEnvCertificates.pem"` | Key inside the secret to inject the CA bundle from |
| caBundleSecret.name | string | `""` | CA bundle Secret name. (Optional) |
| commonLabels | object | `{}` |  |
| configMap.create | bool | `true` |  |
| configMap.name | string | `""` | ConfigMap name. (Optional) |
| deploymentAnnotations | object | `{}` |  |
| extraEnv | list | `[]` |  |
| extraVolumeMounts | list | `[]` |  |
| extraVolumes | list | `[]` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"us-docker.pkg.dev/spotit-today/container-labs/spotinst-kubernetes-controller"` |  |
| image.tag | string | `""` |  |
| imagePullSecrets | list | `[]` |  |
| livenessProbe.httpGet.path | string | `"/healthz"` |  |
| livenessProbe.httpGet.port | string | `"readiness"` |  |
| livenessProbe.initialDelaySeconds | int | `15` |  |
| livenessProbe.periodSeconds | int | `20` |  |
| metrics-server.args | list | `["--logtostderr"]` | Arguments to pass to metrics-server on start up. (Optional) |
| metrics-server.deployChart | bool | `true` | Specifies whether the metrics-server chart should be deployed. (Optional) |
| metrics-server.image.pullPolicy | string | `"IfNotPresent"` |  |
| metrics-server.image.repository | string | `"registry.k8s.io/metrics-server/metrics-server"` |  |
| metrics-server.image.tag | string | `""` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| podSecurityContext.fsGroup | int | `10001` |  |
| podSecurityContext.runAsGroup | int | `10001` |  |
| podSecurityContext.runAsNonRoot | bool | `true` |  |
| podSecurityContext.runAsUser | int | `10001` |  |
| priorityClassName | string | `"system-cluster-critical"` |  |
| readinessProbe.httpGet.path | string | `"/readyz"` |  |
| readinessProbe.httpGet.port | string | `"readiness"` |  |
| readinessProbe.initialDelaySeconds | int | `5` |  |
| readinessProbe.periodSeconds | int | `10` |  |
| replicas | int | `2` | Configure the amount of replicas for the controller (Optional) |
| resources | object | `{}` |  |
| schedulerName | string | `""` |  |
| secret.create | bool | `true` | Controls whether a Secret should be created. (Optional) |
| secret.name | string | `""` | Secret name. (Optional) |
| securityContext.allowPrivilegeEscalation | bool | `false` |  |
| securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| securityContext.readOnlyRootFilesystem | bool | `true` |  |
| securityContext.runAsNonRoot | bool | `true` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| spotinst.account | string | `""` | Spot Account. (Required) Ref: https://docs.spot.io/administration/organizations?id=account |
| spotinst.baseUrl | string | `""` | Base URL. (Optional) |
| spotinst.clusterIdentifier | string | `""` | Unique identifier used by the Ocean Controller to connect (Required) between the Ocean backend and the Kubernetes cluster. Ref: https://docs.spot.io/ocean/tutorials/spot-kubernetes-controller/ |
| spotinst.disableAutoUpdate | bool | `false` | Disable auto update. (Optional) |
| spotinst.enableCsrApproval | bool | `false` | Enable CSR approval. (Optional) |
| spotinst.proxyUrl | string | `""` | Proxy URL. (Optional) |
| spotinst.token | string | `""` | Spot Token. (Required) Ref: https://docs.spot.io/administration/api/create-api-token |
| tolerations | string | `nil` | Tolerations for nodes that have taints on them. (Optional) Ref: https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/ |
| topologySpreadConstraints | string | `nil` |  |
| updateStrategy | object | `{}` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.2](https://github.com/norwoodj/helm-docs/releases/v1.11.2)