{{/*
Expand the name of the chart.
*/}}
{{- define "ocean-network-client.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Namespace.
*/}}
{{- define "ocean-network-client.namespace" -}}
{{ .Release.Namespace }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ocean-network-client.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
ConfigMap name.
*/}}
{{- define "ocean-network-client.configMapName" -}}
{{- if include "ocean-network-client.createConfigMap" . -}}

{{/*
Validate oceanController.configMapName was not provided in case we need to create configMap.
*/}}
{{- if .Values.oceanController.configMapName -}}
{{- fail "oceanController.configMapName cannot be provided in case spotinst.controllerClusterId was provided. Please use configMapName instead" }}
{{- end -}}

{{- default (include "ocean-network-client.fullname" .) .Values.configMapName -}}
{{- else -}}
{{- default "spotinst-kubernetes-cluster-controller-config" (default .Values.oceanController.configMapName .Values.configMapName) -}}
{{- end -}}
{{- end -}}

{{/*
create ConfigMap.
*/}}
{{- define "ocean-network-client.createConfigMap" -}}
{{- if .Values.spotinst.clusterIdentifier -}}
{{- true -}}
{{- end -}}
{{- end -}}

{{/*
Secret name.
*/}}
{{- define "ocean-network-client.secretName" -}}
{{- if include "ocean-network-client.createSecret" . -}}

{{/*
Validate oceanController.secretName was not provided in case we need to create secret.
*/}}
{{- if .Values.oceanController.secretName -}}
{{- fail "oceanController.secretName cannot be provided in case spotinst.token or spotinst.account are provided. Please use secretName instead" }}
{{- end -}}

{{- default (include "ocean-network-client.fullname" .) .Values.secretName -}}
{{- else -}}
{{- default "spotinst-kubernetes-cluster-controller" (default .Values.oceanController.secretName .Values.secretName) -}}
{{- end -}}
{{- end -}}

{{/*
create Secret.
*/}}
{{- define "ocean-network-client.createSecret" -}}
{{- if or .Values.spotinst.token .Values.spotinst.account -}}
{{- true -}}
{{- end -}}
{{- end -}}

{{/*
DaemonSet labels.
*/}}
{{- define "ocean-network-client.daemon-set.labels" -}}
app: {{ (include "ocean-network-client.fullname" .) }}
{{- end }}

{{/*
NodeSelector labels.
*/}}
{{- define "ocean-network-client.node-selector.labels" -}}
kubernetes.io/os: linux
{{- end }}