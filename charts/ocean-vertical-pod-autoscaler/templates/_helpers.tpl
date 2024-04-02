{{/*
Expand the name of the chart.
*/}}
{{- define "ocean-vertical-pod-autoscaler.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ocean-vertical-pod-autoscaler.fullname" -}}
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
{{- define "ocean-vertical-pod-autoscaler.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ocean-vertical-pod-autoscaler.labels" -}}
helm.sh/chart: {{ include "ocean-vertical-pod-autoscaler.chart" . }}
{{ include "ocean-vertical-pod-autoscaler.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Values.podLabels }}
{{ toYaml .Values.podLabels }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "ocean-vertical-pod-autoscaler.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ocean-vertical-pod-autoscaler.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "ocean-vertical-pod-autoscaler.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "ocean-vertical-pod-autoscaler.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the name for the webhook tls secret
*/}}
{{- define "ocean-vertical-pod-autoscaler.webhook.secret" -}}
{{- if .Values.admissionController.secretName }}
{{- default (printf "%s-%s" (include "vpa.fullname" .) "tls-certs") (tpl (.Values.admissionController.secretName | toString) .) }}
{{- else }}
{{- printf "%s-%s" (include "vpa.fullname" .) "tls-certs" }}
{{- end }}
{{- end }}
