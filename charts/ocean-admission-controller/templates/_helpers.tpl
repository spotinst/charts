{{/*
Expand the name of the chart.
*/}}
{{- define "ocean-admission-controller.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ocean-admission-controller.fullname" -}}
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
{{- define "ocean-admission-controller.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Standard labels that are applied to all resources.
Does not include component-specific labels.
*/}}
{{- define "ocean-admission-controller.standardLabels" -}}
helm.sh/chart: {{ include "ocean-admission-controller.chart" . }}
app.kubernetes.io/name: {{ include "ocean-admission-controller.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{- end }}

{{/*
Selector labels for the main admission controller.
*/}}
{{- define "ocean-admission-controller.controllerSelectorLabels" -}}
app.kubernetes.io/component: ocean-admission-controller
{{- end }}

{{/*
Common labels for the main admission controller components.
Includes standard labels, controller selector labels, and custom pod labels.
*/}}
{{- define "ocean-admission-controller.controllerLabels" -}}
{{ include "ocean-admission-controller.standardLabels" . }}
{{ include "ocean-admission-controller.controllerSelectorLabels" . }}
{{- if .Values.controller.podLabels }}
{{ toYaml .Values.controller.podLabels }}
{{- end }}
{{- end }}

{{/*
Labels for the cert-gen components.
Includes standard labels and the cert-gen component label.
*/}}
{{- define "ocean-admission-controller.certgenLabels" -}}
{{ include "ocean-admission-controller.standardLabels" . }}
app.kubernetes.io/component: ocean-admission-certgen
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "ocean-admission-controller.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "ocean-admission-controller.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the name for the controller tls secret or default generated
*/}}
{{- define "ocean-admission-controller.controller.tlsSecretName" -}}
{{- $default := print (include "ocean-admission-controller.fullname" .) "-tls-secret" -}}
{{- default $default .Values.controller.tlsSecretName -}}
{{- end }}

{{/*
Return the TLS certificate name
*/}}
{{- define "ocean-admission-controller.controller.secret.certName" -}}
tls.crt
{{- end }}

{{/*
Return the TLS private name
*/}}
{{- define "ocean-admission-controller.controller.secret.keyName" -}}
tls.key
{{- end }}

{{/*
Create a delete secret command with the user\'s secret name
*/}}
{{- define "ocean-admission-controller.controller.deleteSecretCommand" -}}
{{- printf "kubectl delete secret %s -n %s" (include  "ocean-admission-controller.controller.tlsSecretName" .) (.Release.Namespace | toString) }}
{{- end }}

{{/*
ConfigMap name.
*/}}
{{- define "ocean-admission-controller.configMapName" -}}
{{ default (include "ocean-admission-controller.fullname" .) .Values.controller.configMap.name }}
{{- end }}


