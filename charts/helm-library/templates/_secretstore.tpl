{{- define "helm-lib.deployment.secretstore" -}}
{{- if .Values.secretStore }}
apiVersion: external-secrets.io/v1
kind: SecretStore
metadata:
  name: {{ include "helm-lib.fullname" . }}
  labels:
    {{- include "helm-lib.labels" . | nindent 4 }}
  {{- with .Values.secretStore.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  {{- toYaml .Values.secretStore.spec | nindent 2 }}
{{- end }}
{{- end }}
