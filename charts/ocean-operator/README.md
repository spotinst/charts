# ocean-operator

![Version: 0.2.0](https://img.shields.io/badge/Version-0.2.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.2.0](https://img.shields.io/badge/AppVersion-0.2.0-informational?style=flat-square)

A Helm chart for Ocean Operator. This chart is usually invoked by the [spotctl](https://github.com/spotinst/spotctl) tool, but may also be run manually.

## Installation

1. Add the Spot Helm chart repository:

```sh
helm repo add spot https://charts.spot.io
```

2. Update your local Helm chart repository cache:

```sh
helm repo update
```

3. Install `ocean-operator`:

```sh
helm install my-release spot/ocean-operator \
  --set spotinst.token=REDACTED \
  --set spotinst.account=REDACTED \
  --set spotinst.clusterIdentifier=REDACTED \
  # [...]
```

> NOTE: Please configure all required chart values using the `set` command line argument or a `values.yaml` file.

## Values

| Key                        | Type   | Default                                                                                                                                                                       | Description                                                                                                                                                                                      |
| -------------------------- | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| affinity.nodeAffinity      | object | `{"preferredDuringSchedulingIgnoredDuringExecution":[{"preference":{"matchExpressions":[{"key":"spotinst.io/node-lifecycle","operator":"In","values":["od"]}]},"weight":1}]}` | (Optional) Node affinity.                                                                                                                                                                        |
| bootstrap.components       | list   | `["ocean-controller","metrics-server"]`                                                                                                                                       | (Optional) List of components to install during environment bootstrapping.                                                                                                                       |
| bootstrap.enabled          | bool   | `true`                                                                                                                                                                        | (Optional) Enable environment bootstrapping.                                                                                                                                                     |
| bootstrap.namespace        | string | `""`                                                                                                                                                                          | (Optional) Namespace where components should be installed during environment bootstrapping.                                                                                                      |
| extraArgs                  | list   | `[]`                                                                                                                                                                          | (Optional) Additional arguments. Ref: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container                                                                 |
| fullnameOverride           | string | `""`                                                                                                                                                                          | (Optional) String to fully override `ocean-operator.fullname` template.                                                                                                                          |
| image.pullPolicy           | string | `"IfNotPresent"`                                                                                                                                                              | (Optional) Image pull policy.                                                                                                                                                                    |
| image.pullSecrets          | list   | `[]`                                                                                                                                                                          | (Optional) Image pull secrets.                                                                                                                                                                   |
| image.repository           | string | `"gcr.io/spotinst-artifacts/ocean-operator"`                                                                                                                                  | (Optional) Image repository.                                                                                                                                                                     |
| image.tag                  | string | `""`                                                                                                                                                                          | (Optional) Image tag. Defaults to `.Chart.AppVersion`.                                                                                                                                           |
| nameOverride               | string | `""`                                                                                                                                                                          | (Optional) String to partially override `ocean-operator.fullname` template (will maintain the release name).                                                                                     |
| nodeSelector               | object | `{}`                                                                                                                                                                          | (Optional) Node selector.                                                                                                                                                                        |
| podAnnotations             | object | `{}`                                                                                                                                                                          | (Optional) Pod annotations. Ref: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/                                                                                  |
| podSecurityContext         | object | `{}`                                                                                                                                                                          | (Optional) Pod security context. Ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-pod                                              |
| replicaCount               | int    | `1`                                                                                                                                                                           | (Optional) Replicas. Ref: https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#replicas                                                                                         |
| resources                  | object | `{"limits":{"cpu":"500m","memory":"500Mi"},"requests":{"cpu":"50m","memory":"50Mi"}}`                                                                                         | (Optional) Resource requests and limits. Ref: http://kubernetes.io/docs/user-guide/compute-resources/                                                                                            |
| securityContext            | object | `{}`                                                                                                                                                                          | (Optional) Container security context. Ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container                                  |
| serviceAccount.annotations | object | `{}`                                                                                                                                                                          | (Optional) Service account annotations.                                                                                                                                                          |
| serviceAccount.create      | bool   | `true`                                                                                                                                                                        | (Optional) Controls whether a service account should be created.                                                                                                                                 |
| serviceAccount.name        | string | `"ocean-operator"`                                                                                                                                                            | (Optional) Service account name.                                                                                                                                                                 |
| spotinst.account           | string | `""`                                                                                                                                                                          | (Required) Spot Account. Ref: https://docs.spot.io/administration/organizations?id=account                                                                                                       |
| spotinst.acdIdentifier     | string | `""`                                                                                                                                                                          | (Optional) Unique identifier used by the Ocean AKS Connector when importing an AKS cluster. Ref: https://docs.spot.io/ocean/tutorials/connect-an-aks-private-cluster                             |
| spotinst.clusterIdentifier | string | `""`                                                                                                                                                                          | (Required) Unique identifier used by the Ocean Controller to connect between the Ocean backend and the Kubernetes cluster. Ref: https://docs.spot.io/ocean/tutorials/spot-kubernetes-controller/ |
| spotinst.token             | string | `""`                                                                                                                                                                          | (Required) Spot Token. Ref: https://docs.spot.io/administration/api/create-api-token                                                                                                             |
| tolerations                | list   | `[]`                                                                                                                                                                          | (Optional) Tolerations for nodes that have taints on them. Ref: https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/                                                          |

---

Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)
