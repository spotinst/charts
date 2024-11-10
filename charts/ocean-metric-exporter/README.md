# ocean-metric-exporter

![Version: 1.1.0](https://img.shields.io/badge/Version-1.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.4](https://img.shields.io/badge/AppVersion-1.0.4-informational?style=flat-square)

A Helm chart for Ocean Metric Exporter.

## Installation

1. Add the Spot Helm chart repository:

```sh
helm repo add spot https://charts.spot.io
```

2. Update your local Helm chart repository cache:

```sh
helm repo update
```

3. Install `ocean-metric-exporter`:

```sh
helm install my-release spot/ocean-metric-exporter
```

> NOTE: Please configure all required chart values using the `set` command line argument or a `values.yaml` file.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | Optional | `{}` | Pod scheduling preferences. Ref: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity |
| caBundleSecret.create | bool | `false` | Controls whether a CA bundle secret should be created. |
| caBundleSecret.data | string | `""` | Must contain the CA bundle data in case `caBundleSecret.create` is true. For example by using `--set caBundleSecret.data="$(cat ./ca.pem)"` |
| caBundleSecret.key | string | `"userEnvCertificates.pem"` | Key inside the secret to inject the CA bundle from |
| caBundleSecret.name | string | `""` | CA bundle Secret name. (Optional) |
| configMapName | Optional | `""` | ConfigMap name to use. In case spotinst.clusterIdentifier is provided, this overrides the name of the created configMap. |
| image.pullPolicy | Optional | `"IfNotPresent"` | Image pull policy. |
| image.pullSecrets | Optional | `[]` | Image pull secrets. |
| image.repository | Optional | `"gcr.io/spotinst-artifacts/spot-ocean-metric-exporter"` | Image repository. |
| image.tag | Optional | `""` | Image tag. Defaults to `.Chart.AppVersion`. |
| metricsConfiguration | Optional | `{"allowLabels":null,"allowMetrics":null,"categories":["scaling"],"denyLabels":null,"denyMetrics":null}` | Exporter Metrics Configurations |
| metricsConfiguration.allowLabels | Array[string] | `nil` | List of Labels to allow - if empty will get everything. Shouldn't be used with `denyLabels`. Possible values can be found here: https://docs.spot.io/ocean/tools-and-integrations/prometheus/scrape?id=labels |
| metricsConfiguration.allowMetrics | Array[string] | `nil` | List of Metrics to allow - if empty will get everything. Shouldn't be used with `denyMetrics`. Possible values can be found here: https://docs.spot.io/ocean/tools-and-integrations/prometheus/scrape?id=metrics |
| metricsConfiguration.categories | Array[string] | `["scaling"]` | List of Categories to enable - if empty will get no metrics. Additional possible values can be found here: https://docs.spot.io/ocean/tools-and-integrations/prometheus/scrape?id=categories |
| metricsConfiguration.denyLabels | Array[string] | `nil` | List of Labels to deny - if empty will get everything. Shouldn't be used with `allowLabels`. Possible values can be found here: https://docs.spot.io/ocean/tools-and-integrations/prometheus/scrape?id=labels |
| metricsConfiguration.denyMetrics | Array[string] | `nil` | List of Metrics to deny - if empty will get everything. Shouldn't be used with `allowMetrics`. Possible values can be found here: https://docs.spot.io/ocean/tools-and-integrations/prometheus/scrape?id=metrics |
| nodeSelector | Optional | `{}` | Node selector. |
| oceanController | object | `{"caBundleSecretName":"","configMapName":"","namespace":"","secretName":""}` | Reference secret and configMap for the Ocean Controller. Deprecated in favor of spotinst object or secretName and configMapName |
| podAnnotations | Optional | `{}` | Pod annotations. Ref: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/ |
| podEnvVariables | Optional | `[]` | Additional environment variables for the exporter container. |
| probes.enabled | Bool | `true` | Whether to include both liveness and readiness probe, if this is set to true it will ignore the nested enabled booleans. |
| probes.liveness.enabled | Bool | `false` | Whether to include liveness probe, this will be ignored if probes.enabled was set to true. |
| probes.liveness.failureThreshold | Integer | `3` | Liveness probe failure threshold. |
| probes.liveness.initialDelaySeconds | Integer | `15` | Liveness probe initial delay. |
| probes.liveness.periodSeconds | Integer | `10` | Liveness probe period. |
| probes.liveness.timeoutSeconds | Integer | `1` | Liveness probe timeout. |
| probes.readiness.enabled | Bool | `false` | Whether to include readiness probe, this will be ignored if probes.enabled was set to true. |
| probes.readiness.failureThreshold | Integer | `3` | Readiness probe failure threshold. |
| probes.readiness.initialDelaySeconds | Integer | `15` | Readiness probe initial delay. |
| probes.readiness.periodSeconds | Integer | `10` | Readiness probe period. |
| probes.readiness.successThreshold | Integer | `1` | Readiness probe success threshold. |
| probes.readiness.timeoutSeconds | Integer | `1` | Readiness probe timeout. |
| replicaCount | Optional | `1` | Replicas. Ref: https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#replicas |
| resources | Optional | `{"limits":{"cpu":"500m","memory":"500Mi"},"requests":{"cpu":"100m","memory":"50Mi"}}` | Resource requests and limits. Ref: http://kubernetes.io/docs/user-guide/compute-resources/ |
| secretName | Optional | `""` | Secret name to use. In case spotinst.token, spotinst.account are provided, this overrides the name of the created secret. |
| service.create | Optional | `true` | Controls whether a service should be created. |
| spotinst.account | Optional | `""` | Spot Account. Ref: https://docs.spot.io/administration/organizations?id=account |
| spotinst.clusterIdentifier | Optional | `""` | Unique identifier used by the Ocean Controller to connect between the Ocean backend and the Kubernetes cluster. Ref: https://docs.spot.io/ocean/tutorials/spot-kubernetes-controller/ |
| spotinst.token | Optional | `""` | Spot Token. Ref: https://docs.spot.io/administration/api/create-api-token |
| tolerations | Optional | `[{"key":"node-role.kubernetes.io/master","operator":"Exists"},{"key":"node-role.kubernetes.io/control-plane","operator":"Exists"}]` | Tolerations for nodes that have taints on them. Ref: https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/ |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.13.1](https://github.com/norwoodj/helm-docs/releases/v1.13.1)
