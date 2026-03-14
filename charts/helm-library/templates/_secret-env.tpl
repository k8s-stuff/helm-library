{{- define "helm-lib.deployment.secret-env" -}}
apiVersion: v1
kind: Secret
metadata:
  name: {{ include "helm-lib.secret-env-name" . }}
  annotations:
    helm.sh/hook: pre-upgrade, pre-install
    helm.sh/hook-weight: "-20"
data:
  {{- if .Values.extraSecretEnv }}
  {{- range $key, $value := .Values.extraSecretEnv }}
  {{$key}}: {{$value | toString | b64enc}}
  {{- end}}
  {{- end }}
{{- end }}
