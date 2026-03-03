{{/*
Expand the name of the chart.
*/}}
{{- define "helm-lib.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "helm-lib.fullname" -}}
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
{{- define "helm-lib.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "helm-lib.labels" -}}
helm.sh/chart: {{ include "helm-lib.chart" . }}
{{ include "helm-lib.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app: {{ include "helm-lib.name" . }}
version: {{ .Chart.AppVersion | quote }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "helm-lib.selectorLabels" -}}
app.kubernetes.io/name: {{ include "helm-lib.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "helm-lib.serviceAccountName" -}}
{{- if ((.Values.serviceAccount).create) }}
{{- default (include "helm-lib.fullname" .) (.Values.serviceAccount).name }}
{{- else }}
{{- default "default" (.Values.serviceAccount).name }}
{{- end }}
{{- end }}

{{- define "helm-lib.secret-env-name" -}}
{{- include "helm-lib.fullname" . }}-secret-env
{{- end }}

{{- define "helm-lib.secret-app-settings" -}}
{{- include "helm-lib.fullname" . }}-app-settings
{{- end }}


{{- define "helm-lib.secret-scripts" -}}
{{- include "helm-lib.fullname" . }}-secret-scripts
{{- end }}

{{- define "helm-lib.secret-authorities" -}}
{{- include "helm-lib.fullname" . }}-secret-authorities
{{- end }}

{{- define "helm-lib.secret-tls" -}}
{{- include "helm-lib.fullname" . }}-tls
{{- end }}

{{- define "helm-lib.is-flag-enabled-default-true" -}}
{{- if and . (hasKey . "enabled") -}}
{{- .enabled -}}
{{- else -}}
{{- printf "true" }}
{{- end -}}
{{- end -}}

{{- define "helm-lib.is-flag-enabled-default-false" -}}
{{- if hasKey . "enabled" -}}
{{- .enabled -}}
{{- else -}}
{{- printf "false" }}
{{- end -}}
{{- end -}}