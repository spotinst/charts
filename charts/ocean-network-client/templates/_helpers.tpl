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
{{ default (include "ocean-network-client.name" .) .Values.namespace }}
{{- end }}

{{/*
ConfigMap name.
*/}}
{{- define "ocean-network-client.configMapName" -}}
{{ default (include "ocean-network-client.name" .) .Values.oceanController.configMapName }}
{{- end }}

{{/*
Secret name.
*/}}
{{- define "ocean-network-client.secretName" -}}
{{ default (include "ocean-network-client.name" .) .Values.oceanController.secretName }}
{{- end }}

{{/*
DaemonSet labels.
*/}}
{{- define "ocean-network-client.ds.labels" -}}
app: netflowd
{{- end }}

----
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
Create chart name and version as used by the chart label.
*/}}
{{- define "ocean-network-client.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ocean-network-client.labels" -}}
helm.sh/chart: {{ include "ocean-network-client.chart" . }}
{{ include "ocean-network-client.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "ocean-network-client.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ocean-network-client.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "ocean-network-client.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "ocean-network-client.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
