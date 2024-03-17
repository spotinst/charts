{{/*
Expand the name of the chart.
*/}}
{{- define "ocean-network-client.name" -}}
{{- $values := (index .Values "ocean-network-client") -}}
{{- default "ocean-network-client" $values.name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ocean-network-client.fullname" -}}
{{- $values := (index .Values "ocean-network-client") -}}
{{- if $values.fullnameOverride }}
{{- $values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default (include "ocean-network-client.name" .) $values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ocean-network-client.labels" -}}
helm.sh/chart: {{ include "ocean-kubernetes-controller.chart" . }}
{{ include "ocean-network-client.selectorLabels" . }}
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
NodeSelector labels.
*/}}
{{- define "ocean-network-client.node-selector.labels" -}}
kubernetes.io/os: linux
{{- end }}

{{/*
Is Dev Environment
*/}}
{{- define "ocean-network-client.isDevEnv" }}
{{- if and .Values.spotinst.baseUrl (not (eq .Values.spotinst.baseUrl "ocean.api.spot.io:443")) -}}
true
{{- else -}}
false
{{- end }}
{{- end }}