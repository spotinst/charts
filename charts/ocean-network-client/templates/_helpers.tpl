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
{{- default (include "ocean-network-client.fullname" .) .Values.configMap.name -}}
{{- end -}}

{{/*
Secret name.
*/}}
{{- define "ocean-network-client.secretName" -}}
{{- default (include "ocean-network-client.fullname" .) .Values.secret.name -}}
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