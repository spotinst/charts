# ocean-kubernetes-controller

![Version: 0.1.59-beta.2](https://img.shields.io/badge/Version-0.1.59--beta.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.0.69](https://img.shields.io/badge/AppVersion-2.0.69-informational?style=flat-square)

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
| autoUpdate.image | object | `{"pullPolicy":"Always","repository":"us-docker.pkg.dev/spotit-today/container-labs/auto-updater","tag":"latest"}` | Configures the image for the auto-updater job. (Optional) |
| autoUpdate.image.pullPolicy | string | `"Always"` | Image pull policy. (Optional) |
| autoUpdate.image.repository | string | `"us-docker.pkg.dev/spotit-today/container-labs/auto-updater"` | Image repository. (Optional) |
| autoUpdate.image.tag | string | `"latest"` | Overrides the image tag. (Optional) |
| autoUpdate.imagePullSecrets | list | `[]` | Image pull secrets. (Optional) |
| autoUpdate.podSecurityContext | object | `{"fsGroup":1000690000,"runAsGroup":1000690000,"runAsNonRoot":true,"runAsUser":1000690000}` | Pod Security Context for the auto-updater job. (Optional) Ref: https://kubernetes.io/docs/concepts/security/pod-security-standards/ |
| autoUpdate.priorityClassName | string | `"system-cluster-critical"` | Priority class name for the auto-updater job. Defaults to the same priority class as the controller to prevent eviction. (Optional) |
| autoUpdate.resources | object | `{"limits":{"cpu":"100m","memory":"256Mi"},"requests":{"cpu":"100m","memory":"256Mi"}}` | Resource requests and limits for the auto-updater job. Defaults to 100m CPU and 256Mi memory to make the job run with 'Guranteed' QoS. (Optional) |
| autoUpdate.securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"readOnlyRootFilesystem":true,"runAsNonRoot":true}` | Security Context for the auto-updater container. (Optional) |
| autoUpdate.serviceAccount.annotations | object | `{}` |  |
| autoUpdate.serviceAccount.create | bool | `true` |  |
| autoUpdate.serviceAccount.name | string | `""` |  |
| caBundleSecret.create | bool | `false` | Controls whether a CA bundle secret should be created. |
| caBundleSecret.data | string | `""` | Must contain the CA bundle data in case `caBundleSecret.create` is true. For example by using `--set caBundleSecret.data="$(cat ./ca.pem)"` |
| caBundleSecret.key | string | `"userEnvCertificates.pem"` | Key inside the secret to inject the CA bundle from |
| caBundleSecret.name | string | `""` | CA bundle Secret name. (Optional) |
| command | list | `[]` |  |
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
| image.tag | string | `"feature-con-28708-drainv2@sha256:6370e517c4f683a7af2b44f328dd43926d9b57e9f15d9439e82268c913d67e2c"` |  |
| imagePullSecrets | list | `[]` |  |
| initContainers | list | `[]` |  |
| livenessProbe.httpGet.path | string | `"/healthz"` |  |
| livenessProbe.httpGet.port | string | `"readiness"` |  |
| livenessProbe.initialDelaySeconds | int | `15` |  |
| livenessProbe.periodSeconds | int | `20` |  |
| logShipping | object | `{"command":["/fluent-bit/bin/fluent-bit","-c","/tmp/fluent-bit.conf","-q"],"destination":{"host":"api.spotinst.io","port":443,"tls":true},"enabled":true,"extraEnv":[],"extraVolumeMounts":[],"image":{"pullPolicy":"IfNotPresent","repository":"ghcr.io/fluent/fluent-bit","tag":"3.1.9"}}` | Log Shipping configuration. |
| logShipping.destination | object | `{"host":"api.spotinst.io","port":443,"tls":true}` | Log shipping destination configuration. |
| logShipping.enabled | bool | `true` | Specifies whether to send the controller logs to Spot for analysis. (Optional) |
| logShipping.image | object | `{"pullPolicy":"IfNotPresent","repository":"ghcr.io/fluent/fluent-bit","tag":"3.1.9"}` | Specifies the log shipping container image. (Optional) |
| metrics-server.args | list | `["--logtostderr"]` | Arguments to pass to metrics-server on start up. (Optional) |
| metrics-server.deployChart | bool | `true` | Specifies whether the metrics-server chart should be deployed. (Optional) |
| metrics-server.image.pullPolicy | string | `"IfNotPresent"` |  |
| metrics-server.image.repository | string | `"registry.k8s.io/metrics-server/metrics-server"` |  |
| metrics-server.image.tag | string | `""` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| podSecurityContext.fsGroup | int | `1000690000` |  |
| podSecurityContext.runAsGroup | int | `1000690000` |  |
| podSecurityContext.runAsNonRoot | bool | `true` |  |
| podSecurityContext.runAsUser | int | `1000690000` |  |
| priorityClassName | string | `"system-node-critical"` | Priority class name for the controller pod. |
| readinessProbe.httpGet.path | string | `"/readyz"` |  |
| readinessProbe.httpGet.port | string | `"readiness"` |  |
| readinessProbe.initialDelaySeconds | int | `5` |  |
| readinessProbe.periodSeconds | int | `10` |  |
| replicas | int | `2` | Configure the amount of replicas for the controller (Optional) |
| resourceQuota | object | `{"enabled":true}` | Resource Quota configuration. Required when running in a namespace other than kube-system in GKE. Ref: https://kubernetes.io/docs/concepts/policy/resource-quotas/ |
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
| spotinst.disableAutomaticRightSizing | bool | `false` | Disable automatic RightSizing. (Optional) |
| spotinst.enableCsrApproval | bool | `true` | Enable CSR approval. (Optional) |
| spotinst.proxyUrl | string | `""` | Proxy URL. (Optional) |
| spotinst.token | string | `""` | Spot Token. (Required) Ref: https://docs.spot.io/administration/api/create-api-token |
| tolerations | string | `nil` | Tolerations for nodes that have taints on them. (Optional) Ref: https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/ |
| topologySpreadConstraints | string | `nil` |  |
| updateStrategy | object | `{}` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.13.1](https://github.com/norwoodj/helm-docs/releases/v1.13.1)
