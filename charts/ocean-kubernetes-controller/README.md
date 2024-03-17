# ocean-kubernetes-controller

![Version: 0.1.31](https://img.shields.io/badge/Version-0.1.31-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.0.50](https://img.shields.io/badge/AppVersion-2.0.50-informational?style=flat-square)

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
| autoUpdate.podSecurityContext | object | `{"fsGroup":10001,"runAsGroup":10001,"runAsNonRoot":true,"runAsUser":10001}` | Pod Security Context for the auto-updater job. (Optional) Ref: https://kubernetes.io/docs/concepts/security/pod-security-standards/ |
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
| ocean-metric-exporter | object | `{"affinity":{},"deployChart":false,"image":{"pullPolicy":"IfNotPresent","pullSecrets":[],"repository":"gcr.io/spotinst-artifacts/spot-ocean-metric-exporter","tag":"1.0.4"},"metricsConfiguration":{"allowLabels":null,"allowMetrics":null,"categories":["scaling"],"denyLabels":null,"denyMetrics":null},"nodeSelector":{},"podAnnotations":{},"podEnvVariables":[],"probes":{"enabled":true,"liveness":{"enabled":false,"failureThreshold":3,"initialDelaySeconds":15,"periodSeconds":10,"timeoutSeconds":1},"readiness":{"enabled":false,"failureThreshold":3,"initialDelaySeconds":15,"periodSeconds":10,"successThreshold":1,"timeoutSeconds":1}},"replicaCount":1,"resources":{"limits":{"cpu":"500m","memory":"500Mi"},"requests":{"cpu":"100m","memory":"50Mi"}},"service":{"create":true},"tolerations":[{"key":"node-role.kubernetes.io/master","operator":"Exists"},{"key":"node-role.kubernetes.io/control-plane","operator":"Exists"}]}` | Configurations for Ocean Metric Exporter. |
| ocean-metric-exporter.affinity | Optional | `{}` | Pod scheduling preferences. Ref: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity |
| ocean-metric-exporter.deployChart | bool | `false` | Specifies whether the Ocean Metric Exporter should be deployed. (Optional) |
| ocean-metric-exporter.image.pullPolicy | Optional | `"IfNotPresent"` | Image pull policy. |
| ocean-metric-exporter.image.pullSecrets | Optional | `[]` | Image pull secrets. |
| ocean-metric-exporter.image.repository | Optional | `"gcr.io/spotinst-artifacts/spot-ocean-metric-exporter"` | Image repository. |
| ocean-metric-exporter.image.tag | Optional | `"1.0.4"` | Image tag. Defaults to `.Chart.AppVersion`. |
| ocean-metric-exporter.metricsConfiguration | Optional | `{"allowLabels":null,"allowMetrics":null,"categories":["scaling"],"denyLabels":null,"denyMetrics":null}` | Exporter Metrics Configurations |
| ocean-metric-exporter.metricsConfiguration.allowLabels | Array[string] | `nil` | List of Labels to allow - if empty will get everything. Shouldn't be used with `denyLabels`. Possible values can be found here: https://docs.spot.io/ocean/tools-and-integrations/prometheus/scrape?id=labels |
| ocean-metric-exporter.metricsConfiguration.allowMetrics | Array[string] | `nil` | List of Metrics to allow - if empty will get everything. Shouldn't be used with `denyMetrics`. Possible values can be found here: https://docs.spot.io/ocean/tools-and-integrations/prometheus/scrape?id=metrics |
| ocean-metric-exporter.metricsConfiguration.categories | Array[string] | `["scaling"]` | List of Categories to enable - if empty will get no metrics. Additional possible values can be found here: https://docs.spot.io/ocean/tools-and-integrations/prometheus/scrape?id=categories |
| ocean-metric-exporter.metricsConfiguration.denyLabels | Array[string] | `nil` | List of Labels to deny - if empty will get everything. Shouldn't be used with `allowLabels`. Possible values can be found here: https://docs.spot.io/ocean/tools-and-integrations/prometheus/scrape?id=labels |
| ocean-metric-exporter.metricsConfiguration.denyMetrics | Array[string] | `nil` | List of Metrics to deny - if empty will get everything. Shouldn't be used with `allowMetrics`. Possible values can be found here: https://docs.spot.io/ocean/tools-and-integrations/prometheus/scrape?id=metrics |
| ocean-metric-exporter.nodeSelector | Optional | `{}` | Node selector. |
| ocean-metric-exporter.podAnnotations | Optional | `{}` | Pod annotations. Ref: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/ |
| ocean-metric-exporter.podEnvVariables | Optional | `[]` | Additional environment variables for the exporter container. |
| ocean-metric-exporter.probes.enabled | Bool | `true` | Whether to include both liveness and readiness probe, if this is set to true it will ignore the nested enabled booleans. |
| ocean-metric-exporter.probes.liveness.enabled | Bool | `false` | Whether to include liveness probe, this will be ignored if probes.enabled was set to true. |
| ocean-metric-exporter.probes.liveness.failureThreshold | Integer | `3` | Liveness probe failure threshold. |
| ocean-metric-exporter.probes.liveness.initialDelaySeconds | Integer | `15` | Liveness probe initial delay. |
| ocean-metric-exporter.probes.liveness.periodSeconds | Integer | `10` | Liveness probe period. |
| ocean-metric-exporter.probes.liveness.timeoutSeconds | Integer | `1` | Liveness probe timeout. |
| ocean-metric-exporter.probes.readiness.enabled | Bool | `false` | Whether to include readiness probe, this will be ignored if probes.enabled was set to true. |
| ocean-metric-exporter.probes.readiness.failureThreshold | Integer | `3` | Readiness probe failure threshold. |
| ocean-metric-exporter.probes.readiness.initialDelaySeconds | Integer | `15` | Readiness probe initial delay. |
| ocean-metric-exporter.probes.readiness.periodSeconds | Integer | `10` | Readiness probe period. |
| ocean-metric-exporter.probes.readiness.successThreshold | Integer | `1` | Readiness probe success threshold. |
| ocean-metric-exporter.probes.readiness.timeoutSeconds | Integer | `1` | Readiness probe timeout. |
| ocean-metric-exporter.replicaCount | Optional | `1` | Replicas. Ref: https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#replicas |
| ocean-metric-exporter.resources | Optional | `{"limits":{"cpu":"500m","memory":"500Mi"},"requests":{"cpu":"100m","memory":"50Mi"}}` | Resource requests and limits. Ref: http://kubernetes.io/docs/user-guide/compute-resources/ |
| ocean-metric-exporter.service.create | Optional | `true` | Controls whether a service should be created. |
| ocean-metric-exporter.tolerations | Optional | `[{"key":"node-role.kubernetes.io/master","operator":"Exists"},{"key":"node-role.kubernetes.io/control-plane","operator":"Exists"}]` | Tolerations for nodes that have taints on them. Ref: https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/ |
| ocean-network-client | object | `{"deployChart":false,"image":{"pullPolicy":"IfNotPresent","pullSecrets":[],"repository":"public.ecr.aws/spotinst/spot-network-client","tag":"1.0.6"},"resources":{"requests":{"cpu":"30m","memory":"150Mi"}},"tolerations":[{"operator":"Exists"}]}` | Configurations for Ocean Network Client. |
| ocean-network-client.deployChart | bool | `false` | Specifies whether the Ocean Network Client should be deployed. (Optional) |
| ocean-network-client.image.pullPolicy | Optional | `"IfNotPresent"` | Image pull policy. |
| ocean-network-client.image.pullSecrets | Optional | `[]` | Image pull secrets. |
| ocean-network-client.image.repository | Optional | `"public.ecr.aws/spotinst/spot-network-client"` | Image repository. |
| ocean-network-client.image.tag | Optional | `"1.0.6"` | Image tag. Defaults to `.Chart.AppVersion`. |
| ocean-network-client.resources | Optional | `{"requests":{"cpu":"30m","memory":"150Mi"}}` | Resource requests and limits. Ref: http://kubernetes.io/docs/user-guide/compute-resources/ |
| ocean-network-client.tolerations | Optional | `[{"operator":"Exists"}]` | Tolerations - Enable pods to run an all nodes in cluster Ref: https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/ |
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
| spotinst.disableAutomaticRightSizing | bool | `false` | Disable automatic RightSizing. (Optional) |
| spotinst.enableCsrApproval | bool | `false` | Enable CSR approval. (Optional) |
| spotinst.httpBaseUrl | string | `""` | HTTP Base URL. (Optional) |
| spotinst.proxyUrl | string | `""` | Proxy URL. (Optional) |
| spotinst.token | string | `""` | Spot Token. (Required) Ref: https://docs.spot.io/administration/api/create-api-token |
| tolerations | string | `nil` | Tolerations for nodes that have taints on them. (Optional) Ref: https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/ |
| topologySpreadConstraints | string | `nil` |  |
| updateStrategy | object | `{}` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.13.1](https://github.com/norwoodj/helm-docs/releases/v1.13.1)
