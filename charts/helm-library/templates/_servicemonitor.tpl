{{/*
ServiceMonitor template
Requires Prometheus Operator CRDs to be installed
*/}}
{{- define "helm-lib.deployment.servicemonitor" -}}
{{- if (.Values.serviceMonitor).enabled }}
---
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: {{ include "helm-lib.fullname" . }}
  labels:
    {{- include "helm-lib.labels" . | nindent 4 }}
    {{- with .Values.serviceMonitor.labels }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
  {{- with .Values.serviceMonitor.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  selector:
    matchLabels:
      {{- include "helm-lib.selectorLabels" . | nindent 6 }}
  endpoints:
  {{- range .Values.serviceMonitor.endpoints }}
    - port: {{ .port }}
      {{- with .path }}
      path: {{ . }}
      {{- end }}
      {{- with .interval }}
      interval: {{ . }}
      {{- end }}
      {{- with .scrapeTimeout }}
      scrapeTimeout: {{ . }}
      {{- end }}
      {{- with .scheme }}
      scheme: {{ . }}
      {{- end }}
      {{- with .params }}
      params:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with .honorLabels }}
      honorLabels: {{ . }}
      {{- end }}
      {{- with .metricRelabelings }}
      metricRelabelings:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with .relabelings }}
      relabelings:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with .tlsConfig }}
      tlsConfig:
        {{- toYaml . | nindent 8 }}
      {{- end }}
  {{- end }}
{{- end }}
{{- end }}
