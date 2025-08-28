# ocean-admission-controller

![Version: 1.0.1](https://img.shields.io/badge/Version-1.0.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.2.0](https://img.shields.io/badge/AppVersion-0.2.0-informational?style=flat-square)

A Kubernetes admission controller for pod defaulting and validation.

## Installation

1. Add the Spot Helm chart repository:

```sh
helm repo add spot https://charts.spot.io
```

2. Update your local Helm chart repository cache:

```sh
helm repo update
```

3. Install `ocean-admission-controller`:

```sh
helm install my-release spot/ocean-admission-controller
```

## Requirements

Kubernetes: `>=1.22.0-0`

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| controller.affinity | object | `{}` | Affinity rules for the admission controller pod |
| controller.certDir | string | `"/etc/certs"` | Directory where TLS certificates are mounted for the webhook server |
| controller.certGen.affinity | object | `{}` | Affinity rules for the certgen pod |
| controller.certGen.env | object | `{}` | Additional environment variables to be added to the certgen container. Format is KEY: Value format |
| controller.certGen.image.pullPolicy | string | `"Always"` | The pull policy for the certgen image. Recommend not changing this |
| controller.certGen.image.repository | string | `"registry.k8s.io/ingress-nginx/kube-webhook-certgen"` | An image that contains certgen for creating certificates. Only used if controller.generateCertificate is true |
| controller.certGen.image.tag | string | `"v1.4.4"` | An image tag for the controller.certGen.image.repository image. Only used if controller.generateCertificate is true |
| controller.certGen.nodeSelector | object | `{}` | Node selector for the certgen pod |
| controller.certGen.resources | object | `{}` | The resources block for the certgen pod |
| controller.certGen.securityContext | object | `{}` | The securityContext block for the certgen pod |
| controller.certGen.tolerations | list | `[]` | Tolerations for the certgen pod |
| controller.configMap | object | `{"create":true,"name":""}` | ConfigMap configuration for the admission controller |
| controller.configMap.create | bool | `true` | Whether to create a ConfigMap for the admission controller |
| controller.configMap.name | string | `""` | Name of the ConfigMap. If empty, uses the default name |
| controller.generateCertificate | bool | `true` | If true and controller is enabled, a pre-install hook will run to create the certificate for the controller |
| controller.healthProbeAddr | string | `":8082"` | Address the controller binds to for Kubernetes liveness/readiness probes |
| controller.httpPort | int | `9443` | Port of the admission controller for the mutating webhooks |
| controller.image.pullPolicy | string | `"Always"` | The pull policy for the admission controller image. Recommend not changing this |
| controller.image.repository | string | `"gcr.io/spotit-today/spot-ocean-admission-controller"` | The location of the vpa admission controller image |
| controller.image.tag | string | `"0.2.0"` | Overrides the image tag whose default is the chart appVersion |
| controller.leaderElection | bool | `false` | Enable Kubernetes leader election for high availability setups |
| controller.metricsAddr | string | `":8080"` | Address the controller binds to for Prometheus metrics |
| controller.mutatingWebhookConfiguration.admissionReviewVersions | list | `["v1","v1beta1"]` | List of admission review versions |
| controller.mutatingWebhookConfiguration.annotations | object | `{}` | Additional annotations for the MutatingWebhookConfiguration. Can be used for integration with cert-manager |
| controller.mutatingWebhookConfiguration.sideEffects | string | `"None"` | Side effects for webhook (None, NoneOnDryRun) |
| controller.mutatingWebhookConfiguration.timeoutSeconds | int | `30` | Timeout for webhook calls in seconds |
| controller.nodeSelector | object | `{}` | Node selector for the admission controller pod |
| controller.podAnnotations | object | `{}` | Annotations to add to the admission controller pod |
| controller.podDiskTypeNodeSelectorDefaulter | object | `{"enable":true}` | Pod Node Affinity Defaulter configuration for GKE |
| controller.podDiskTypeNodeSelectorDefaulter.enable | bool | `true` | Enable the Pod Disk Type Node Selector Defaulter for GKE |
| controller.podLabels | object | `{}` | Labels to add to the admission controller pod |
| controller.podSecurityContext | object | `{"runAsNonRoot":true,"runAsUser":65534,"seccompProfile":{"type":"RuntimeDefault"}}` | The security context for the admission controller pod |
| controller.podTolerationDefaulter | object | `{"enable":false}` | Pod Toleration Defaulter configuration for AKS |
| controller.podTolerationDefaulter.enable | bool | `false` | Enable the Pod Toleration Defaulter for AKS |
| controller.replicaCount | int | `1` | Number of replicas for the admission controller |
| controller.resources | object | `{"limits":{"memory":"500Mi"},"requests":{"cpu":"50m","memory":"200Mi"}}` | The resources block for the admission controller pod |
| controller.securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"readOnlyRootFilesystem":true,"runAsNonRoot":true,"seccompProfile":{"type":"RuntimeDefault"}}` | The security context for the admission controller manager container |
| controller.tlsSecretName | string | `""` |  |
| controller.tolerations | list | `[]` | Tolerations for the admission controller pod |
| fullnameOverride | string | `"admission-controller"` | A template override for the fullname |
| imagePullSecrets | list | `[]` | A list of image pull secrets to be used for all pods |
| nameOverride | string | `""` | A template override for the name |
| priorityClassName | string | `""` | To set the priorityclass for all pods |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service accounts for each component |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created for each component |
| serviceAccount.name | string | `""` | The base name of the service account to use (appended with the component). If not set and create is true, a name is generated using the fullname template and appended for each component |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.13.1](https://github.com/norwoodj/helm-docs/releases/v1.13.1)