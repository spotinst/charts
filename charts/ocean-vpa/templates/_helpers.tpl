{{/*
Expand the name of the chart.
*/}}
{{- define "ocean-vpa.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ocean-vpa.fullname" -}}
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
{{- define "ocean-vpa.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ocean-vpa.labels" -}}
helm.sh/chart: {{ include "ocean-vpa.chart" . | trunc 63 | trimSuffix "-"}}
{{ include "ocean-vpa.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote | trunc 63 | trimSuffix "-"}}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service | trunc 63 | trimSuffix "-"}}
{{- if .Values.podLabels }}
{{ toYaml .Values.podLabels }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "ocean-vpa.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ocean-vpa.name" . | trunc 63 | trimSuffix "-"}}
app.kubernetes.io/instance: {{ .Release.Name | trunc 63 | trimSuffix "-"}}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "ocean-vpa.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "ocean-vpa.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the name for the webhook tls secret
*/}}
{{- define "ocean-vpa.webhook.secret" -}}
{{- if .Values.admissionController.secretName }}
{{- default (printf "%s-%s" (include "ocean-vpa.fullname" .) "tls-certs") (tpl (.Values.admissionController.secretName | toString) .) }}
{{- else }}
{{- printf "%s-%s" (include "ocean-vpa.fullname" .) "tls-certs" }}
{{- end }}
{{- end }}

{{/*
Create a delete secret command with the user's secret name
*/}}
{{- define "ocean-vpa.webhook.deleteSecretCommand" -}}
{{- printf "kubectl delete secret %s -n %s" (include  "ocean-vpa.webhook.secret" .) (.Release.Namespace | toString) }}
{{- end }}
