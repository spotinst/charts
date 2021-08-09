{{/* vim: set filetype=mustache: */}}

{{/*
Chart name.
*/}}
{{- define "ocean-controller.name" -}}
spotinst-kubernetes-cluster-controller
{{- end }}

{{/*
Chart namespace.
*/}}
{{- define "ocean-controller.namespace" -}}
{{- default "kube-system" .Values.namespace }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "ocean-controller.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels.
*/}}
{{- define "ocean-controller.commonLabels" -}}
helm.sh/chart: {{ include "ocean-controller.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Controller selector labels.
*/}}
{{- define "ocean-controller.controllerLabels" -}}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/name: {{ include "ocean-controller.name" . }}
k8s-app: {{ include "ocean-controller.name" . }}
{{- end }}

{{/*
AKS Connector selector labels.
*/}}
{{- define "ocean-controller.aksConnectorLabels" -}}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/name: {{ include "ocean-controller.name" . }}-aks-connector
k8s-app: {{ include "ocean-controller.name" . }}-aks-connector
{{- end }}

{{/*
Priority class name.
*/}}
{{- define "ocean-controller.priorityClassName" -}}
{{- if eq (include "ocean-controller.namespace" .) "kube-system" -}}
system-cluster-critical
{{- else -}}
spotinst-cluster-critical
{{- end -}}
{{- end }}

{{/*
ConfigMap name.
*/}}
{{- define "ocean-controller.configMapName" -}}
{{ include "ocean-controller.name" . }}-config
{{- end }}

{{/*
Secret name.
*/}}
{{- define "ocean-controller.secretName" -}}
{{ include "ocean-controller.name" . }}
{{- end }}

{{/*
Service account name.
*/}}
{{- define "ocean-controller.serviceAccountName" -}}
{{ include "ocean-controller.name" . }}
{{- end }}

{{/*
Cluster role name.
*/}}
{{- define "ocean-controller.clusterRoleName" -}}
{{ include "ocean-controller.name" . }}
{{- end }}

{{/*
Cluster role binding name.
*/}}
{{- define "ocean-controller.clusterRoleBindingName" -}}
{{ include "ocean-controller.name" . }}
{{- end }}

{{/*
Deployment name.
*/}}
{{- define "ocean-controller.deploymentName" -}}
{{ include "ocean-controller.name" . }}
{{- end }}

{{/*
AKS Connector job name.
*/}}
{{- define "ocean-controller.aksConnectorJobName" -}}
{{ include "ocean-controller.name" . }}-aks-connector
{{- end }}
